import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/EscalationRespondRequestModel.dart';
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

class EscalationPendingScreenController extends GetxController {
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
  RxList<EscalationRespondData> getEscalationData = RxList();


  RxString employeeMessageValue = RxString('');
  RxString respondMessageValue = RxString('');
  RxString respondAudioValue = RxString('');
  RxString employeeAudioValue = RxString('');
  RxString employeeImageValue = RxString('');

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);

    if (!isCall) {
      isCall = true;
      escalationRespond();
      if(userDataProvider
          .getEscalationListValues!.audioFile!.isEmpty){
        isAudio.value = false;
      }
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
    audioPlayer.setUrl("${ApiUrl.baseUrl}escalation/${userDataProvider
          .getEscalationListValues!.audioFile}");
      audioPlayer.play();

    print("auudio: ${ApiUrl.baseUrl}escalation/${userDataProvider
        .getEscalationListValues!.audioFile}");

  }
  void play1() {
    audioPlayer.setUrl("${ApiUrl.baseUrl}escalation/${userDataProvider
          .getEscalationListValues!.respondAudio}");
      audioPlayer.play();

    print("auudio: ${ApiUrl.baseUrl}escalation/${userDataProvider
        .getEscalationListValues!.respondAudio}");

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

  setAudioData() {
    EscalationValues data = userDataProvider.getEscalationListValues!;
    audioValues.value = data.audioFile ?? "";
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

  Future<void> escalationRespond() async {

    Map<String, dynamic> payload = {
      'EscalationId':
      userDataProvider.escalationListValues!.escalationId.toString(),

    };
    print('object:$payload');
    var response = await _connect.escalationRespondCall(  payload);
    debugPrint("escalationApprovalResponse: ${response.toJson()}");
    if (!response.error!) {
      employeeMessageValue.value = response!.data![0]!.employeeMessage ?? "";
      employeeAudioValue.value = response!.data![0]!.employeeAudioFile ?? "";
      employeeImageValue.value = response!.data![0]!.employeeImage ?? "";
      respondMessageValue.value = response!.data![0]!.respondMessages ?? "";
      respondAudioValue.value = response!.data![0]!.respondAudioFile?? "";
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );

      Get.offNamed(AppRoutes.escalationThree.toName);
    } else {}
  }

// Future<void> escalationApproval() async {
//   if (secondValidation()) {
//     Map<String, String> payload = {
//       'EscalationId':
//       userDataProvider.escalationValues!.escalationId.toString(),
//       'Messages': reasonController.text,
//       'AudioFile': '',
//       'Status': '1',
//     };
//     print('object:$payload');
//     var response = await _connect.escalationApproval( ApiUrl.escalationApproval, payload, recordFilePath ?? "");
//     debugPrint("escalationApprovalResponse: ${response.toJson()}");
//     if (!response.error!) {
//       Fluttertoast.showToast(
//         msg: response.message!,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.black,
//         textColor: Colors.white,
//       );
//
//       Get.offNamed(AppRoutes.escalationOne.toName);
//     } else {}
//   }
// }
}


