import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '../Utils/AppPreference.dart';
import '../Utils/image_picker.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/GetAllUserResponse.dart';
import '../model/responseModel/ParticularTaskResponse.dart';
import '../provider/menuProvider.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

import '../routes/app_routes.dart';

class GreenThankResponseData {
  String? employeeName;
  int? amount;
  String? remarks;
  String? employeeId;

  GreenThankResponseData(
      {this.employeeName, this.amount, this.remarks, this.employeeId});

  GreenThankResponseData.fromJson(Map<String, dynamic> json) {
    employeeName = json['employeeName'];
    amount = json['amount'];
    remarks = json['remarks'];
    employeeId = json['employeeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeName'] = this.employeeName;
    data['amount'] = this.amount;
    data['remarks'] = this.remarks;
    data['employeeId'] = this.employeeId;
    return data;
  }
}
class Autogenerated {
  String? employeeName;
  String? amount;
  String? remarks;
  String? employeeId;

  Autogenerated(
      {this.employeeName, this.amount, this.remarks, this.employeeId});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    employeeName = json['employeeName'];
    amount = json['amount'];
    remarks = json['remarks'];
    employeeId = json['employeeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeName'] = this.employeeName;
    data['amount'] = this.amount;
    data['remarks'] = this.remarks;
    data['employeeId'] = this.employeeId;
    return data;
  }
}




class GreenThankController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxList<GreenThankResponseData> greenThankList = RxList() ;
  //RxList<TextEditingController> controllers =  RxList();
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<ParticularData> taskData = RxList();
  RxInt taskIdValue = RxInt(0);
  RxBool popUpValue = RxBool(false);
  RxBool selectPerson = RxBool(false);
  RxList<bool> selectEmployee = RxList();
  final FocusNode amountFocusNode = FocusNode();

  TextEditingController selectPersonController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  RxList<GetUserData> userData = RxList();
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  RxBool pickImageSelected = false.obs;
  RxList<bool> onClickList = RxList();
  List <TextEditingController> controllers = [];

  int amountAdd = 0;



  bool isComplete = false;
  int i = 0;
  RxString? recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  RxBool isAdding = RxBool(false);
  Future<void> refreshData() async {
    getUser();
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();

    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getUser();
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

  getUser() async {
    isLoading.value = true;
    var response = await _connect.getUserCall();
    isLoading.value = false;
    if (!response.error!) {
      userData.value = response.data!;
      debugPrint("getUser: ${response.toJson()}");
      onClickList.clear();

      for (int i = 0; i < response.data!.length; i++) {
        controllers.add(TextEditingController());
        onClickList.add(false);



      }
    } else {}
  }
  bool firstValidation() {
    if (totalAmountController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Amount!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }  if (controllers.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Controllers!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> insertGreenThankCall() async {
    // GreenThankResponseData list = GreenThankResponseData();
    // list.amount = int.parse(amountController.text.isNotEmpty? amountController.text: "0");
    // list.employeeName = selectPersonController.text;
    // list.remarks = messageController.text;
    // list.employeeId = AppPreference().getEmpId.toString();
    // greenThankList.add(list);
    // selectEmployee.add(false);
    if (firstValidation()) {
      GreenThankResponseData list = GreenThankResponseData();
      list.amount = int.parse(amountController.text.isNotEmpty? amountController.text: "0");
      list.employeeName = selectPersonController.text;
      list.remarks = messageController.text;
      list.employeeId = AppPreference().getEmpId.toString();
      greenThankList.add(list);
      selectEmployee.add(false);
    Map<String, String> payload = {
      'totalAmount':totalAmountController.text,
      'greenThanksEmployee':json.encode(greenThankList),

    };

    print(json.encode(greenThankList));
    print("GreenInsertPayload:$payload");
    var response = await _connect.imgTaskUpload(ApiUrl.insertGreenThank,  itemImagePick.value!.file , payload, recordFilePath!.value ?? "");
    debugPrint("GreenInsertResponse: ${response.toJson()}");
    //checkDataMap.addAll(payload);

    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.hRMSHome.toName);
      greenThankList.clear();
    } else
          () {};}
  }




}