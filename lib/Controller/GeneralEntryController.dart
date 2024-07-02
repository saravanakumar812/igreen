import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
//import 'package:record/record.dart';

import '../../../Utils/AppPreference.dart';
import '../../../Utils/image_picker.dart';
import '../../../api_connect/api_connect.dart';
import '../../../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../../../model/responseModel/FuelSubCategoryResponse.dart';
import '../../../provider/menuProvider.dart';
import '../api_config/ApiUrl.dart';
import '../model/responseModel/EmployeeNameResponseModel.dart';
import '../model/responseModel/GeneralSummaryList.dart';
import '../model/responseModel/SuggestionCommentsModel.dart';
import '../routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class GeneralEntryController extends GetxController {
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
  RxBool uploadLoading = RxBool(false);
  RxBool commonVisible = RxBool(false);
  RxBool employeeNameSelect = RxBool(false);
  RxString currentDate = RxString("Spend Date");
  late menuDataProvider userDataProvider;
  RxBool popUpValue = RxBool(false);
  TextEditingController currentDateController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();
  TextEditingController subCategory1Controller = TextEditingController();
  TextEditingController subCategory2Controller = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController noOfPeopleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController ticketController = TextEditingController();
  TextEditingController driveTipsController = TextEditingController();
  TextEditingController toController = TextEditingController();
  // Rx<PickedImage?> itemImagePick = Rx<PickedImage?>(null);
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  RxString imagePathFromData  = RxString("");
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
  RxBool isSuggestionComments = false.obs;
  RxList<SuggestionData> suggestionList = RxList();




  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();

    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      subCategory1Call("");
      getEmployee();
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        setData();
      }
      suggestion();

    }
    currentDateController.text = userDataProvider.getDate!;
  }

  Future<void> suggestion() async {
    Map<String, dynamic> payload = {
      'Category': "General",
    };
    print('payload:$payload');
    var response = await _connect.getSuggestionList(payload);
    if (!response.error!) {
      suggestionList.value = response.data!;

    } else {

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
    } else if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      audioPlayer.setUrl("${ApiUrl.baseUrl}expense/${userDataProvider
          .getGeneralData!.audioFile}");
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

  subCategory1Call(String general) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryName':general,
    };

    print("1234566$payload");
    isLoading.value = true;
    var response = await _connect.fuelSubCategory(payload);
    isLoading.value = false;
    if (!response.error!) {
      subCategory1.value = response.data!;
    } else {}
  }

  Future<void> fetchSubCategoryTwo(int? sub1categoryId, String sub2CategoryName) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryId':  sub1categoryId,
      'Sub2CategoryName': sub2CategoryName,
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
  getEmployee() async {
    isLoading.value = true;
    var response = await _connect.getEmployeeNameCall();
    isLoading.value = false;
    if (!response.error!) {
      employeeName.value = response.data!;
      debugPrint("getUser: ${response.toJson()}");
    } else {}
  }
  Future<void> insertGeneralApi() async {
    if (firstValidation()) {
      Map<String,String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'projectCode': userDataProvider.projectCode.toString(),
        'category1': "General",
        'category2': subCategory1Controller.text,
        'category3': subCategory2Controller.text,
        'category4': "",
        'category5': "",
        'comments': commentController.text,
        'amount': amountController.text,
        'expenseAmount': amountController.text,
        'expenseDate': userDataProvider.date.toString(),
        'addedFrom': 'Android',
        'LedgerName': '',
        'LedgerGroups': '',
        'LedgerCategory1': '',
        'LedgerCategory2': '',
        'LedgerCategory3': '',
        'LedgerCategory4': '',
        'LedgerCategory5': '',        'OverallExpenseStatus': '4',
        'expenseStatus': '0',
        'Types': '',
        'SGST': '',
        'CGST': '',
        'IGST': '',
        'EmployeeName': employeeNumberController.text
      };
      print("generalInsertPayload:$payload");
      uploadLoading.value = true;

      var response = await _connect.imgTaskUpload( ApiUrl.insertGeneral,itemImagePick.value.file , payload, recordFilePath!.value ?? "");
      uploadLoading.value = false;
      debugPrint("generalInsertResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        Get.offNamed(AppRoutes.generalSummaryScreen.toName);
        Get.deleteAll();
      } else
        () {};
    }
  }

  Future<void> updateGeneral() async {
    Map<String, String> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
      'ProjectCode': userDataProvider.projectCode.toString(),
      'Category1':"General" ,
      'Category2': subCategory1Controller.text,
      'Category3': subCategory2Controller.text,
      'Category4': '',
      'Category5': '',
      'Comments': commentController.text,
      'Amount': amountController.text,
      'ExpenseDate': userDataProvider.date.toString(),
      'OldExpenseAmount': '',
      'NewExpenseAmount': '',
      'GeneralExpenseId': userDataProvider.getGeneralData!.id.toString(),
      'Images': '',
      "Audio File": '',
      'EmployeeName': employeeNumberController.text
    };

    print('generalUpdateRequest$payload');
    var response = await _connect.imgTaskUpdate(ApiUrl.updateGeneral, itemImagePick.value.file , payload, recordFilePath!.value ?? "");
    debugPrint("generalUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.generalSummaryScreen.toName);
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
    GeneralData data = userDataProvider.getGeneralData!;
    subCategory1Controller.text = data.category2 ?? "";
    subCategory2Controller.text = data.category3 ?? "";
    amountController.text = data.amount ?? "";
    commentController.text = data.comments ?? "";
    currentDateController.text = data.expenseDate ?? "";
    isSub2Available.value = true;
    allVisible.value = true;
    commonVisible.value = true;
    isOpened.value = true;
    employeeNameSelect.value = false;
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
