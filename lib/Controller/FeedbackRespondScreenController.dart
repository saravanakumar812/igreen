import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../provider/menuProvider.dart';
import 'package:just_audio/just_audio.dart';

import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

import '../routes/app_routes.dart';

class FeedbackRespondScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  int i = 0;
  TextEditingController reasonController = TextEditingController();

  RxString? recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  RxBool isRejectVisible = RxBool(false);
  bool isComplete = false;
  RxString audioValues = RxString('');
  bool isCall = false;

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    // setAudioData();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
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

  Future<void> feedback() async {
    if (secondValidation()) {
      Map<String, String> payload = {
        'FeedbackId':
            userDataProvider.feedbackValues!.feedbackId.toString(),
        'Messages': reasonController.text,
        'AudioFile': '',
        'Status': '1',
      };
      print('feedbackPayload : $payload');
      var response = await _connect.feedback(ApiUrl.feedbackRespond, payload, recordFilePath!.value ??"");
      debugPrint("feedbackResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        Get.offNamed(AppRoutes.feedbacks.toName);
      } else {}
    }
  }
}
