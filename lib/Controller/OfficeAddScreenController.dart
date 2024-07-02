import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/model/IdealogyResponseModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

//import 'package:record/record.dart';
import 'package:intl/intl.dart';
import '../../../Utils/AppPreference.dart';
import '../../../Utils/image_picker.dart';
import '../../../api_connect/api_connect.dart';
import '../../../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../../../model/responseModel/FuelSubCategoryResponse.dart';
import '../../../provider/menuProvider.dart';
import '../api_config/ApiUrl.dart';
import '../model/GetOfficeEmployeeResponseModel.dart';
import '../model/OfficeCategoryResponse.dart';
import '../model/responseModel/EmployeeNameResponseModel.dart';
import '../model/responseModel/GeneralSummaryList.dart';
import '../routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class OfficeAddScreenController extends GetxController {
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
  TextEditingController categoryController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController amountController = TextEditingController();

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
  final ImagePicker picker = ImagePicker();
  Rx<XFile> imageFile  = XFile('').obs;
  pickedGalleryImage() async {
    imageFile.value = (await picker.pickImage(source:
    ImageSource.gallery,imageQuality: 100))!;
    imageFile.refresh();
  }pickedCameraImage() async {
    imageFile.value = (await picker.pickImage(source:
    ImageSource.camera,imageQuality: 100))!;
    imageFile.refresh();
  }
  RxList<OfficeCategoryResponseData> officeCategoryData = RxList();
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
      getOffice();
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        setData();
      }
    }
    currentDateController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
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
    } else if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      audioPlayer.setUrl(
          "${ApiUrl.baseUrl}expense/${userDataProvider.getOfficeEmployee!.audioFile}");
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
    if (categoryController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Category !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    } if (commentsController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Comments !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (amountController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Amount !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (currentDateController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Current date !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  getOffice() async {
    isLoading.value = true;
    var response = await _connect.getOfficeCategoryCall();
    isLoading.value = false;
    if (!response.error!) {
      officeCategoryData.value = response.data!;
      debugPrint("getUser: ${response.toJson()}");
    } else {}
  }

  Future<void> addOffice() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        "ProjectCode": userDataProvider.projectCode.toString(),
        'Category': categoryController.text,
        'Comments': commentsController.text,
        'Amount': amountController.text,
        'SpendDate': currentDateController.text,
        'AddedFrom': 'Android',
        'OfficeBalanceId': "",
        'Types': "",
        'SGST': "",
        'CGST': "",
        'IGST': "",
        'LedgerName': "",
        'LedgerGroups': "",
        'LedgerCategory1': "",
        'LedgerCategory2': "",
        'LedgerCategory3': "",
        'LedgerCategory4': "",
        'LedgerCategory5': "",
        'LedgerNameId': "",
        'LedgerGroupsId': "",
        'LedgerCategoryId1': "",
        'LedgerCategoryId2': "",
        'LedgerCategoryId3': "",
        'LedgerCategoryId4': "",
      };
      print("AddIdeaPayload:$payload");
      var response = await _connect.imgOfficeUpload(
          ApiUrl.addOffice, itemImagePick.value.file, payload, recordFilePath!.value ?? "");
      debugPrint("AddIdeaResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.officeSummary.toName);
        Get.deleteAll();
      } else
        () {};
    }
  }

  Future<void> updateOffice() async {
    Map<String, String> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
      'Category': categoryController.text,
      'Comments': commentsController.text,
      'Amount': amountController.text,
      'SpendDate': currentDateController.text,
      'OfficeExpenseId': userDataProvider.getOfficeEmployee!.id.toString(),
    };

    print('OfficeUpdateRequest$payload');
    var response = await _connect.imgOfficeUpdate(
        ApiUrl.updateOffice, itemImagePick.value.file, payload, recordFilePath!.value ?? "");
    debugPrint("OfficeUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.officeSummary.toName);
      Get.deleteAll();
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.red,
      );
    }
    ;
  }

  void setData() {
    OfficeEmployeeResponseData data = userDataProvider.getOfficeEmployee!;
    categoryController.text = data.category ?? "";
    amountController.text = data.amount.toString() ?? "";
    commentsController.text = data.comments ?? "";
    currentDateController.text = data.spendDate ?? "";



    if (userDataProvider.currentStatus == "Edit") {
      if(data.audioFile != null && !data.audioFile!.isEmpty) {
        isAudio.value = true;
      } else {
        isAudio.value = false;
      }
      if (data.images != null && data.images!.isNotEmpty) {
        imagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.images!}";
        isUpdateImageAvailable.value = true;
      }
    }
  }
}
