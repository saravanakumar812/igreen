import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';
import '../api_connect/api_connect.dart';
import '../model/CompletedProjectResponse.dart';
import '../model/responseModel/GetFactoryProjectReviewResponse.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class ProjectReviewController extends GetxController {
  bool isComplete = false;
  int i = 0;
  String? recordFilePath = "";
  late menuDataProvider userDataProvider;
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  TextEditingController messageController = TextEditingController();
  RxBool isSelected = RxBool(false);
  RxList<CompletedProjectData> completedData = RxList();
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  GetFactoryProjectData factoryData = GetFactoryProjectData();

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    getFactoryProject();
    completedProject();
  }

  Future<void> refreshData() async {
    getFactoryProject();

    return Future.delayed(Duration(seconds: 2));
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath!, (type) {});
    } else {}
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

  Future<void> getFactoryProject() async {
    Map<String, dynamic> payload = {
      'ProjectId': userDataProvider.getApprovalData!.projectId.toString()
    };
    print("getFactoryProject:$payload");
    var response = await _connect.getReviewApproval(payload);
    debugPrint("getFactoryProject: ${response.toJson()}");
    if (!response.error!) {
      factoryData = response.data!;
      update();
    } else {}
  }

  Future<void> managerApproval() async {
    if (firstValidation()) {
      Map<String, dynamic> payload = {
        'ProjectId': factoryData.projectId,
        'EmployeeId': AppPreference().getEmpId.toString(),
        'DepartmentId': factoryData.departmentId,
        'ProjectApproval': 2,
        'ProjectUpdates': messageController.text
      };
      print("managerApproval:$payload");
      var response = await _connect.managerApproval(payload);
      debugPrint("managerApproval: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.projectReview.toName);
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
  }

  Future<void> completedProject() async {
    Map<String, dynamic> payload = {
      'ProjectId': userDataProvider.getApprovalData!.projectId.toString(),
    };
    print("completedProject:$payload");
    var response = await _connect.completedProjectCall(payload);
    debugPrint("completedProject: ${response.toJson()}");
    if (!response.error!) {
      completedData.value = response!.data!;
    } else {}
  }
}
