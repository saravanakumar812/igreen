import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/model/responseModel/GetRentExpenseResponse.dart';
import 'package:igreen_flutter/model/responseModel/GetVendorNameResponse.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../AudioPlayer/song_repository.dart';
import '../Utils/AppPreference.dart';
import '../Utils/image_picker.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/FetchSubcategoryThreeResponse.dart';
import '../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../model/responseModel/SuggestionCommentsModel.dart';
import '../provider/menuProvider.dart';
import '../model/responseModel/FuelSubCategoryResponse.dart';
import '../routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class RentedScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;

  Rx<PickedImage> itemImageStart = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  Rx<PickedImage> itemImageEnd = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));

  RxBool pickImageSelected = false.obs;
  RxInt selectedSub1Index = RxInt(0);
  bool isCall = false;
  RxBool startImageSelected = false.obs;
  RxBool startEndImageVisible = false.obs;
  RxBool endImageSelected = false.obs;
  RxString startingDateTimeFormat = RxString("");
  RxString closingDateTimeFormat = RxString("");
  RxString currentDateTime = RxString("");
  RxInt current = RxInt(0);
  RxBool subCategoryDropDownOne = false.obs;
  RxBool rendList = false.obs;
  RxBool subCategoryDropDownTwo = false.obs;
  RxBool subCategoryDropDownTwoOnClick = false.obs;
  RxBool subCategoryDropDownThree = false.obs;
  RxBool subCategoryDropDownThreeOnClick = false.obs;
  RxString currentDate = RxString("Spend Date");
  RxString selectItemOne = RxString("Select Type");
  RxString selectItemsTwo = RxString("Select Type");
  RxString selectItemsThree = RxString("Select Type");
  RxBool selectType = false.obs;
  RxInt selectedValueCustomer = RxInt(0);
  RxBool checkedValue = RxBool(false);
  String selectedFinance = "In-House Finance";
  RxBool selectedRadioRented = false.obs;
  RxBool vehicleSelectedRadioRented = false.obs;
  RxBool vehicleSelectedRadioOwned = false.obs;
  RxBool rentTypeDropDown = false.obs;
  RxInt pageIndex = RxInt(1);
  RxBool selectedRadioOwned = false.obs;
  RxBool radioButtonVisible = false.obs;
  RxBool rentOwnedOnClick = false.obs;
  RxBool vehicleRentOwnedOnClick = false.obs;
  RxBool onClickQuantity = false.obs;
  RxBool uploadLoading = false.obs;
  RxBool onClickRate = false.obs;
  RxBool vehicleVisibleRadio = false.obs;
  RxBool isLoading = RxBool(false);
  RxBool allFieldVisible = RxBool(false);
  RxBool othersVisible = RxBool(false);
  RxBool hrVisible = RxBool(false);
  RxBool popUpValue = RxBool(false);

  RxBool kmVisible = RxBool(false);
  RxBool vendorOnClick = RxBool(false);
  RxBool pickVehicleImageSelected = false.obs;
  RxString machineRented = RxString("Rented");
  RxString machineOwned = RxString("Owned");
  RxString vehicleRented = RxString("Rented");
  RxString vehicleOwned = RxString("Owned");
  TextEditingController startingTimeFormat = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController vehicleDetailsController = TextEditingController();
  TextEditingController staringKmController = TextEditingController();
  TextEditingController closingKmController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController othersController = TextEditingController();
  TextEditingController vehicleCommentController = TextEditingController();
  TextEditingController startDateAndTimeController = TextEditingController();
  TextEditingController closeDateAndTimeController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController totalChargesController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController currentlyPaidAmountController = TextEditingController();
  TextEditingController subOneController = TextEditingController();
  TextEditingController subTwoController = TextEditingController();
  TextEditingController currentDateController = TextEditingController();
  TextEditingController vendorNameAddController = TextEditingController();
  TextEditingController vendorCompanyController = TextEditingController();
  TextEditingController vendorAddressAddController = TextEditingController();
  TextEditingController vendorGstController = TextEditingController();
  TextEditingController vendorMobileController = TextEditingController();
  TextEditingController vendorEmailController = TextEditingController();
  TextEditingController vendorServiceController = TextEditingController();
  TextEditingController balanceAmountController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  RxString rendBase = RxString("Duration Type");
  RxList<FuelSubOneData> fuelSubCategoryData = RxList();
  RxList<SubcategoryTwoData> fetchCategoryTwo = RxList();
  RxList<GetVendorData> vendorData = RxList();
  bool isComplete = false;
  int i = 0;
  RxString? recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  DateTime? selectedDay;
  DateTime selectedDateTime = DateTime.now();
  final FocusNode startingKmFocusNode = FocusNode();
  final FocusNode closingKmFocusNode = FocusNode();
  final FocusNode durationFocusNode = FocusNode();
  final FocusNode rateFocusNode = FocusNode();
  final FocusNode balanceFocusNode = FocusNode();
  final FocusNode currentlyPaidAmountFocusNode = FocusNode();
  final FocusNode totalChargesFocusNode = FocusNode();
  RxBool isUpdateImageAvailable = false.obs;
  RxBool isUpdateStartImageAvailable = false.obs;
  RxBool isUpdateEndImageAvailable = false.obs;
  RxString imagePathFromData  = RxString("");
  RxString startImagePathFromData  = RxString("");
  RxString endImagePathFromData  = RxString("");
  String vendorName = "";
  String subcategoryName = "";
  late final SongRepository songRepository;
  RxBool isSuggestionComments = false.obs;
  RxList<SuggestionData> suggestionList = RxList();

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    songRepository = SongRepository();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    currentDateController.text = userDataProvider.getDate!;

    if (!isCall) {
      isCall = true;
      subCategoryFuel('');
      getVendor('');
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        setData();
      } if (userDataProvider.getCurrentStatus == "Edit"
      ) {
        setImage();
      }

      suggestion();

    }
  }

  Future<void> suggestion() async {
    Map<String, dynamic> payload = {
      'Category': "Rental",
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
      audioPlayer.setUrl("${ApiUrl.baseUrl}expense/${userDataProvider
          .getRentData!.audioFile}");
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

  void vehicleRadioValueChangedRented(bool value) {
    print(value);
    vehicleSelectedRadioRented.value = value;
  }

  void vehicleRadioValueChangedOwn(bool value) {
    print(value);
    vehicleSelectedRadioOwned.value = value;
  }

  void onRadioValueChangedRented(bool value) {
    print(value);
    selectedRadioRented.value = value;
  }

  void onRadioValueChangedOwned(bool value) {
    print(value);
    selectedRadioOwned.value = value;
  }

  Future<void> refreshData() async {
    getVendor('');
    return Future.delayed(Duration(seconds: 0));
  }

  subCategoryFuel(String subcategory1Name) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryName': subcategory1Name,
    };
    print("ExpenseCategoryId$payload");

    isLoading.value = true;
    var response = await _connect.fuelSubCategory(payload);
    isLoading.value = false;
    debugPrint("subCateory: ${response.toJson()}");
    if (!response.error!) {
      fuelSubCategoryData.value = response.data!;
    } else
          () {};
  }

  Future<void> fetchSubCategoryTwo(int? subOneCategoryId, String search) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryId': subOneCategoryId,
      "Sub2CategoryName": search,
    };
    print('1223Payload:$payload');
    var response = await _connect.fetchCategoryTwoCall(payload);
    debugPrint("fetchSubCategoryTwo: ${response.toJson()}");
    if (!response.error!) {
      fetchCategoryTwo.value = response.data!;
      update();
    } else
          () {};
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
    }if (vendorMobileController.text.length < 10) {
      Fluttertoast.showToast(
        msg: "Please Enter  10 Numbers In Vendor Mobile Number!",
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

  Future<void> refreshDataKm() async {
    // kmVisible.value = false;
    staringKmController.clear();
    closingKmController.clear();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> refreshDataHr() async {

    startDateAndTimeController.clear();
    closeDateAndTimeController.clear();
    return Future.delayed(Duration(seconds: 0));
  }

  bool firstValidation() {


    if (typeController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Duration Type!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }


    if (subOneController.text == 'Truck' &&
        subTwoController.text == 'Mud Tanker') {
      if (staringKmController.value.text.isEmpty) {
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
      final startingKm = int.tryParse(staringKmController.text);
      final endingKm = int.tryParse(closingKmController.text);
      if (startingKm != null && endingKm != null && endingKm <= startingKm) {
        Fluttertoast.showToast(
          msg: 'Ending kilometers must be greater than starting kilometers!.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
    }

    if (subOneController.text == 'Truck' &&
        subTwoController.text == 'Machine truck') {
      if (staringKmController.value.text.isEmpty) {
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
      final startingKm = int.tryParse(staringKmController.text);
      final endingKm = int.tryParse(closingKmController.text);
      if (startingKm != null && endingKm != null && endingKm <= startingKm) {
        Fluttertoast.showToast(
          msg: 'Ending kilometers must be greater than starting kilometers!.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
    }



    if (subOneController.text == 'Truck' && subTwoController.text == 'Truck') {
      if (staringKmController.value.text.isEmpty) {
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
      final startingKm = int.tryParse(staringKmController.text);
      final endingKm = int.tryParse(closingKmController.text);
      if (startingKm != null && endingKm != null && endingKm <= startingKm) {
        Fluttertoast.showToast(
          msg: 'Ending kilometers must be greater than starting kilometers!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
    }



    if (subOneController.text == 'Truck' &&
        subTwoController.text == 'Mini Truck') {
      if (staringKmController.value.text.isEmpty) {
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
      final startingKm = int.tryParse(staringKmController.text);
      final endingKm = int.tryParse(closingKmController.text);
      if (startingKm != null && endingKm != null && endingKm <= startingKm) {
        Fluttertoast.showToast(
          msg: 'Ending kilometers must be greater than starting kilometers!.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
    }


    if (subOneController.text == 'Truck' && subTwoController.text == 'Water tanker') {
      if (staringKmController.value.text.isEmpty) {
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
      final startingKm = int.tryParse(staringKmController.text);
      final endingKm = int.tryParse(closingKmController.text);
      if (startingKm != null && endingKm != null && endingKm <= startingKm) {
        Fluttertoast.showToast(
          msg: 'Ending kilometers must be greater than starting kilometers!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
    }

    if(subOneController.text == 'Motor'){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
      if( closeDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Close Date And Time ! ",
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
          Fluttertoast.showToast(
            msg: "End date is greater than start date!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          return false;
        }
        return false;
      }
    }

    if(  subOneController.text == 'Trencher' && subTwoController.text == 'ROCK TRENCHER' ){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
    if( closeDateAndTimeController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Please Enter Close Date And Time !",
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
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }}

    if(  subOneController.text == 'Trencher' && subTwoController.text == 'MICRO TRENCHER' ){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
      if( closeDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Close Date And Time !",
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
          Fluttertoast.showToast(
            msg: "End date is greater than start date!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          return false;
        }
        return false;
      }
    }

    if(  subOneController.text == 'Trencher' && subTwoController.text == 'TRENCHER' ){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
    if( closeDateAndTimeController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Please Enter Close Date And Time !",
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
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }}

    if(  subOneController.text == 'Earth movers' && subTwoController.text == 'TYRE MOUNTED' ){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
    if( closeDateAndTimeController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Please Enter Close Date And Time ! ",
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
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }}
    if(  subOneController.text == 'Earth movers' && subTwoController.text == 'BELT MOUNTED' ){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
    if( closeDateAndTimeController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Please Enter Close Date And Time ! ",
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
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }}
    if(  subOneController.text == 'Hydra' && subTwoController.text == 'FOUR WHEEL' ){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
    if( closeDateAndTimeController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Please Enter Close Date And Time ! ",
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
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }}
    if(  subOneController.text == 'Pilling equipment' ){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
    if( closeDateAndTimeController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Please Enter Close Date And Time !",
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
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }}

    if(  subOneController.text == 'Suction truck' ){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
    if( closeDateAndTimeController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Please Enter Close Date And Time ! ",
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
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }}
    if(  subOneController.text == 'Generator set' ){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
    if( closeDateAndTimeController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Please Enter Close Date And Time ! ",
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
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }}
    if(  subOneController.text == 'WINCH MACHINE' ){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time ! ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
    if( closeDateAndTimeController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Please Enter Close Date And Time ! ",
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
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }}
    if(  subTwoController.text == 'Tractor'){
      if( startDateAndTimeController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;

      }
    if( closeDateAndTimeController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Please Enter Close Date And Time ! ",
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
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }}

    if (selectedStartDate != null &&
        selectedEndDate != null &&
        selectedStartDate!.isAfter(selectedEndDate!)) {
      if (selectedStartDate!.isAfter(selectedEndDate!)) {
        Fluttertoast.showToast(
          msg: "End date is greater than start date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }
    if (totalChargesController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Rent Charges!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (currentlyPaidAmountController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Currently Paid Amount!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (double.parse(currentlyPaidAmountController.text) >
        double.parse(totalChargesController.text)) {
      Fluttertoast.showToast(
        msg: "Currently paid amount should be less than Rend Charges!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
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
        msg: "Please Enter Comments!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> insetRent() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'projectCode': userDataProvider.projectCode.toString(),
        'category1': "Rental",
        'category2': subOneController.text,
        'category3': subTwoController.text,
        'category4': '',
        'category5': '',
        'Others': othersController.text,
        'StartingHR': startDateAndTimeController.text,
        'EndHR': closeDateAndTimeController.text,
        'startingKM': staringKmController.text,
        'closingKM': closingKmController.text,
        'Comments': commentController.text,
        'DurationType': typeController.text,
        'Duration': durationController.text,
        'vendorName': vendorNameController.text,
        'VendorAddress': vehicleDetailsController.text,
        'VendorContact': vehicleDetailsController.text,
        'Advance': currentlyPaidAmountController.text,
        'RentType': rentController.text,
        'TotalCharges': totalChargesController.text,
        'expenseAmount': currentlyPaidAmountController.text,
        'expenseDate': currentDateController.text,
        'addedFrom': 'Android',
        'expenseStatus': '0',
        'Types': '',
        'SGST': '',
        'CGST': '',
        'IGST': '',
        'LedgerName': '',
        'LedgerGroups': '',
        'LedgerCategory1': '',        'OverallExpenseStatus': '4',

        'LedgerCategory2': '',
        'LedgerCategory3': '',
        'LedgerCategory4': '',
        'LedgerCategory5': '',
        'balanceAmount': balanceAmountController.text,
        "Rate": rateController.text,
      };
      print("rentInsertPayload:$payload");
      uploadLoading.value = true;
      var response = await _connect.imgUpload(ApiUrl.insertRend, itemImagePick.value.file ,itemImageStart.value.file,
        itemImageEnd.value.file, payload, recordFilePath!.value ?? "",);
      uploadLoading.value = false;
      debugPrint("rentInsertResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.rentSummary.toName);
        Get.deleteAll();
      } else
            () {};
    }
  }

  Future<void> updateRent() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'ProjectCode': userDataProvider.projectCode.toString(),
        'Category1': "Rental",
        'Category2': subOneController.text,
        'Category3': subTwoController.text,
        'Category4': '',
        'Category5': '',
        'Others': '',
        'StartingHr': startDateAndTimeController.text,
        'EndHr': startDateAndTimeController.text,
        'StartingKM': staringKmController.text,
        'ClosingKM': closingKmController.text,
        'Comments': commentController.text,
        'DurationType': typeController.text,
        'Duration': durationController.text,
        'VendorName': vendorNameController.text,
        'VendorAddress': vehicleDetailsController.text,
        'VendorContact': vehicleDetailsController.text,
        'Advance': currentlyPaidAmountController.text,
        'RentType': rentController.text,
        'TotalCharges': totalChargesController.text,
        'Images': '',
        'AudioFile': '1',
        'StartingImages': "",
        'EndingImages': '',
        'ExpenseDate': currentDateController.text,
        'addedFrom': 'Android',
        'ExpenseStatus': '0',
        'Types': '',
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
        'OldExpenseAmount': '',
        'RentedExpenseId': userDataProvider.getRentData!.id.toString(),
        'NewExpenseAmount': '',
        'balanceAmount': balanceAmountController.text,
        'oldbalanceAmount': '',
        "Rate": rateController.text,
      };
      print('rentUpdateRequest$payload');
      var response = await _connect.imgUpdate(ApiUrl.updateRend, itemImagePick.value.file ,itemImageStart.value.file,
        itemImageEnd.value.file, payload, recordFilePath!.value ?? "",);
      debugPrint("rentUpdateResponse: ${response.toJson()}");
      Get.offNamed(AppRoutes.rentSummary.toName);
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.rentSummary.toName);
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

  void setData() {
    GetRentData data = userDataProvider.getRentData!;
    subOneController.text = data.category2 ?? "";
    subTwoController.text = data.category3 ?? "";
    startDateAndTimeController.text = data.startingHr ?? "";
    closeDateAndTimeController.text = data.endHr ?? "";
    staringKmController.text = data.startingKM ?? "";
    closingKmController.text = data.endKM ?? "";
    commentController.text = data.comment ?? "";
    typeController.text = data.durationType ?? "";
    vendorNameController.text = data.vendorName ?? "";
    vehicleDetailsController.text = data.vendorName ?? "";
    rentController.text = data.rentType ?? "";
    currentlyPaidAmountController.text = data.advance ?? "";
    currentDateController.text = data.expenseDate ?? "";
    amountController.text = data.expenseAmount ?? "";
    totalChargesController.text = data.totalCharges ?? "";
    durationController.text = data.duration ?? "";
    balanceAmountController.text = data.balanceAmount ?? "";
    rateController.text = data.rate ?? "";
    allFieldVisible.value = true;
    subCategoryDropDownTwo.value = true;
    hrVisible.value = false;
    othersVisible.value = false;
    kmVisible.value = false;


    if (subOneController.text == 'WINCH MACHINE' ||
        subOneController.text == 'Motor' ||
        subOneController.text == 'WINCH MACHINE' ||
        subOneController.text == 'Generator set' ||
        subOneController.text == 'Others' ||
        subOneController.text == 'Suction truck') {
      hrVisible.value = true;
      subCategoryDropDownTwo.value = false;
      subCategoryDropDownTwo.value = false;
    } else {
      hrVisible.value = false;
      kmVisible.value = true;
      subCategoryDropDownTwo.value = true;
    }



    if (subOneController.text == 'Trencher') {

      rendDetails.add('Per Hour');
      rendDetails.add('Day');
      rendDetails.add('Month Basis');
      rendDetails.add('One Time');
      rendDetails.add('Lease');
      rendDetails.add('Shot Length(meters)');
    } else if (subOneController.text == 'Truck') {
      rendDetails.add('Month');
      rendDetails.add('Day');
      rendDetails.add('Lease');
      rendDetails.add('One Time');
    } else if (subOneController.text == 'Earth movers') {

      rendDetails.add('Per Hour');
      rendDetails.add('Day');
      rendDetails.add('Month Basis');
      rendDetails.add('One Time');
      rendDetails.add('Lease');
    } else if (subOneController.text == 'Hydra') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
      rendDetails.add('Month Basis');
      rendDetails.add('One Time');
      rendDetails.add('Lease');
    } else if (subOneController.text == 'Suction truck') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
      rendDetails.add('Month Basis');
      rendDetails.add('One Time');
      rendDetails.add('Lease');
    } else if (subOneController.text == 'Pilling equipment') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
      rendDetails.add('Month Basis');
      rendDetails.add('One Time');
      rendDetails.add('Lease');
      rendDetails.add('Feet');
      rendDetails.add('Meters');
    } else if (subOneController.text == 'WINCH MACHINE') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
      rendDetails.add('Month Basis');
      rendDetails.add('One Time');
      rendDetails.add('Lease');
      rendDetails.add('Feet');
      rendDetails.add('Meters');
    } else if (subOneController.text == 'Motor') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
      rendDetails.add('Month Basis');
      rendDetails.add('One Time');
      rendDetails.add('Lease');
      rendDetails.add('Feet');
    } else if (subOneController.text == 'Generator set') {
      rendDetails.add('Per Hour');
      rendDetails.add('Day');
      rendDetails.add('Month Basis');
      rendDetails.add('One Time');
      rendDetails.add('Lease');
      rendDetails.add('Feet');
    }
    hrVisible.value = true;
    othersVisible.value = false;
    kmVisible.value = false;
    subCategoryDropDownTwo.value = false;
    if (subOneController.text == 'Earth movers') {
      hrVisible.value = true;

    } else if (subOneController.text == 'Others') {
      othersVisible.value = true;
      kmVisible.value = false;
    } else if (subOneController.text == 'Motor' ||
        subOneController.text == 'WINCH MACHINE' ||
        subOneController.text == 'Generator set' ||
        subOneController.text == 'Others' ||
        subOneController.text == 'Suction truck') {
      hrVisible.value = true;
    } else if (subOneController.text == 'Trencher') {
      kmVisible.value = false;
      subCategoryDropDownTwo.value = true;
      hrVisible.value = true;
    } else if (subOneController.text == 'Pilling equipment') {
      kmVisible.value = false;
      subCategoryDropDownTwo.value = true;
      hrVisible.value = true;
    } else if (subOneController.text == 'Truck') {
      kmVisible.value = true;
      subCategoryDropDownTwo.value = true;
      hrVisible.value = false;
    } else if (subOneController.text == 'Hydra') {
      subCategoryDropDownTwo.value = true;
      hrVisible.value = true;
    } else {}

    if (subTwoController.text == 'Tractor' ||
        subTwoController.text == 'TYRE MOUNTED' ||
        subTwoController.text == 'ROCK TRENCHER' ||
        subTwoController.text == 'MICRO TRENCHER' ||
        subTwoController.text == 'TRENCHER' ||
        subTwoController.text == 'FOUR WHEEL' ||
        subTwoController.text == 'Small' ||
        subTwoController.text == 'Large') {
      hrVisible.value = true;

    } else if (subTwoController.text == 'BELT MOUNTED') {
      hrVisible.value = true;

    } else {
      kmVisible.value = true;





    }
  }


  void setImage(){
    GetRentData data = userDataProvider.getRentData!;
    if(data.audioFile != null && !data.audioFile!.isEmpty) {
      isAudio.value = true;
    } else {
      isAudio.value = false;
    }
    if(data.images != null && data.images!.isNotEmpty){
      imagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.images!}";
      isUpdateImageAvailable.value = true;
    }
    if(data.startingImage != null && data.startingImage!.isNotEmpty){
      startImagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.startingImage!}";
      isUpdateStartImageAvailable.value = true;
    }
    if(data.endingImage != null && data.endingImage!.isNotEmpty){
      endImagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.endingImage!}";
      isUpdateEndImageAvailable.value = true;
    }
  }

  List<String> rendDetails = [];
  List<String> rendTypeDetail = [
    'Advance',
    'Full Settlement',
    'Part Payment',

  ];
}