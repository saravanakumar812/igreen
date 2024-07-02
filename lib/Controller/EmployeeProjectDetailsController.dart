import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:provider/provider.dart';
import '../Utils/image_picker.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/CompletedProjectResponse.dart';
import '../provider/menuProvider.dart';
import 'package:just_audio/just_audio.dart';

import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class EmployeeProjectDetailsController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool isSelected = RxBool(false);
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  int i = 0;
  RxBool isLoading = RxBool(false);
  RxBool completeVisible = RxBool(false);
  RxnInt empId = RxnInt(0);
  RxString? recordFilePath = RxString('');
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  RxBool isRejectVisible = RxBool(false);
  bool isComplete = false;
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(
      imagePath: null,
      file: null,
      renderType: RenderImage.platform,
      extension: '',
      base64: ''));
  RxBool pickImageSelected = false.obs;
  RxString imagePathFromData = RxString("");
  RxBool isUpdateImageAvailable = false.obs;
  List<String> updateValues = [
    'Daily Update',
    'Complete Update',
  ];
  RxBool updateDropDown = RxBool(false);
  TextEditingController updateController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  RxList<CompletedProjectData> completedData = RxList();
  RxString customerName = RxString('');
  RxInt factoryUpdatesIndex = RxInt(0);
  RxInt factoryCompleteIndex = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();

    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      completedProject();
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
    }
  }


  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {}
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {}
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {}
    }
  }

  Future<void> refreshData() async {
    completedProject();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> completedProject() async {
    Map<String, dynamic> payload = {
      'ProjectId': userDataProvider.getFactoryProjectData!.projectId.toString(),
    };
    print("completedProject:$payload");
    var response = await _connect.completedProjectCall(payload);
    debugPrint("completedProject: ${response.toJson()}");
    if (!response.error!) {
      completedData.value = response!.data!;
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.red,
      );
    }
  }

  bool firstValidation() {
    if (messageController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Messages!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  Future<void> factoryUpdates() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'ProjectId':
            userDataProvider.getFactoryProjectData!.projectId.toString(),
        'EmployeeId': AppPreference().getEmpId.toString(),
        'ProjectUpdates': messageController.text,
        'FileUpload': '',
        'VoiceNote': '',
        'DepartmentId':
            userDataProvider.getFactoryProjectData!.departmentId.toString(),
      };
      print('factoryUpdates:$payload');
      var response = await _connect.imgIdeasUpload(ApiUrl.factoryUpdate , itemImagePick.value.file ,payload , recordFilePath!.value ?? "");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        // Get.offNamed(AppRoutes.fuelSummary.toName);
      }
    }
  }

  Future<void> factoryCompletion() async {
    if (firstValidation()) {
      Map<String, dynamic> payload = {
        'StartDate': startDateController.text,
        'EndDate': endDateController.text,
        'ProjectUpdates': messageController.text,
        'ProjectId':
            userDataProvider.getFactoryProjectData!.projectId.toString(),
        'EmployeeId': AppPreference().getEmpId.toString(),
        'DepartmentId':
            userDataProvider.getFactoryProjectData!.departmentId.toString(),
      };
      print('factoryCompletion:$payload');
      var response = await _connect.factoryCompletionCall(payload);
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        // Get.offNamed(AppRoutes.fuelSummary.toName);
      } else {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    }
  }
}
