import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../Utils/AppPreference.dart';
import '../../Utils/image_picker.dart';
import '../../api_connect/api_connect.dart';
import '../../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../../model/responseModel/FuelSubCategoryResponse.dart';
import '../../provider/menuProvider.dart';
import '../api_config/ApiUrl.dart';
import '../model/responseModel/GetCityData.dart';
import '../model/responseModel/GetOwnerResponse.dart';
import '../model/responseModel/GetVendorNameResponse.dart';
import '../model/responseModel/SuggestionCommentsModel.dart';
import '../model/responseModel/TravelSummaryList.dart';
import '../routes/app_routes.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class TravelEntryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxInt selectedSub1Index = RxInt(0);
  RxInt selectedSub2Index = RxInt(0);
  RxBool isLoading = RxBool(false);
  RxBool isSub1 = RxBool(false);
  RxBool isSub2 = RxBool(false);
  RxBool locationsVisible = RxBool(false);
  RxBool kiloVisible = RxBool(false);
  RxBool locationKmController = RxBool(false);
  RxBool driverTips = RxBool(false);
  RxBool rendList = false.obs;
  RxBool buttonAndImageHoldVisible = RxBool(false);
  RxBool rentOwnedOnClick = false.obs;
  RxBool ownedOnClick = false.obs;
  RxBool selectedRadioRented = false.obs;
  RxBool selectedRadioOwned = false.obs;
  RxBool tollCharges = RxBool(false);
  RxBool travelCharges = RxBool(false);
  RxList<CityData> toCityValues = RxList();
  RxList<CityData> fromCityValues = RxList();
  RxBool fromLocationVisibleDropdown = RxBool(false);
  RxBool toLocationVisibleDropdown = RxBool(false);
  RxBool isSub2Available = RxBool(false);
  RxBool commonVisible = RxBool(false);
  RxBool entries = RxBool(false);
  RxBool amount = RxBool(false);
  RxBool ticketCharges1 = RxBool(false);

  RxBool vendorOnClick = RxBool(false);
  RxBool uploadLoading = RxBool(false);
  RxBool ownerOnClick = RxBool(false);
  RxString machineRented = RxString("Rented");
  RxString machineOwned = RxString("Owned");
  RxList<GetVendorData> vendorData = RxList();
  RxList<GetOwnerData> ownerData = RxList();
  late menuDataProvider userDataProvider;
  TextEditingController typeController = TextEditingController();
  TextEditingController othersController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController balanceAmountController = TextEditingController();
  TextEditingController currentlyPaidAmountController = TextEditingController();
  TextEditingController totalChargesController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController currentDateController = TextEditingController();
  TextEditingController subCategory1Controller = TextEditingController();
  TextEditingController subCategory2Controller = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController tollChargesController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController startingKmController = TextEditingController();
  TextEditingController closingKmController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController noOfPeopleController = TextEditingController();
  TextEditingController ticketController = TextEditingController();
  TextEditingController driveTipsController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController vendorNameAddController = TextEditingController();
  TextEditingController vendorCompanyController = TextEditingController();
  TextEditingController vendorAddressAddController = TextEditingController();
  TextEditingController vendorGstController = TextEditingController();
  TextEditingController vendorMobileController = TextEditingController();
  TextEditingController vendorEmailController = TextEditingController();
  TextEditingController vendorServiceController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerContactController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController registrationNumberAddController = TextEditingController();
  TextEditingController vehiclesDetailsController = TextEditingController();

  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));

  RxBool pickImageSelected = false.obs;
  RxBool ownerButtonClick = false.obs;
  RxBool publicTravels = false.obs;
  RxList<SubcategoryTwoData> fetchCategoryTwo = RxList();
  bool isCall = false;
  RxInt pageIndex = RxInt(1);
  bool isComplete = false;
  RxList<FuelSubOneData> subCategory1 = RxList();
  String startingLocation = "";
  String vendorName = "";
  String endingLocation = "";
  String registrationNumber = "";
  String subcategoryName = "";
  RxList<String> filteredCities = RxList();
  RxInt selectedValues = RxInt(0);
  RxInt selectedOwnerValues = RxInt(0);
  RxBool isUpdateImageAvailable = false.obs;
  RxBool isUpdateStartImageAvailable = false.obs;
  RxBool isUpdateEndImageAvailable = false.obs;
  RxString imagePathFromData  = RxString("");
  RxString startImagePathFromData  = RxString("");
  RxString endImagePathFromData  = RxString("");
  int i = 0;
  RxString? recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  RxBool others = RxBool(false);
  final startingHrFocusNode = FocusNode();
  RxBool popUpValue = RxBool(false);
  final FocusNode startingKmFocusNode = FocusNode();
  final FocusNode closingKmFocusNode = FocusNode();
  final FocusNode tollChargesFocusNode = FocusNode();
  final FocusNode amountFocusNode = FocusNode();
  final FocusNode ticketChargesFocusNode = FocusNode();
  final FocusNode driverTipsFocusNode = FocusNode();
  final FocusNode durationFocusNode = FocusNode();
  final FocusNode rateFocusNode = FocusNode();
  final FocusNode balanceFocusNode = FocusNode();
  final FocusNode currentlyPaidAmountFocusNode = FocusNode();
  final FocusNode totalChargesFocusNode = FocusNode();
  List<String> rendDetails = [];

  RxList<GetVendorData> filteredVendorNames = RxList();
  RxList<GetVendorData> allVendorNames = RxList();

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
      subCategory1Call('');
      getToCityTransport('');
      getFromCityTransport('');
      getVendor('');
      getOwner('');
      searchVendor("");
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        setData();
      }
      suggestion();

    }
  }

  Future<void> suggestion() async {
    Map<String, dynamic> payload = {
      'Category': "Travel",
    };
    print('payload:$payload');
    var response = await _connect.getSuggestionList(payload);
    if (!response.error!) {
      suggestionList.value = response.data!;

    } else {

    }
  }


  Future<void> refreshData() async {
    getToCityTransport('');
    getFromCityTransport('');
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> vendorRefreshData() async {
    getVendor('');
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> ownerRefreshData() async {
    getOwner('');
    return Future.delayed(Duration(seconds: 0));
  }
  Future<void> refreshDataOwned() async {
    driveTipsController.clear();
    tollChargesController.clear();
    ticketController.clear();
    amountController.clear();
    balanceAmountController.clear();
    currentlyPaidAmountController.clear();
    return Future.delayed(Duration(seconds: 0));
  }
  Future<void> refreshDataRented() async {
    balanceAmountController.clear();
    currentlyPaidAmountController.clear();
    return Future.delayed(Duration(seconds: 0));
  }
  void onRadioValueChangedRented(bool value) {
    print(value);
    selectedRadioRented.value = value;
  }

  Future<void> addVendor() async {
    if (secondValidation()) {
      Map<String, dynamic> payload = {
        'VendorName': vendorNameAddController.text,
        'VendorCompany': vendorCompanyController.text,
        'VendorAddress': vendorAddressAddController.text,
        'VendorGST': vendorGstController.text,
        'VendorMobile': vendorMobileController.text,
        'VendorEmail': vendorEmailController.text,
        'VendorService': vendorServiceController.text,
      };
      vendorNameAddController.clear();
      vendorCompanyController.clear();
      vendorAddressAddController.clear();
      vendorMobileController.clear();
      vendorEmailController.clear();
      vendorGstController.clear();
      vendorServiceController.clear();
      print('addVendorPayload:$payload');
      var response = await _connect.addVendorCall(payload);
      debugPrint("addVendorResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.back();
      } else
            () {};
    }
  }

  Future<void> addOwner() async {
    if (thirdValidation()) {
      Map<String, dynamic> payload = {
        'OwnerName': ownerNameController.text,
        'OwnerContact': ownerContactController.text,
        'RegisterationNumber': registrationNumberAddController.text,
        'VechicalDetails': vehiclesDetailsController.text
      };
      ownerNameController.clear();
      ownerContactController.clear();
      registrationNumberController.clear();
      vehiclesDetailsController.clear();

      print('addOwnerPayload:$payload');
      var response = await _connect.addOwnerCall(payload);
      debugPrint("addOwnerResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.back();
      } else {
            () {
          Fluttertoast.showToast(
            msg: response.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        };
      }
    }
  }

  bool secondValidation() {
    if (vendorNameAddController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter VendorName!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (vendorCompanyController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter VendorCompany!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (vendorAddressAddController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter vendorAddress!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (vendorGstController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter vendorGst!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (vendorMobileController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter vendorMobile!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    } if (vendorMobileController.text.length < 10) {
      Fluttertoast.showToast(
        msg: "Please Enter  10 numbers!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (vendorEmailController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Email!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (vendorServiceController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter vendorService!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  bool thirdValidation() {
    if (ownerNameController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter OwnerName!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (ownerContactController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter OwnerContact!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }if (ownerContactController.text.length < 10) {
      Fluttertoast.showToast(
        msg: "Please Enter 10 numbers Owner Contact number!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (registrationNumberAddController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter registrationNumber!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (vehiclesDetailsController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter vehiclesDetails!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
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

  void onRadioValueChangedOwned(bool value) {
    print(value);
    selectedRadioOwned.value = value;
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
    }  else if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      audioPlayer.setUrl("${ApiUrl.baseUrl}expense/${userDataProvider
          .getTravelData!.audioFile}");
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



  void searchVendor(String searchText) {
    filteredVendorNames.value = allVendorNames
        .where((vendor) =>
    vendor.vendorName != null &&
        vendor.vendorName!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  getVendor(String vendorName) async {
    Map<String, dynamic> payload = {
      'VendorName': vendorName,
      'page': pageIndex.value,
      'perPage': '50',
    };
    isLoading.value = true;
    var response = await _connect.getVendorCall(payload);
    isLoading.value = false;
    if (response.data != null) {
      vendorData.value = response.data!;
      debugPrint("getVendorResponse: ${response.toJson()}");
    } else {}
  }

  getOwner(String vendorName) async {
    Map<String, dynamic> payload = {
      'RegisterationNumber': vendorName,
      'page': pageIndex.value,
      'perPage': '50',
    };
    isLoading.value = true;
    var response = await _connect.getOwnerCall(payload);
    isLoading.value = false;
    if (response.data != null) {
      ownerData.value = response.data!;
      debugPrint("getOwnerResponse: ${response.toJson()}");

    } else {}
  }

  subCategory1Call(String subcategory1Name) async {
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
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        for (int i = 0; i < subCategory1.length; i++) {
          if (subCategory1[i].sub1CategoryName ==
              userDataProvider.getTravelData!.category1) {
            selectedSub1Index.value = i;
            fetchSubCategoryTwo(subCategory1[i].sub1CategoryId,"");
          }
        }
      }
    } else {}
  }

  Future<void> fetchSubCategoryTwo(int? subOneCategoryId, String search, ) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryId': subOneCategoryId,
      "Sub2CategoryName": search,
    };
    print('TRAVELID:$payload');
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



    if (fromController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter From Location!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (toController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter End Location",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }


    if (fromController.text == toController.text) {
      fromController.text = "";
      toController.text = "";
      Fluttertoast.showToast(
        msg: 'starting location and ending location is same.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (subCategory1Controller.text == 'Car' ||
        subCategory1Controller.text == 'Van' ||
        subCategory1Controller.text == 'Two Wheeler' ||
        subCategory1Controller.text == 'Three Wheeler') {

      if (startingKmController.value.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter Starting Km!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      if (closingKmController.value.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter Ending Km !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      final startingKm = int.tryParse(startingKmController.text);
      final endingKm = int.tryParse(closingKmController.text);
      if (startingKm != null && endingKm != null && endingKm <= startingKm) {
        Fluttertoast.showToast(
          msg: 'Ending kilometers must be greater than starting kilometers.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      String noOfPeopleText = amountController.text;
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

    }

    if(rentOwnedOnClick.value == true){
      if (vendorNameController.value.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter VendorName!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
    }
    if(ownedOnClick.value == true){
      if (registrationNumberController.value.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter registerNumber!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
    }
    if (noOfPeopleController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter No Of People!",
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
    return true;
  }

  Future<void> insertTravel() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'projectCode': userDataProvider.projectCode.toString(),
        'category1': "Travel",
        'category2': subCategory1Controller.text,
        'category3': subCategory2Controller.text,
        'category4': '',
        'category5': "",
        'amount': amountController.text,
        'from': fromController.text,
        'to': toController.text,
        'startingKM': startingKmController.text,
        'closingKM': closingKmController.text,
        'tollCharges': tollChargesController.text,
        'ticketCharges': ticketController.text,
        'driverTips': driveTipsController.text,
        'comments': commentController.text,
        'expenseAmount': subCategory1Controller.text == 'Car' ||
            subCategory1Controller.text == 'Van' ||
            subCategory1Controller.text == 'Two Wheeler' ||
            subCategory1Controller.text == 'Three Wheeler' ? currentlyPaidAmountController.text : amountController.text,
        'expenseDate': currentDateController.text,
        'tripCost': ticketController.text,
        'addedFrom': 'Android',
        'LedgerName': '',
        'LedgerGroups': '',        'OverallExpenseStatus': '4',

        'LedgerCategory1': '',
        'LedgerCategory2': '',
        'LedgerCategory3': '',
        'LedgerCategory4': '',
        'LedgerCategory5': '',
        'expenseStatus': '0',
        'Types': '',
        'SGST': '',
        'CGST': '',
        'IGST': '',
        'audioUpload': '2',
        'RentedOrOwned': buttonAndImageHoldVisible.value == true ? selectedRadioRented.value == true ? 'Rented' : 'Owned' : "none",
        'PerDurationType': typeController.text,
        'PerDuration': durationController.text,
        'Rate': rateController.text,
        'BalanceAmount': balanceAmountController.text,
        'VendorId': vendorData[selectedValues.value].vendorId.toString(),
        'Advance': currentlyPaidAmountController.text,
        "Others": othersController.text,
        "VendorName": vendorNameController.text,
        "RegisterationNumber": registrationNumberController.text,
        "noOfTicket": noOfPeopleController.text
      };
      print("insertTravelRequest:$payload");
      uploadLoading.value = true;
      var response = await _connect.imgTaskUpload(ApiUrl.insertTravel, itemImagePick.value!.file , payload, recordFilePath!.value ?? "");
      uploadLoading.value = false;
      debugPrint("insertFoodResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.travelSummaryScreen.toName);
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
    }
  }

  Future<void> updateTravel() async {
    if (firstValidation()){
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'ProjectCode': userDataProvider.projectCode.toString(),
        'Category1': "Travel",
        'Category2': subCategory1Controller.text,
        'Category3': subCategory2Controller.text,
        'Category4': '',
        'Category5': '',
        'From': fromController.text,
        'To': toController.text,
        'StartingKM': startingKmController.text,
        'ClosingKM': closingKmController.text,
        'TollCharges': tollChargesController.text,
        'Amount': amountController.text,
        'Comments': commentController.text,
        'TicketCharges': ticketController.text,
        'DriverTips': driveTipsController.text,
        'ExpenseDate': currentDateController.text,
        'ExpenseStatus': '0',
        'TravelExpenseId': userDataProvider.getTravelData!.id.toString(),
        'NewExpenseAmount': amountController.text,
        'OldExpenseAmount': '',
        'Images': '',
        'audioUpload': '',
        'RentedOrOwned': buttonAndImageHoldVisible.value == true ? selectedRadioRented.value == true ? 'Rented' : 'Owned' : "none",
        'PerDurationType': typeController.text,
        'PerDuration': durationController.text,
        'Rate': rateController.text,
        'BalanceAmount': balanceAmountController.text,
        'VendorId': vendorData[selectedValues.value].vendorId.toString(),
        'Advance': currentlyPaidAmountController.text,
        "Others": othersController.text,
        "VendorName": vendorNameController.text,
        "RegisterationNumber": registrationNumberController.text
      };
      print("updateTravelRequest:$payload");

      var response = await _connect.imgTaskUpdate(ApiUrl.updateTravel,itemImagePick.value.file , payload, recordFilePath!.value ?? "" );
      debugPrint("updateTravelResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.travelSummaryScreen.toName);
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
    }

  }

  Future<void> getFromCityTransport(String cityName) async {
    Map<String, dynamic> payload = {
      'CityName': cityName,
      'page': pageIndex.value,
      'perPage': '50',
    };
    print('city132132amepayload:$payload');
    var response = await _connect.getCityCall(payload);
    debugPrint("getCityTransport: ${response.toJson()}");
    if (!response.error!) {
      fromCityValues.value = response.data!;
    } else {}
  }

  Future<void> getToCityTransport(String cityName) async {
    Map<String, dynamic> payload = {
      'CityName': cityName,
      'page': pageIndex.value,
      'perPage': '50',
    };
    print('city132132amepayload:$payload');
    var response = await _connect.getCityCall(payload);
    debugPrint("getCityTransport: ${response.toJson()}");
    if (!response.error!) {
      toCityValues.value = response.data!;
    } else {}
  }

  void setData() {
    TravelData data = userDataProvider.getTravelData!;
    noOfPeopleController.text = data.noOfTicket.toString() ?? "";
    subCategory1Controller.text = data.category2 ?? "";
    subCategory2Controller.text = data.category3 ?? "";
    commentController.text = data.comments ?? "";
    driveTipsController.text = data.driverTips ?? "";
    startingKmController.text = data.startingKM ?? "";
    closingKmController.text = data.endKM ?? "";
    toController.text = data.toDate ?? "";
    fromController.text = data.fromDate ?? "";
    ticketController.text = data.ticketCharges ?? " ";
    amountController.text = data.amount ?? "";
    vendorNameController.text = data.vendorName ?? "";
    registrationNumberController.text = data.registerationNumber ?? "";
    tollChargesController.text = data.tollCharges ?? "";
    othersController.text = data.othersTravel ?? "";
    currentDateController.text = data.expenseDate ?? "";
    currentlyPaidAmountController.text = data.advance.toString();
    typeController.text = data.perDurationType.toString() ?? "";
    durationController.text = data.perDuration.toString();
    rateController.text = data.rate.toString() ?? "";
    balanceAmountController.text = data.balanceAmount.toString() ?? "";
    isSub2Available.value = true;
    publicTravels.value = true;
    locationsVisible.value = true;
    commonVisible.value = true;
    rentOwnedOnClick.value = false;
    ownedOnClick.value = false;
    buttonAndImageHoldVisible.value = false;


    if(userDataProvider.currentStatus == "Edit"){
      if(data.audioFile != null && !data.audioFile!.isEmpty) {
        isAudio.value = true;
      } else {
        isAudio.value = false;
      }
      if(data.images != null && data.images!.isNotEmpty){
        imagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.images!}";
        isUpdateImageAvailable.value = true;
      }
    }



    if (subCategory1Controller.text == 'Bus') {
      publicTravels.value = true;
      locationsVisible.value = true;
      driverTips.value = false;
      ticketCharges1.value = true;
      rentOwnedOnClick.value = false;
      ownedOnClick.value = false;
      buttonAndImageHoldVisible.value = false;
    } else if (subCategory1Controller.text == 'Rail') {
      rentOwnedOnClick.value = false;
      ownedOnClick.value = false;
      publicTravels.value = true;
      locationsVisible.value = true;
      ticketCharges1.value = true;
      buttonAndImageHoldVisible.value = false;
    } else if (subCategory1Controller.text == 'Air-way') {
      publicTravels.value = true;
      locationsVisible.value = true;
      ticketCharges1.value = true;
      tollCharges.value = false;
      buttonAndImageHoldVisible.value = false;
    } else if (subCategory1Controller.text == 'Sea-way') {
      publicTravels.value = true;
      locationsVisible.value = true;
      ticketCharges1.value = true;
      subCategory2Controller.text = "";
      buttonAndImageHoldVisible.value = false;
    } else if (subCategory1Controller.text == 'Passenger Vehicle') {
      publicTravels.value = true;
      isSub2Available.value = false;
      locationsVisible.value = false;
      amount.value = true;
    } else if (subCategory1Controller.text == 'Car') {
      driverTips.value = true;
      kiloVisible.value = true;
      locationsVisible.value = true;
      publicTravels.value = true;
      ticketCharges1.value = false;
      tollCharges.value = true;
      travelCharges.value = true;
      buttonAndImageHoldVisible.value = true;
    } else if (subCategory1Controller.text == 'Van') {
      driverTips.value = true;
      locationsVisible.value = true;
      kiloVisible.value = true;
      publicTravels.value = true;
      ticketCharges1.value = true;
      travelCharges.value = true;
      ticketCharges1.value = false;
      tollCharges.value = true;
      buttonAndImageHoldVisible.value = true;
    } else if (subCategory1Controller.text == 'Two Wheeler' ||
        subCategory1Controller.text == 'Three Wheeler') {
      publicTravels.value = true;
      subCategory2Controller.text = "";
      locationsVisible.value = true;
      kiloVisible.value = true;
      ticketCharges1.value = false;
      isSub2Available.value = false;
      tollCharges.value = false;
      driverTips.value = false;
      buttonAndImageHoldVisible.value = true;
    } else if (subCategory1Controller.text == 'Others') {
      isSub2Available.value = false;
      others.value = true;
      driverTips.value = true;
      locationsVisible.value = true;
      publicTravels.value = true;
      ticketCharges1.value = false;
      tollCharges.value = true;
      kiloVisible.value = true;
      travelCharges.value = true;
      buttonAndImageHoldVisible.value = true;
    } else {
      kiloVisible.value = false;
      ticketCharges1.value = true;
      isSub2Available.value = true;
    }
    if (data.rentedOrOwned == 'Rented') {
      rentOwnedOnClick.value = true;
      selectedRadioRented.value = true;
    } else if (data.rentedOrOwned == 'Owned') {
      selectedRadioOwned.value = true;
      ownedOnClick.value = true;
      driverTips.value = false;
    }
  }
}