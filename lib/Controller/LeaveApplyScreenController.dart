import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/GetAllAppliedLeaveResponse.dart';
import '../provider/menuProvider.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class LeaveApplyScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxBool isExpanded = false.obs;
  int i = 0;
  String? recordFilePath = "";
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  RxBool isRejectVisible = RxBool(false);
  bool isComplete = false;
  RxString audioValues = RxString('');
  TextEditingController reasonController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    setAudioData();
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

  Future<void> leaveApprove() async {
    Map<String, dynamic> payload = {
      'id': userDataProvider.getLeaveDataValues!.id.toString(),
    };
    print('object:$payload');
    var response = await _connect.leaveApproveCall(payload);
    debugPrint("rentUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {}
  }

  Future<void> leaveReject() async {
    Map<String, dynamic> payload = {
      'id': userDataProvider.getLeaveDataValues!.id.toString(),
      'reject_voice_note': '1',
      'reject_reason': reasonController.text,
    };
    print('object:$payload');
    var response = await _connect.leaveRejectCall(payload);
    debugPrint("rentUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {}
  }

  setAudioData() {
    AppliedLeaveData data = userDataProvider.getLeaveDataValues!;
    audioValues.value = data.voiceNote ?? "";
  }
}
