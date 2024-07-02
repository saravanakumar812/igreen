import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../../Utils/AppPreference.dart';
import '../../../Utils/image_picker.dart';
import '../../../api_connect/api_connect.dart';
import '../../../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../../../model/responseModel/FuelSubCategoryResponse.dart';
import '../../../provider/menuProvider.dart';
import '../api_config/ApiUrl.dart';
import '../model/responseModel/SuggestionCommentsModel.dart';
import '../model/responseModel/WagesEmployeeList.dart';
import '../model/responseModel/WagesSummarylist.dart';
import '../routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

// class EMPWages {
//   String? employeeName;
//   int? amount;
//   String? fingerPrint;
//   String? photo;
//   String? contactNumber;
//
//   EMPWages(
//       {
//         this.employeeName,
//         this.amount,
//         this.fingerPrint,
//         this.photo,
//         this.contactNumber});
//
//   EMPWages.fromJson(Map<String, dynamic> json) {
//     employeeName = json['employee_name'];
//     amount = json['amount'];
//     fingerPrint = json['finger_print'];
//     photo = json['photo'];
//     contactNumber = json['contact_number'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['employee_name'] = this.employeeName;
//     data['amount'] = this.amount;
//     data['finger_print'] = this.fingerPrint;
//     data['photo'] = this.photo;
//     data['contact_number'] = this.contactNumber;
//     return data;
//   }
// }

class EMPWages {
  String? employeeName;
  String? amount;
  String? fingerPrint;
  String? photo;
  String? contactNumber;

  EMPWages(
      {this.employeeName,
      this.amount,
      this.fingerPrint,
      this.photo,
      this.contactNumber});

  EMPWages.fromJson(Map<String, dynamic> json) {
    employeeName = json['EmployeeName'];
    amount = json['Amount'];
    fingerPrint = json['FingerPrint'];
    photo = json['Photo'];
    contactNumber = json['ContactNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeName'] = this.employeeName;
    data['Amount'] = this.amount;
    data['FingerPrint'] = this.fingerPrint;
    data['Photo'] = this.photo;
    data['ContactNumber'] = this.contactNumber;
    return data;
  }
}

class WagesEntryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxInt selectedSub1Index = RxInt(0);
  RxInt selectedSub2Index = RxInt(0);
  RxBool isLoading = RxBool(false);
  RxBool uploadLoading = RxBool(false);
  RxBool isSub1 = RxBool(false);
  RxBool isSub2 = RxBool(false);
  RxBool isSub2Available = RxBool(false);
  RxBool entries = RxBool(false);
  RxString currentDate = RxString("Spend Date");
  RxBool allVisible = RxBool(false);
  RxBool popUpValue = RxBool(false);
  RxBool rendList = false.obs;
  RxBool wagesEmployeeList = false.obs;
  List<String> rendDetails = [];
  late menuDataProvider userDataProvider;
  TextEditingController durationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController currentDateController = TextEditingController();
  TextEditingController subCategory1Controller = TextEditingController();
  TextEditingController subCategory2Controller = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController noOfPeopleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController amountControllerOne = TextEditingController();
  TextEditingController bettaChargesController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController wagesEmployee = TextEditingController();
  TextEditingController wagesController = TextEditingController();
  TextEditingController driveTipsController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController balanceAmountController = TextEditingController();
  TextEditingController currentlyPaidAmountController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(
      imagePath: null,
      file: null,
      renderType: RenderImage.platform,
      extension: '',
      base64: ''));
  RxString imagePathFromData = RxString("");
  RxBool isUpdateImageAvailable = false.obs;
  RxList<PickedImage?> itemImagePickEmp = RxList();
  RxBool pickImageSelectedEmp = false.obs;
  RxBool isMultiple = false.obs;
  RxBool pickImageSelected = false.obs;
  RxList<FuelSubOneData> subCategory1 = RxList();
  RxList<SubcategoryTwoData> fetchCategoryTwo = RxList();
  RxList<EMPWages> wagesEmployeesList = RxList();
  List<EMPWages> wagesList = [];

  RxInt list = RxInt(0);
  RxInt selectedIndex = RxInt(0);
  bool isCall = false;
  bool isComplete = false;
  RxBool isOpened = false.obs;
  int i = 0;
  final FocusNode amountFocusNode = FocusNode();
  final FocusNode noOfPeopleFocusNode = FocusNode();
  final FocusNode wagesFocusNode = FocusNode();
  final FocusNode currentlyPaidAmountFocusNode = FocusNode();
  final FocusNode wagesEmployeeFocusNode = FocusNode();
  final FocusNode contactNumberFocusNode = FocusNode();
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
    currentDateController.text = userDataProvider.getDate!;
    if (!isCall) {
      isCall = true;
      subCategory1Call("");
      EMPWages items = EMPWages();
      // items.wagesId = userDataProvider.getWagesEmployee!.wagesId;
      // items.wagesEmployeeId =userDataProvider.getWagesEmployee!.wagesEmployeeId;
      // items.employeeName = employeeNameController.text;
      // items.amount = amountControllerOne.text as int?;
      // items.photo = '';
      // items.contactNumber = contactNumberController.text;
      // wagesList.add(items);

      rendDetails.add('Day');
      rendDetails.add('Month');

      rendDetails.add('One Time');
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        setData();
      }
      suggestion();
    }
  }

  Future<void> suggestion() async {
    Map<String, dynamic> payload = {
      'Category': "Wages",
    };
    print('payload:$payload');
    var response = await _connect.getSuggestionList(payload);
    if (!response.error!) {
      suggestionList.value = response.data!;
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
    } else if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      audioPlayer.setUrl(
          "${ApiUrl.baseUrl}expense/${userDataProvider.getWagesData!.audioFile}");
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

  subCategory1Call(String wages) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryName': wages,
    };

    print("1234566$payload");
    isLoading.value = true;
    var response = await _connect.fuelSubCategory(payload);
    isLoading.value = false;
    if (!response.error!) {
      subCategory1.value = response.data!;
    } else {}
  }

  Future<void> fetchSubCategoryTwo(
      int? sub1categoryId, String sub2CategoryName) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryId': sub1categoryId,
      'Sub2CategoryName': sub2CategoryName
    };
    var response = await _connect.fetchCategoryTwoCall(payload);
    if (!response.error!) {
      fetchCategoryTwo.value = response.data!;
      update();
    }
  }

  bool firstValidation() {
    if (commentController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Comments!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (amountController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Total Amount!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    // final startingKm = int.tryParse(staringKmController.text);
    // final endingKm = int.tryParse(closingKmController.text);
    // if (startingKm != null && endingKm != null && endingKm <= startingKm) {
    //   Fluttertoast.showToast(
    //     msg: 'Ending kilometers must be greater than starting kilometers.',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //   );
    //   return false;
    // }

    final balance = int.tryParse(balanceAmountController.text);
    final currentlyPaidAmount =
        int.tryParse(currentlyPaidAmountController.text);
    if (balance != null &&
        currentlyPaidAmount != null &&
        currentlyPaidAmount <= balance) {
      Fluttertoast.showToast(
        msg: 'Currently Paid Amount  must be less than Wages Amount',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    String noOfPeopleText = amountController.text;
    String rateText = currentlyPaidAmountController.text;
    double noOfPeople = double.tryParse(noOfPeopleText) ?? 0;
    double rate = double.tryParse(rateText) ?? 0;
    if (rate > noOfPeople) {
      Fluttertoast.showToast(
        msg: "Currently paid amount should be less than total amount!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> insertWages() async {
    if (firstValidation()) {
      var result = jsonEncode(wagesEmployeesList.value)
          .replaceAll(RegExp(r'[[]'), '{')
          .replaceAll(RegExp(r'[]]'), '}');
      wagesList = wagesEmployeesList;
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'projectCode': userDataProvider.projectCode.toString(),
        'category1': "Wages",
        'category2': subCategory1Controller.text,
        'category3': subCategory2Controller.text,
        'category4': '',
        'category5': "",
        'amount': amountController.text,
        'NoOfPeople': noOfPeopleController.text,
        'bettaCharges': '',
        'wagesCharges': wagesController.text,
        'expenseAmount': currentlyPaidAmountController.text,
        'expenseDate': userDataProvider.date.toString(),
        'addedFrom': 'Android',
        'LedgerName': '',
        'LedgerGroups': '',
        'LedgerCategory1': '',
        'OverallExpenseStatus': '4',
        'LedgerCategory2': '',
        'LedgerCategory3': '',
        'LedgerCategory4': '',
        'LedgerCategory5': '',
        'expenseStatus': '0',
        'Types': '',
        'SGST': '',
        'CGST': '',
        'IGST': '',
        'comments': commentController.text,
        'WagesEmployee': json.encode(wagesList),
        'perDurationType': typeController.text,
        "CurrentlyPaidAmount": currentlyPaidAmountController.text,
        "Balance": balanceAmountController.text
      };

      log(json.encode(wagesList));

      print("wagesInsertPayload:$payload");
      uploadLoading.value = true;

      var response = await _connect.imgTaskUpload(ApiUrl.insertWages,
          itemImagePick.value.file, payload, recordFilePath!.value ?? "");
      uploadLoading.value = false;
      debugPrint("wagesInsertResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.deleteAll();
        Get.offNamed(AppRoutes.wagesSummaryScreen.toName);
      } else
        () {};
    }
  }

  Future<void> updateWages() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'ProjectCode': userDataProvider.projectCode.toString(),
        'Category1': "Wages",
        'Category2': subCategory1Controller.text,
        'Category3': subCategory2Controller.text,
        'Category4': '',
        'Category5': '',
        'NoOfPeople': '',
        'BettaCharges': '',
        'WagesCharges': wagesController.text,
        'WagesExpenseId': userDataProvider.getWagesData!.wagesId.toString(),
        'ExpenseDate': userDataProvider.date.toString(),
        'OldExpenseAmount': amountController.text,
        'NewExpenseAmount': '',
        'Comments': commentController.text,
        'WagesEmployee': wagesEmployeesList.value.toString(),
        'perDurationType': typeController.text,
        "CurrentlyPaidAmount": currentlyPaidAmountController.text,
        "Balance": balanceAmountController.text
      };
      print('wagesUpdateRequest$payload');
      var response = await _connect.imgTaskUpdate(ApiUrl.updateWages,
          itemImagePick.value.file, payload, recordFilePath!.value ?? "");
      debugPrint("wagesUpdateResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.wagesSummaryScreen.toName);
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
  }

  Future<void> empInsert(index) async {
    Map<String, dynamic> payload = {
      'WagesId': userDataProvider.getWagesData!.wagesId.toString(),
      'EmployeeName': employeeNameController.text,
      'Amount': amountController.text,
      'FingerPrint': '',
      'Photo': '',
      'ContactNumber': contactNumberController.text,
    };
    print('empInsert:$payload');
    var response = await _connect.empInsertCall(payload);
    debugPrint("empInsertResponse: ${response.toJson()}");

    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      // Get.offNamed(AppRoutes.WagesSummaryScreen.toName);
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

  Future<void> empUpdate() async {
    Map<String, dynamic> payload = {
      'Id': userDataProvider.getWagesData!.wagesEmployee![i].wagesEmployeeId
          .toString(),
      'EmployeeName': '',
      'Amount': '',
      'FingerPrint': '',
      'Photo': '',
      'ContactNumber': '',
    };
    print('empUpdate:$payload');
    var response = await _connect.empUpdateCall(payload);
    debugPrint("empUpdateResponse: ${response.toJson()}");

    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.wagesSummaryScreen.toName);
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

  void setData() {
    WagesData data = userDataProvider.getWagesData!;
    subCategory1Controller.text = data.category2 ?? "";
    subCategory2Controller.text = data.category3 ?? "";
    noOfPeopleController.text = data.noOfPeople ?? '';
    wagesController.text = data.wagesCharges ?? "";
    commentController.text = data.comments ?? "";
    amountController.text = data.expenseAmount.toString() ?? "";
    currentlyPaidAmountController.text =
        data.currentlyPaidAmount.toString() ?? "";
    balanceAmountController.text = data.balance.toString() ?? "";
    allVisible.value = true;
    isSub2Available.value = true;

    if (userDataProvider.currentStatus == "Edit") {
      if (data.audioFile != null && !data.audioFile!.isEmpty) {
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
