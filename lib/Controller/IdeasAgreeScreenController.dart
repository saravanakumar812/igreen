
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../Utils/AppPreference.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/EscalationRespondRequestModel.dart';
import '../model/GetOnDutyEmployeeIdResponse.dart';
import '../model/IdealogyResponseModel.dart';
import '../model/IdeasUserDataResponse.dart';
import '../model/responseModel/EscalationPostResponse.dart';
import '../model/responseModel/GetEscalationResponse.dart';
import '../provider/menuProvider.dart';
import 'package:just_audio/just_audio.dart';

import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

import '../routes/app_routes.dart';

class IdeasAgreeScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxString audioValues = RxString('');
  TextEditingController reasonController = TextEditingController();
  RxBool isLoading = RxBool(false);
  RxBool isExpanded = RxBool(false);
  int i = 0;
  String? recordFilePath = "";
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  RxBool isRejectVisible = RxBool(false);
  bool isComplete = false;
  RxList<IdeaLogyUserResponseData> ideologyData = RxList();
  RxList<IdeasEmployeeResponseData> ideologyEmployeeData = RxList();





  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      //getEmployeeIdeaLogy() ;
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


      print("auudio: ${ApiUrl.baseUrl}ideas/${userDataProvider
          .getIdeaLogyEmployeeData!.audioFile}");
      audioPlayer.setUrl("${ApiUrl.baseUrl}ideas/${userDataProvider
          .getIdeaLogyEmployeeData!.audioFile}");
      audioPlayer.play();


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



  bool secondValidation() {
    if (reasonController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Reason!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }
  Future<void> addAgreeIdeas() async {

    Map<String, dynamic> payload = {
      'ideasId':userDataProvider.getIdeaLogyEmployeeData!.id.toString() ,
      'agree': userDataProvider.currentStatus == "Agree" ? "Agree" : "DisAgree",
      'employeeName':  AppPreference().getEmpName,

    };
    print("AddIdeaPayload:$payload");
    var response = await _connect.addAgreeCall(payload);
    debugPrint("AddIdeaResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      //Get.offNamed(AppRoutes.ideaLogySummary.toName);
      // Get.deleteAll();
    } else
          () {};
  }
  // Future<void> getEmployeeIdeaLogy() async {
  //   isLoading.value = true;
  //   Map<String, dynamic> payload = {
  //     'employeeName' :  AppPreference().getEmpName
  //   };
  //   var response = await _connect.getEmployeeNameIdeaLogyCall(payload);
  //   isLoading.value = false;
  //   if (!response.error!) {
  //     ideologyEmployeeData.value = response.data!;
  //     //update();
  //     if (response.data!.isEmpty) {
  //       // Get.toNamed(AppRoutes.foodEntryScreen.toName);
  //     } else {}
  //   } else {
  //     // Get.toNamed(AppRoutes.foodEntryScreen.toName);
  //   }
  // }
}


