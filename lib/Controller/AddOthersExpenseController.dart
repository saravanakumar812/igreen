import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/model/responseModel/OthersSummaryListResponse.dart';
import 'package:provider/provider.dart';
import '../../../Utils/AppPreference.dart';
import '../../../Utils/image_picker.dart';
import '../../../api_connect/api_connect.dart';
import '../../../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../../../model/responseModel/FuelSubCategoryResponse.dart';
import '../../../provider/menuProvider.dart';
import '../api_config/ApiUrl.dart';
import '../routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class AddOthersExpenseController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxInt selectedSub1Index = RxInt(0);
  RxInt selectedSub2Index = RxInt(0);
  RxBool isLoading = RxBool(false);
  RxBool isSub1 = RxBool(false);
  RxBool isSub2 = RxBool(false);
  RxBool isSub2Available = RxBool(false);
  RxBool entries = RxBool(false);
  RxString currentDate = RxString("Spend Date");
  RxBool popUpValue = RxBool(false);
  RxBool uploadLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  final FocusNode amountFocusNode = FocusNode();
  TextEditingController currentDateController = TextEditingController();
  TextEditingController subCategory1Controller = TextEditingController();
  TextEditingController subCategory2Controller = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController noOfPeopleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController othersCategoryController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  // Rx<PickedImage?> itemImagePick = Rx<PickedImage?>(null);
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  RxString imagePathFromData  = RxString("");
  RxBool isUpdateImageAvailable = false.obs;
  RxBool pickImageSelected = false.obs;
  RxList<FuelSubOneData> subCategory1 = RxList();
  RxList<SubcategoryTwoData> fetchCategoryTwo = RxList();
  bool isCall = false;
  bool isComplete = false;
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
    currentDateController.text = userDataProvider.getDate!;
    if (!isCall) {
      isCall = true;
      subCategory1Call('');
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        setData();
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
    }  else if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      audioPlayer.setUrl("${ApiUrl.baseUrl}expense/${userDataProvider
          .getOthersData!.audioFile}");
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

  subCategory1Call( String subcategory1Name) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryName':subcategory1Name,
    };

    print("1234566$payload");
    isLoading.value = true;
    var response = await _connect.fuelSubCategory(payload);
    isLoading.value = false;
    if (!response.error!) {
      subCategory1.value = response.data!;
    } else {}
  }

  Future<void> fetchSubCategoryTwo() async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryId': subCategory1[selectedSub1Index.value].toString(),
    };
    var response = await _connect.fetchCategoryTwoCall(payload);
    if (!response.error!) {
      fetchCategoryTwo.value = response.data!;
      update();
    }
  }

  bool firstValidation() {
    if (currentDateController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Select Date!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (commentController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Comment!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (amountController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Amount!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  Future<void> insertOthers() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'projectCode': userDataProvider.projectCode.toString(),
        'amount': amountController.text,
        'comments': commentController.text,
        'category': othersCategoryController.text,
        'category1': "Others",
        'category2': othersCategoryController.text,
        'category3': '',
        'category4': '',
        'expenseAmount': amountController.text,
        'expenseDate': currentDateController.text,
        'addedFrom': 'Android',
        'Types': '',
        'SGST': '',
        'CGST': '',
        'IGST': '',         'OverallExpenseStatus': '4',
        'LedgerName': '',
        'LedgerGroups': '',
        'LedgerCategory1': '',
        'LedgerCategory2': '',
        'LedgerCategory3': '',
        'LedgerCategory4': '',
        'LedgerCategory5': '',
        'expenseStatus': '0',

      };
      print("insertOthersRequest:$payload");
      uploadLoading.value = true;
      var response = await _connect.imgTaskUpload(ApiUrl.insertOthers,  itemImagePick.value.file , payload, recordFilePath!.value ?? "");
      uploadLoading.value = false;
      debugPrint("insertOthersResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.deleteAll();
        Get.offNamed(AppRoutes.addOthersSummaryScreen.toName);
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

  Future<void> updateOthers() async {
    if (firstValidation()) {
    Map<String, String> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
      'ProjectCode': userDataProvider.projectCode.toString(),
      'Category1': "Others",
      'Category2': othersCategoryController.text,
      'Category3': '',
      'Category4': '',
      'Category5': '',
      'Amount': amountController.text,
      'Comments': commentController.text,
      'ExpenseDate': currentDateController.text,
      'OtherExpenseId': userDataProvider.getOthersData!.id.toString(),
      'NewExpenseAmount': '',
      'OldExpenseAmount': '',
      'Images': '',
      'AudioFile': '',
    };
    print("updateOthersRequest:$payload");
    var response = await _connect.imgTaskUpdate(ApiUrl.updateOthers,itemImagePick.value.file , payload, recordFilePath!.value ?? "");
    debugPrint("updateOthersResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.addOthersSummaryScreen.toName);
    }
    else {
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

  void setData() {
    OthersData data = userDataProvider.getOthersData!;
    othersCategoryController.text = data.category2 ?? "";
    amountController.text = data.amount ?? "";
    commentController.text = data.comments ?? "";
    currentDateController.text = data.expenseDate ?? "";

    if(userDataProvider.currentStatus == "Edit"){
      if(data.audioFile != null && !data.audioFile!.isEmpty) {
    isAudio.value = true;
    } else {
    isAudio.value = false;
    }
      if(data.images != null && data.images!.isNotEmpty){
        imagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.images!}";
        isUpdateImageAvailable.value = true;
      }}
  }
}
