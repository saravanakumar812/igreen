import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import '../Utils/image_picker.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/ParticularTaskResponse.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class NonProjectListControllerScreen extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<ParticularData> taskData = RxList();
  RxInt taskIdValue = RxInt(0);
  TextEditingController remarksController = TextEditingController();
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  Rx<PickedImage?> itemImageStart = Rx<PickedImage?>(null);
  Rx<PickedImage?> itemImageEnd = Rx<PickedImage?>(null);
  RxBool pickImageSelected = false.obs;
  String? recordFilePath = "";
  late AudioPlayer audioPlayer;
  bool isComplete = false;
  RxBool isAudio = RxBool(false);
  int i = 0;
  Future<void> refreshData() async {
    particularTask();
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      particularTask();
      isCall = true;
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
    return "$sdPath/test_${i++}.mp3";
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      if (recordFilePath != null && File(recordFilePath!).existsSync()) {
        File(recordFilePath!).deleteSync();
      }
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath!, (type) {});
    } else {}
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      isComplete = true;
    }
  }

  void play() {
    if (recordFilePath != null && File(recordFilePath!).existsSync()) {
      audioPlayer.setFilePath(recordFilePath!);
      audioPlayer.play();
    }
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
    Map<String, String> payload = {
      'TaskStatus': task,
      'TaskId': taskData[taskIdValue.value].taskId.toString(),
      'Remarks': remarksController.text

    };
    print('updateCompleteTask:$payload');
    var response = await _connect.imgTaskUpload( ApiUrl.updateTask,  itemImagePick.value!.file , payload, recordFilePath ?? "");
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
  Future<void> updateStartedTask(String task) async {
    Map<String, dynamic> payload = {
      'TaskStatus': task,
      'TaskId': taskData[taskIdValue.value].taskId.toString(),
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
