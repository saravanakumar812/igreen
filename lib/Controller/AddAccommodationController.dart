import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/model/responseModel/GetAccommodationResponse.dart';
import 'package:provider/provider.dart';
import '../../model/responseModel/FuelSubCategoryResponse.dart';
import '../Utils/AppPreference.dart';
import '../Utils/image_picker.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/SuggestionCommentsModel.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class AddAccommodationController extends GetxController {
  late menuDataProvider userDataProvider;
  bool isCall = false;
  final ApiConnect _connect = Get.put(ApiConnect());
  TextEditingController subCategory1Controller = TextEditingController();
  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkOutDateController = TextEditingController();
  TextEditingController currentlyPaidAmountController = TextEditingController();
  TextEditingController currentlyPaidHouseAmountController =
      TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController amountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController ownerDetailsController = TextEditingController();
  TextEditingController panCardDetailsController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController lumSumChargesController = TextEditingController();
  TextEditingController currentBillController = TextEditingController();
  TextEditingController brokerageController = TextEditingController();
  TextEditingController typeController =
      TextEditingController(text: 'Rental Agreement');
  TextEditingController perTypeController = TextEditingController();
  TextEditingController spendDateController = TextEditingController();
  TextEditingController lodgeNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController numberOfRoomsController = TextEditingController();
  TextEditingController roomsNumberController = TextEditingController();
  TextEditingController perDayAmountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController extraChargesController = TextEditingController();
  TextEditingController othersChargesController = TextEditingController();
  TextEditingController balanceAmountController = TextEditingController();
  TextEditingController extraAmountChargesController = TextEditingController();
  RxBool rendList = false.obs;
  RxBool popUpValue = RxBool(false);
  RxBool brokerage = RxBool(false);
  RxBool rendChargeList = false.obs;
  RxBool othersChargesVisible = false.obs;
  RxBool chargesVisible = false.obs;
  RxBool rentTypeVisible = false.obs;
  String subcategoryName = "";
  RxBool isSub1 = RxBool(false);
  RxBool uploadLoading = RxBool(false);
  RxBool commonVisible = RxBool(false);
  RxBool billHoldVisible = RxBool(false);
  RxBool houseTypeVisible = RxBool(false);
  RxBool typeVisible = RxBool(false);
  RxBool houseVisible = RxBool(false);
  RxBool othersVisible = RxBool(false);
  RxBool lodgeHouseDetailsVisible = RxBool(false);
  RxBool dateVisible = RxBool(false);
  RxBool othersCategoriesVisible = RxBool(false);
  RxInt selectedSub1Index = RxInt(0);
  RxBool isSub2Available = RxBool(false);
  RxString currentDate = RxString("Start Date");

  // Rx<PickedImage?> itemImagePick = Rx<PickedImage?>(null);
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(
      imagePath: null,
      file: null,
      renderType: RenderImage.platform,
      extension: '',
      base64: ''));

  RxBool pickImageSelected = false.obs;
  RxBool isLoading = RxBool(false);
  RxBool roomsVisible = RxBool(false);
  RxList<FuelSubOneData> subCategory1 = RxList();
  bool isComplete = false;
  int i = 0;
  RxString? recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  final FocusNode mobileNumberFocusNode = FocusNode();
  final FocusNode numberOfRoomsFocusNode = FocusNode();
  final FocusNode roomNumberFocusNode = FocusNode();
  final FocusNode lumSumChargesFocusNode = FocusNode();
  final FocusNode currentBillFocusNode = FocusNode();
  final FocusNode brokerageFocusNode = FocusNode();
  final FocusNode extraChargesFocusNode = FocusNode();
  final FocusNode othersFocusNode = FocusNode();
  final FocusNode perDayAmountFocusNode = FocusNode();
  final FocusNode rateFocusNode = FocusNode();
  final FocusNode currentlyPaidAmountFocusNode = FocusNode();
  final FocusNode balanceAmountFocusNode = FocusNode();
  final FocusNode maintenanceFocusNode = FocusNode();
  final FocusNode totalAmountFocusNode = FocusNode();
  RxBool isUpdateImageAvailable = false.obs;
  RxBool isUpdateStartImageAvailable = false.obs;
  RxBool isUpdateEndImageAvailable = false.obs;
  RxString imagePathFromData = RxString("");
  RxString startImagePathFromData = RxString("");
  RxString endImagePathFromData = RxString("");
  RxBool isSuggestionComments = false.obs;
  RxList<SuggestionData> suggestionList = RxList();

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    spendDateController.text = userDataProvider.getDate!;
    if (!isCall) {
      isCall = true;
      subCategory1Call('');
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        setData();
      }
      suggestion();

    }
  }
  Future<void> suggestion() async {
    Map<String, dynamic> payload = {
      'Category': "Accommodation",
    };
    print('payload:$payload');
    var response = await _connect.getSuggestionList(payload);
    if (!response.error!) {
      suggestionList.value = response.data!;

    } else {

    }
  }


  Future<void> refreshDataResort() async {
    balanceAmountController.clear();
    currentlyPaidAmountController.clear();
    brokerageController.clear();
    rateController.clear();
    amountController.clear();
    totalAmountController.clear();
    return Future.delayed(Duration(seconds: 0));
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
          "${ApiUrl.baseUrl}expense/${userDataProvider.getAccommodationData!.audioFile}");
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

  subCategory1Call(String subcategory1Name) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryName': subcategory1Name,
    };
    print("1234566$payload");
    isLoading.value = true;
    var response = await _connect.fuelSubCategory(payload);
    isLoading.value = false;
    if (!response.error!) {
      subCategory1.value = response.data!;
    } else {}
  }

  bool firstValidation() {

    if (spendDateController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Select Date!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    String noOfPeopleText = totalAmountController.text;
    String rateText = currentlyPaidAmountController.text;
    double noOfPeople = double.tryParse(noOfPeopleText)  ?? 0;
    double rate = double.tryParse(rateText) ?? 0;
    if (rate >
       noOfPeople) {
      Fluttertoast.showToast(
        msg: "Currently paid amount should be less than total amount!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (subCategory1Controller.text == 'Lodge' ||
        subCategory1Controller.text == 'PG' ||
        subCategory1Controller.text == 'Land' ||
        subCategory1Controller.text == 'Guest House' ||
        subCategory1Controller.text == 'Office' ||
        subCategory1Controller.text == 'Factory Labour' ||
        subCategory1Controller.text == 'Factory' ||
        subCategory1Controller.text == 'Hotel') {

      if (checkInDateController.value.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Select Check  In Date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      if (checkOutDateController.value.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Select Check Out Date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }

      if (mobileController.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter valid mobile number!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      if (mobileController.text.length < 10) {
        Fluttertoast.showToast(
          msg: "Please Enter 10 number In Mobile Number!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
    }
    if (commentsController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Comment!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (selectedStartDate != null &&
        selectedEndDate != null &&
        selectedStartDate!.isAfter(selectedEndDate!)) {
      if (selectedStartDate!.isAfter(selectedEndDate!)) {
        print('Check out date is greater than Check in datetime');
        Fluttertoast.showToast(
          msg: "Check out date is greater than Check in datetime!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }
    if (totalAmountController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Total Amount !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  Future<void> insertAccommodation() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'projectCode': userDataProvider.projectCode.toString(),
        'category1': "Accommodation",
        'category2': subCategory1Controller.text,
        'category3': '',
        'category4': '',
        'category5': '',        'OverallExpenseStatus': '4',

        'otherAccommodationCategory': '',
        'ownerDetails': ownerDetailsController.text,
        'panCard': panCardDetailsController.text,
        'advance': currentlyPaidAmountController.text,
        'balanceAmount': balanceAmountController.text,
        'Duration': perDayAmountController.text,
        'rentPerMonth': perTypeController.text,
        'lumsumCharges': lumSumChargesController.text,
        'currentBillAmount': currentBillController.text,
        'brokerageAmount': brokerageController.text,
        'totalAmount': totalAmountController.text,
        'comments': commentsController.text,
        'maintanence': maintenanceController.text,
        'checkIn': checkInDateController.text,
        'checkOut': checkOutDateController.text,
        'billType': '',
        'perRate': rateController.text,
        'address': addressController.text,
        'expenseAmount': currentlyPaidAmountController.text,
        'expenseDate': spendDateController.text,
        'ledgerName': lodgeNameController.text,
        'contactNumber': mobileController.text,
        'numberOfRooms': numberOfRoomsController.text,
        'roomNumber': roomsNumberController.text,
        'extraChargesFor': extraChargesController.text,
        'extraCharges': extraAmountChargesController.text,
        'addedFrom': 'Android',
        'expenseStatus': '',
        'Types': typeController.text,
        'SGST': '',
        'CGST': '',
        'IGST': '',
        'LedgerName': '',
        'LedgerGroups': '',
        'LedgerCategory1': '',
        'LedgerCategory2': '',
        'LedgerCategory3': '',
        'LedgerCategory4': '',
        'LedgerCategory5': '',
      };

      print('addAccommodation$payload');
      uploadLoading.value = true;

      var response = await _connect.imgAccommodationUpload(
          ApiUrl.insertAccommodation,
          itemImagePick.value.file,
          payload,
          recordFilePath!.value ?? "");
      uploadLoading.value = false;

      debugPrint("addAccommodation: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.accommodationSummary.toName);
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
  }

  Future<void> updateAccommodation() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'ProjectCode': userDataProvider.projectCode.toString(),
        'Category1': "Accommodation",
        'Category2': subCategory1Controller.text,
        'Category3': '',
        'Category4': '',
        'Category5': '',
        'OtherAccommodationCategory': '',
        'OwnerDetails': ownerDetailsController.text,
        'PanCard': panCardDetailsController.text,
        'Maintenance': maintenanceController.text,
        'Address': addressController.text,
        'Advance': currentlyPaidAmountController.text,
        'RentPerMonth': perTypeController.text,
        'LumsumCharges': lumSumChargesController.text,
        'CurrentBillAmount': currentBillController.text,
        'BrokerageAmount': brokerageController.text,
        'TotalAmount': totalAmountController.text,
        'Comments': commentsController.text,
        'CheckIn': checkInDateController.text,
        'CheckOut': checkOutDateController.text,
        'BillType': '',
        'ExpenseDate': spendDateController.text,
        'ledgerName': lodgeNameController.text,
        'contactNumber': mobileController.text,
        'numberOfRooms': numberOfRoomsController.text,
        'roomNumber': roomsNumberController.text,
        'extraChargesFor': extraChargesController.text,
        'extraCharges': extraAmountChargesController.text,
        'perRate': rateController.text,
        'AccommodationExpenseId':
            userDataProvider.getAccommodationData!.id.toString(),
        'NewExpenseAmount': '',
        'OldExpenseAmount': '',
        'Duration': perDayAmountController.text,
        'balanceAmount': balanceAmountController.text,
      };
      print('updateAccommodationPayalod:$payload');
      var response = await _connect.imgAccommondationUpdate(
          ApiUrl.updateAccommodation,
          itemImagePick.value.file,
          payload,
          recordFilePath!.value ?? "");
      debugPrint("updateAccommodation: ${response.toJson()}");
      Get.offNamed(AppRoutes.accommodationSummary.toName);
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.accommodationSummary.toName);
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
      // ;
    }
  }

  void setData() {
    GetAccommodationData data = userDataProvider.getAccommodationData!;
    currentDate.value = data.expenseDate ?? "";
    subCategory1Controller.text = data.category2 ?? "";
    ownerDetailsController.text = data.ownerDetails ?? "";
    lodgeNameController.text = data.ledgerName ?? "";
    panCardDetailsController.text = data.panCard ?? "";
    mobileController.text = data.contactNumber ?? "";
    lumSumChargesController.text = data.lumsumCharges ?? "";
    currentBillController.text = data.currentBillAmount ?? "";
    brokerageController.text = data.brokerageAmount ?? "";
    commentsController.text = data.comments ?? "";
    maintenanceController.text = data.maintanence ?? "";
    checkInDateController.text = data.checkIn ?? "";
    checkOutDateController.text = data.checkOut ?? "";
    addressController.text = data.address ?? "";
    currentlyPaidAmountController.text = data.totalAmount ?? "";
    spendDateController.text = data.expenseDate ?? "";
    roomsNumberController.text = data.roomNumber ?? "";
    numberOfRoomsController.text = data.numberOfRooms ?? "";
    extraChargesController.text = data.extraChargesFor ?? "";
    extraAmountChargesController.text = data.extraCharges ?? "";
    perTypeController.text = data.rentPerMonth ?? "";
    perDayAmountController.text = data.duration ?? "";
    rateController.text = data.perRate ?? "";
    balanceAmountController.text = data.balanceAmount ?? "";
    currentlyPaidAmountController.text = data.advance ?? "";
    totalAmountController.text = data.totalAmount ?? "";
    if (extraChargesController.text == "Others Charges") {
      othersChargesVisible.value = true;
      othersChargesController.text = data.extraChargesFor ?? "";
    }

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
    if (subCategory1Controller.text == 'Lodge' ||
        subCategory1Controller.text == 'PG') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
    }
    if (subCategory1Controller.text == 'Lodge' ||
        subCategory1Controller.text == 'PG') {
      chargesDetails.add('Others Charges');
      chargesDetails.add('Extra Bed Charges');
      chargesDetails.add('Cleaning Charges');
      chargesDetails.add('Washing Charges');
    }
    if (subCategory1Controller.text == 'Office') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
    }
    if (subCategory1Controller.text == 'Office') {
      chargesDetails.add('Others Charges');
      chargesDetails.add('Cleaning Charges');
      chargesDetails.add('Water Charges');
      chargesDetails.add('Painting Charges');
    }
    if (subCategory1Controller.text == 'House' ||
        subCategory1Controller.text == 'Resort' ||
        subCategory1Controller.text == 'Guest House') {
      rendDetails.add('Month');
      rendDetails.add('Day');
      rendDetails.add('Advance');
    }

    if (subCategory1Controller.text == 'House' ||
        subCategory1Controller.text == 'Guest House') {
      chargesDetails.add('Others Charges');
      chargesDetails.add('House Repair Charges');
      chargesDetails.add('Cleaning Charges');
      chargesDetails.add('Water Charges');
    }
    if (subCategory1Controller.text == 'Resort') {
      chargesDetails.add('Others Charges');
      chargesDetails.add('Resort Repair Charges');
      chargesDetails.add('Cleaning Charges');
      chargesDetails.add('Water Charges');
    }

    if (subCategory1Controller.text == 'Land') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
    }

    if (subCategory1Controller.text == 'Land') {
      chargesDetails.add('Others Charges');
      chargesDetails.add('Land Repair Charges');
      chargesDetails.add('Cleaning Charges');
      chargesDetails.add('Water Charges');
    }

    if (subCategory1Controller.text == 'Factory') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
    }

    if (subCategory1Controller.text == 'Factory') {
      chargesDetails.add('Others Charges');
      chargesDetails.add('Factory Repair Charges');
      chargesDetails.add('Cleaning Charges');
      chargesDetails.add('Water Charges');
    }
    if (subCategory1Controller.text == 'Factory Labour') {
      chargesDetails.add('Others Charges');
      chargesDetails.add('Factory Repair Charges');
      chargesDetails.add('Cleaning Charges');
      chargesDetails.add('Water Charges');
    }
    if (subCategory1Controller.text == 'Factory Labour') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
    }
    if (subCategory1Controller.text == 'Others') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
    }
    if (subCategory1Controller.text == 'Others') {
      chargesDetails.add('Others Charges');
    }

    lodgeHouseDetailsVisible.value = false;
    othersCategoriesVisible.value = false;
    chargesVisible.value = false;
    houseVisible.value = false;
    dateVisible.value = false;
    commonVisible.value = true;
    billHoldVisible.value = true;
    if (subCategory1Controller.text == 'House') {
      houseVisible.value = true;
      chargesVisible.value = true;
      brokerage.value = true;
    } else if (subCategory1Controller.text == 'Lodge') {
      lodgeHouseDetailsVisible.value = true;
      dateVisible.value = true;
      rentTypeVisible.value = true;
      chargesVisible.value = true;
    } else if (subCategory1Controller.text == 'Resort') {
      dateVisible.value = false;
      houseVisible.value = true;
      chargesVisible.value = true;
      brokerage.value = false;
    } else if (subCategory1Controller.text == 'PG') {
      dateVisible.value = true;
      lodgeHouseDetailsVisible.value = true;
      rentTypeVisible.value = true;
      chargesVisible.value = true;
    } else if (subCategory1Controller.text == 'Land') {
      dateVisible.value = true;
      houseVisible.value = true;
      chargesVisible.value = true;
      brokerage.value = true;
    } else if (subCategory1Controller.text == 'Guest House') {
      dateVisible.value = true;
      houseVisible.value = true;
      chargesVisible.value = true;
      brokerage.value = true;
    } else if (subCategory1Controller.text == 'Office') {
      dateVisible.value = true;
      houseVisible.value = true;
      chargesVisible.value = true;
      brokerage.value = true;
    } else if (subCategory1Controller.text == 'Factory') {
      dateVisible.value = true;
      houseVisible.value = true;
      chargesVisible.value = true;
      brokerage.value = true;
    } else if (subCategory1Controller.text == 'Factory Labour') {
      dateVisible.value = true;
      houseVisible.value = true;
      chargesVisible.value = true;
      brokerage.value = true;
    } else if (subCategory1Controller.text == 'Others') {
      dateVisible.value = true;
      houseVisible.value = true;
      chargesVisible.value = true;
      othersCategoriesVisible.value = true;
      brokerage.value = true;
    } else if (subCategory1Controller.text == 'Hotel') {
      lodgeHouseDetailsVisible.value = true;
      dateVisible.value = true;
      rentTypeVisible.value = true;
      chargesVisible.value = true;
    } else {
      lodgeHouseDetailsVisible.value = true;
      dateVisible.value = true;
      rentTypeVisible.value = true;
      chargesVisible.value = true;
      houseVisible.value = true;
    }
  }

  List<String> rendDetails = [];

  List<String> chargesDetails = [];
}
