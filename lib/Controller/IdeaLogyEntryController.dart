import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:igreen_flutter/model/IdealogyResponseModel.dart';
import 'package:provider/provider.dart';
//import 'package:record/record.dart';

import '../../../Utils/AppPreference.dart';
import '../../../Utils/image_picker.dart';
import '../../../api_connect/api_connect.dart';
import '../../../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../../../model/responseModel/FuelSubCategoryResponse.dart';
import '../../../provider/menuProvider.dart';
import '../api_config/ApiUrl.dart';
import '../model/IdeasUserDataResponse.dart';
import '../model/responseModel/EmployeeNameResponseModel.dart';
import '../model/responseModel/GeneralSummaryList.dart';
import '../routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class IdeaLogyEntryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxInt selectedSub1Index = RxInt(0);
  RxInt selectedSub2Index = RxInt(0);
  RxBool isLoading = RxBool(false);
  RxBool isExpanded = RxBool(false);
  RxBool isSub1 = RxBool(false);
  RxBool isSub2 = RxBool(false);
  RxBool isSub2Available = RxBool(false);
  RxBool entries = RxBool(false);
  RxBool isOpened = RxBool(false);
  RxBool selectPerson = RxBool(false);
  RxBool commonVisible = RxBool(false);
  RxBool employeeNameSelect = RxBool(false);
  RxString currentDate = RxString("Spend Date");
  late menuDataProvider userDataProvider;
  RxBool popUpValue = RxBool(false);
  TextEditingController currentDateController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController subCategory1Controller = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController agreeController = TextEditingController();
  TextEditingController subCategory2Controller = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController noOfPeopleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController ideasController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController ticketController = TextEditingController();
  TextEditingController driveTipsController = TextEditingController();
  TextEditingController toController = TextEditingController();
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(
      imagePath: null,
      file: null,
      renderType: RenderImage.platform,
      extension: '',
      base64: ''));
  RxString imagePathFromData = RxString("");
  RxBool isUpdateImageAvailable = false.obs;
  RxBool pickImageSelected = false.obs;
  RxBool allVisible = RxBool(false);

  //final record = AudioRecorder();
  RxList<FuelSubOneData> subCategory1 = RxList();
  RxList<EmployeeNameResponseData> employeeName = RxList();
  RxList<SubcategoryTwoData> fetchCategoryTwo = RxList();
  bool isCall = false;
  bool isComplete = false;
  final FocusNode amountFocusNode = FocusNode();
  int i = 0;
  RxString? recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();

    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      // subCategory1Call("");
      getEmployee();
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        setData();
      }
    }
    // currentDateController.text = userDataProvider.getDate!;
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

  void deleteOldData() async {
    File(recordFilePath!.value).deleteSync();
    print("delete1$recordFilePath");
    recordFilePath!.value = "";
    print("delete2$recordFilePath");
    isComplete = false;
    isAudio.value = false;
  }
  void deleteImage() async {
   await File(itemImagePick.value.imagePath.toString()).delete();
    // itemImagePick.value.imagePath.toString().
    print(itemImagePick.value.imagePath.toString());

    // await File(itemImagePick.value.renderType.toString()).delete();
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      isComplete = true;
    }
  }

  void play() {
    if (recordFilePath != null && File(recordFilePath!.value).existsSync()) {
      audioPlayer.setFilePath(recordFilePath!.value);
      audioPlayer.play();
    } else if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      audioPlayer.setUrl(
          "${ApiUrl.baseUrl}ideas/${userDataProvider.getIdeaLogyUser!.audioFile}");
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
    if (ideasController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter idea !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  getEmployee() async {
    isLoading.value = true;
    var response = await _connect.getEmployeeNameCall();
    isLoading.value = false;
    if (!response.error!) {
      employeeName.value = response.data!;
      debugPrint("getUser: ${response.toJson()}");
    } else {}
  }

  Future<void> addIdeas() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'ideas': ideasController.text,
        'agreeCount': '',
        'employeeName': AppPreference().getEmpName,
      };
      print("AddIdeaPayload:$payload");
      var response = await _connect.imgIdeasUpload(ApiUrl.addIdea,
          itemImagePick.value!.file, payload, recordFilePath!.value ?? "");
      debugPrint("AddIdeaResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.ideaLogySummary.toName);
        Get.deleteAll();
      } else
            () {};
    }
  }

  Future<void> updateIdeaLogy() async {
    Map<String, String> payload = {
      'ideasId': userDataProvider.getIdeaLogyUser!.ideasId.toString(),
      'ideas': ideasController.text,
      'agreeCount': "",
      'employeeName': AppPreference().getEmpName,
    };

    print('IdeaLogyUpdateRequest$payload');
    var response = await _connect.imgIdeasUpdate(ApiUrl.updateIdeaLogy,
        itemImagePick.value.file, payload, recordFilePath!.value ?? "");
    debugPrint("IdeaLogyUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.ideaLogySummary.toName);
      Get.deleteAll();
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.red,
      );
    };
  }

  void setData() {
    IdeaLogyUserResponseData data = userDataProvider.getIdeaLogyUser!;
    ideasController.text = data.ideas ?? "";

    if (userDataProvider.currentStatus == "Edit") {
      if(data.audioFile != null && !data.audioFile!.isEmpty) {
        isAudio.value = true;
      } else {
        isAudio.value = false;
      }
      if (data.images != null && data.images!.isNotEmpty) {
        imagePathFromData.value = "${ApiUrl.baseUrl}ideas/${data.images!}";
        isUpdateImageAvailable.value = true;
      }
    }
  }

}