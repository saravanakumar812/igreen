import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import '../Utils/AppPreference.dart';
import '../Utils/image_picker.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/EventsList.dart';
import '../model/responseModel/ParticularTaskResponse.dart';
import '../provider/menuProvider.dart';

class TaskViewController extends GetxController {
  RxBool isAudio = RxBool(false);
  RxList<ParticularData> taskData = RxList();
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  final ApiConnect _connect = Get.put(ApiConnect());
  RxInt taskIdValue = RxInt(0);
  RxBool pickImageSelected = false.obs;
  int i = 0;
  TextEditingController remarksController = TextEditingController();
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<EventData> eventData = RxList();
  RxString editButtonText = RxString('Reject');
  RxString reuseButtonText = RxString('View');
  bool isCall = false;
  bool isComplete = false;
  late AudioPlayer audioPlayer;
  RxString? recordFilePath = RxString("");
  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      particularTask();
    }
  }
  Future<bool> checkPermission() async {
    Map<Permission, PermissionStatus> permissions =
    await [Permission.storage, Permission.microphone].request();
    print(permissions[Permission.microphone]);
    return permissions[Permission.microphone] == PermissionStatus.granted;
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "//$sdPath/test_${i++}.mp3";
  }

  void startRecord() async {
    audioPlayer = AudioPlayer();

    bool hasPermission = await checkPermission();
    if (hasPermission) {
      if (recordFilePath != null && File(recordFilePath!.value).existsSync()) {
        File(recordFilePath!.value).deleteSync();
        print("record1$recordFilePath");
      }

      if (userDataProvider.currentStatus == "Edit" ||
          userDataProvider.currentStatus == "Re-Use") {
        if (recordFilePath != null &&
            File(recordFilePath!.value).existsSync()) {
          File(recordFilePath!.value).deleteSync();
        }
      }

      recordFilePath!.value = await getFilePath();
      print("record2$recordFilePath");
      isComplete = false;
      RecordMp3.instance.start(recordFilePath!.value, (type) {});
      isAudio.value = false;
      isAudio.value = true;
    } else {}
  }
  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      isComplete = true;
    }
  }
  void deleteOldData() async {
    File(recordFilePath!.value).deleteSync();
    print("delete1$recordFilePath");
    recordFilePath!.value = "";
    print("delete2$recordFilePath");
    isComplete = false;
    isAudio.value = false;
  }
  void play() {
    if (recordFilePath != null && File(recordFilePath!.value).existsSync()) {
      audioPlayer.setFilePath(recordFilePath!.value);
      audioPlayer.play();
    } else if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      audioPlayer.setUrl("${ApiUrl.baseUrl}ideas/${userDataProvider
          .getOnDutyEmployeeData!.audioFile}");
      audioPlayer.play();
    }
  }

  Future<void> refreshData() async {
    particularTask();
    return Future.delayed(Duration(seconds: 0));
  }
bool firstValidation()  {
  if (remarksController.value.text.isEmpty) {
    Fluttertoast.showToast(
      msg: "Please Enter Remarks!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
    return false;
  }
  return true;
}
  Future<void> particularTask() async {
    Map<String, dynamic> payload = {
      'departmentId': AppPreference().getDepId.toString(),
      'employeeId': AppPreference().getEmpId.toString(),
    };
    print('particularTask:$payload');
    var response = await _connect.particularTaskCall(payload);
    if (!response.error!) {
      taskData.value = response!.data!;
      debugPrint("particularTaskResponse: ${response.toJson()}");
    }
  }

  Future<void> updateCompleteTask(String task) async {
    if(firstValidation()){


    Map<String, String> payload = {
      'TaskStatus': task,
      'TaskId': userDataProvider.getTaskViewData!.taskId.toString(),
      'Remarks': remarksController.text

    };
    print('updateCompleteTask:$payload');
    var response = await _connect.imgTaskUpload( ApiUrl.updateTask,  itemImagePick.value!.file , payload, recordFilePath!.value ?? "");
    debugPrint("updateTask: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response!.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      particularTask();
      Get.back();
    }}
  }
  Future<void> updateStartedTask(String task) async {
    Map<String, dynamic> payload = {
      'TaskStatus': task,
      'TaskId': userDataProvider.getTaskViewData!.taskId.toString(),
      'Images':'',
      'AudioFile': "",
      'Remarks': '',
    };
    print('updateStartedTask:$payload');
    var response = await _connect.updateTaskCall(payload);
    debugPrint("updateTask: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response!.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      particularTask();
    }
  }
}
