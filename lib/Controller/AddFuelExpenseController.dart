import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../Utils/AppPreference.dart';
import '../Utils/image_picker.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/LoginResponseModel.dart';
import '../model/responseModel/FetchSubcategoryFourResponse.dart';
import '../model/responseModel/FetchSubcategoryThreeResponse.dart';
import '../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../model/responseModel/GetFuelExpenseResponse.dart';
import '../model/responseModel/GetOwnerResponse.dart';
import '../model/responseModel/GetVendorNameResponse.dart';
import '../model/responseModel/SuggestionCommentsModel.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class AddFuelExpenseController extends GetxController {
  Rx<PickedImage> itemImageStart = Rx<PickedImage>(PickedImage(
      imagePath: null,
      file: null,
      renderType: RenderImage.platform,
      extension: '',
      base64: ''));
  Rx<PickedImage> itemImageEnd = Rx<PickedImage>(PickedImage(
      imagePath: null,
      file: null,
      renderType: RenderImage.platform,
      extension: '',
      base64: ''));
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(
      imagePath: null,
      file: null,
      renderType: RenderImage.platform,
      extension: '',
      base64: ''));

  //Rx<PickedImage?> itemVehicleImagePick = Rx<PickedImage?>(null);
  RxBool ownerButtonClick = false.obs;
  RxBool uploadLoading = false.obs;
  RxBool isUpdateImageAvailable = false.obs;
  RxBool isUpdateStartImageAvailable = false.obs;
  RxBool isUpdateEndImageAvailable = false.obs;
  RxString imagePathFromData = RxString("");
  RxString startImagePathFromData = RxString("");
  RxString endImagePathFromData = RxString("");
  RxInt selectedSub1Index = RxInt(0);
  RxInt selectedSub2Index = RxInt(0);
  RxBool isSub2Available = RxBool(false);
  RxBool allVisible = RxBool(false);
  RxBool isSub1 = RxBool(false);
  RxBool startImageSelected = false.obs;
  RxBool endImageSelected = false.obs;
  RxString startingDateTimeFormat = RxString("");
  RxString closingDateTimeFormat = RxString("");
  RxString startingDateTimeFormatDiesel = RxString("");
  RxString closingDateTimeFormatDiesel = RxString("");
  RxString currentDateTime = RxString("");
  bool isCall = false;
  TextEditingController dateAndTimeController = TextEditingController();
  RxBool selected = false.obs;
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxBool popUpValue = RxBool(false);
  RxBool hoursVisible = RxBool(false);
  RxList<Data> fuelSubCategoryData = RxList();
  RxBool pickImageSelected = false.obs;
  RxBool pickVehicleImageSelected = false.obs;
  RxList<PickedImage> productImages = RxList();
  final CarouselController carouselController = CarouselController();
  RxInt current = RxInt(0);
  RxBool subCategoryDropDownOne = false.obs;
  RxBool isSuggestionComments = false.obs;
  RxBool subCategoryDropDownTwo = false.obs;
  RxBool kmVisible = false.obs;
  RxBool subCategoryDropDownTwoOnClick = false.obs;
  RxBool subCategoryDropDownThree = false.obs;
  RxBool subCategoryDropDownThreeOnClick = false.obs;
  RxBool currentDateOnClick = false.obs;
  RxString currentDate = RxString("Spend Date");
  RxString selectCurrent = RxString("Spend Date");
  RxString selectItemOne = RxString("Select Type");
  RxString selectItemsTwo = RxString("Select Type");
  RxString selectItemsThree = RxString("Select Type");
  RxBool selectType = false.obs;
  RxInt selectedValueCustomer = RxInt(0);
  RxBool buttonAndImageHoldVisibleOther = RxBool(false);
  RxBool hoursVisibleDiesel = RxBool(false);
  RxBool buttonAndImageHoldVisible = RxBool(false);
  String selectedFinance = "In-House Finance";
  RxBool selectedRadioRented = false.obs;
  RxBool vehicleSelectedRadioRented = false.obs;
  RxBool vehicleSelectedRadioOwned = false.obs;
  RxBool selectedRadioOwned = false.obs;
  RxBool selectedSinglePhase = false.obs;
  RxBool selectedThreePhase = false.obs;
  RxBool selectedOtherPhase = false.obs;
  RxBool machineDetailVisible = false.obs;
  RxBool rentOwnedOnClick = false.obs;
  RxBool rentOwnedOnClick1 = false.obs;
  RxBool ownedOnClick = false.obs;
  RxBool ownedOnClick1 = false.obs;
  RxBool singlePhaseButtonClick = false.obs;
  RxBool threePhaseButtonClick = false.obs;
  RxBool otherButtonClick = false.obs;

  RxBool vehicleRentOwnedOnClick = false.obs;
  RxBool onClickQuantity = false.obs;
  RxBool onClickRate = false.obs;
  RxBool vehicleVisibleRadio = false.obs;
  RxBool vehicleVisibleRadio1 = false.obs;
  RxBool generatorVisible = false.obs;
  RxBool othersVisible = false.obs;
  RxBool isLoading = RxBool(false);
  RxString machineRented = RxString("Rented");
  RxString machineOwned = RxString("Owned");
  RxString singlePhase = RxString("Single");
  RxString threePhase = RxString("Three");
  RxString other = RxString("Others");
  String subcategoryName = '';
  String registrationNumber = '';
  String vendorName = '';
  TextEditingController typeControllerOne = TextEditingController();
  TextEditingController typeControllerTwo = TextEditingController();
  TextEditingController typeControllerThree = TextEditingController();
  TextEditingController dateAndTimeControllerST = TextEditingController();
  TextEditingController currentDateController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController othersVehicleController = TextEditingController();
  TextEditingController otherPhaseController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController vehicleDetailsController = TextEditingController();
  TextEditingController staringKmController = TextEditingController();
  TextEditingController closingKmController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController vehicleCommentController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController eAmountController = TextEditingController();
  TextEditingController startDateAndTimeController = TextEditingController();
  TextEditingController closeDateAndTimeController = TextEditingController();
  TextEditingController vehiclesDetailsController = TextEditingController();
  TextEditingController ownerContactController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController vendorNameAddController = TextEditingController();
  TextEditingController vendorCompanyController = TextEditingController();
  TextEditingController vendorAddressAddController = TextEditingController();
  TextEditingController vendorGstController = TextEditingController();
  TextEditingController vendorMobileController = TextEditingController();
  TextEditingController vendorEmailController = TextEditingController();
  TextEditingController vendorServiceController = TextEditingController();

  // TextEditingController closeDateAndTimeController = TextEditingController();
  TextEditingController startingDateAndTimeController = TextEditingController();
  RxList<SubcategoryTwoData> fetchCategoryTwo = RxList();
  RxList<SuggestionData> suggestionList = RxList();
  RxList<SubcategoryThreeData> fetchCategoryThree = RxList();
  RxList<SubcategoryFourData> fetchCategoryFour = RxList();
  RxList<GetVendorData> vendorData = RxList();
  RxList<GetOwnerData> ownerData = RxList();
  RxBool vendorOnClick = RxBool(false);
  RxBool ownerOnClick = RxBool(false);
  RxBool vehihilesDetailsClick = RxBool(false);
  RxInt pageIndex = RxInt(1);
  final FocusNode quantityFocusNode = FocusNode();
  final FocusNode rateFocusNode = FocusNode();
  final FocusNode amountFocusNode = FocusNode();
  final FocusNode startingKmFocusNode = FocusNode();
  final FocusNode closingKmFocusNode = FocusNode();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  RxString filename = RxString('');
  bool isComplete = false;
  int i = 0;
  RxString recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);

  void onRadioValueChangedRented(bool value) {
    print(value);
    selectedRadioRented.value = value;
  }

  void onRadioValueChangedOwned(bool value) {
    print(value);
    selectedRadioOwned.value = value;
  }

  void vehicleRadioValueChangedRented(bool value) {
    print(value);
    vehicleSelectedRadioRented.value = value;
  }

  void vehicleRadioValueChangedOwn(bool value) {
    print(value);
    vehicleSelectedRadioOwned.value = value;
  }

  void singlePhaseOnClick(bool value) {
    print(value);
    selectedSinglePhase.value = value;
  }

  void threePhaseOnClick(bool value) {
    print(value);
    selectedThreePhase.value = value;
  }

  void otherClick(bool value) {
    print(value);
    selectedOtherPhase.value = value;
  }

  Future<void> vendorRefreshData() async {
    getVendor('');
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> ownerRefreshData() async {
    getOwner('');
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    getVendor('');
    getOwner('');
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    currentDateController.text = userDataProvider.getDate!;
    if (!isCall) {
      isCall = true;
      getVendor('');
      getOwner('');
      fetchSubCategoryTwo('');
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        setData();
      }
      suggestion();
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

  void deleteAudioUrl() {
    File("${ApiUrl.baseUrl}expense/${userDataProvider.getFuelExpenseData!.audioFile!.isEmpty}")
        .delete();
    isAudio.value = false;
  }

  void play() {
    if (recordFilePath != null && File(recordFilePath!.value).existsSync()) {
      audioPlayer.setFilePath(recordFilePath!.value);
      audioPlayer.play();
    } else if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      audioPlayer.setUrl(
          "${ApiUrl.baseUrl}expense/${userDataProvider.getFuelExpenseData!.audioFile}");
      audioPlayer.play();
    }
  }

  void deleteRadioButton() async {
    rentOwnedOnClick.value = false;
    vendorOnClick.value = false;
    ownedOnClick1.value = false;
    onRadioValueChangedRented(false);
    onRadioValueChangedOwned(false);
    vendorNameController.text = "";
    registrationNumberController.text = "";
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
    }
    if (vendorMobileController.text.length < 10) {
      Fluttertoast.showToast(
        msg: "Please Enter vendorMobile 10 numbers!",
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
    }
    if (ownerContactController.text.length < 10) {
      Fluttertoast.showToast(
        msg: "Please Enter OwnerContact 10 numbers!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (registrationNumberController.value.text.isEmpty) {
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
        getVendor('');
      } else
        () {};
    }
  }

  Future<void> addOwner() async {
    if (thirdValidation()) {
      Map<String, dynamic> payload = {
        'OwnerName': ownerNameController.text,
        'OwnerContact': ownerContactController.text,
        'RegisterationNumber': registrationNumberController.text,
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

  Future<void> fetchSubCategoryTwo(String subCategoryTwo) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryId': userDataProvider.subOneCategoryId.toString(),
      "Sub2CategoryName": subCategoryTwo
    };
    print('addPayload:$payload');
    var response = await _connect.fetchCategoryTwoCall(payload);
    if (!response.error!) {
      fetchCategoryTwo.value = response.data!;
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        // for (int i = 0; i < fetchCategoryTwo.length; i++) {
        //   if (fetchCategoryTwo[i].sub2CategoryName ==
        //       userDataProvider.getFuelExpenseData!.category3) {
        //     fetchSubCategoryThree(fetchCategoryTwo[i].sub2CategoryId,"");
        //   }
        // }
      }
      update();
    } else
      () {};
  }

  Future<void> fetchSubCategoryThree(
      int? subTwoCategoryId, String sub3CategoryName) async {
    Map<String, dynamic> payload = {
      'Sub2CategoryId': subTwoCategoryId,
      "Sub3CategoryName": sub3CategoryName,
    };
    print('threePayload:$payload');
    var response = await _connect.fetchCategoryThreeCall(payload);
    if (!response.error!) {
      fetchCategoryThree.value = response.data!;
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        subCategoryDropDownTwoOnClick.value = true;

        // }
      }

      update();
    } else
      () {};
  }

   Future<void> suggestion() async {
    Map<String, dynamic> payload = {
      'Category': "Fuel",
    };
    print('payload:$payload');
    var response = await _connect.getSuggestionList(payload);
    if (!response.error!) {
      suggestionList.value = response.data!;

    } else {

    }
  }

  Future<void> fetchSubCategoryFour(int? subThreeCategoryId) async {
    Map<String, dynamic> payload = {
      'Sub3CategoryId': subThreeCategoryId,
    };
    print("EXPENSE$payload");
    var response = await _connect.fetchCategoryFourCall(payload);
    debugPrint("SUBFOURRESPONSE: ${response.toJson()}");
    if (!response.error!) {
      fetchCategoryFour.value = response.data!;
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

  Future<void> refreshDataKm() async {
    kmVisible.value = false;
    staringKmController.clear();
    closingKmController.clear();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> refreshDataHr() async {
    hoursVisible.value = false;
    startDateAndTimeController.clear();
    closeDateAndTimeController.clear();
    return Future.delayed(Duration(seconds: 0));
  }

  bool firstValidation() {



    if (typeControllerOne.text == 'Vehicles') {
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
          msg: 'Ending kilometers must be greater than starting kilometers.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
    }
    if (typeControllerOne.text == 'Machines' &&
        typeControllerTwo.text == 'Others') {
      if (startDateAndTimeController.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter Start Date And Time !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }
      if (closeDateAndTimeController.text.isEmpty) {
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
          print('End datetime is greater than start datetime');
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
    if (commentController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter comments !",
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
        print('End datetime is greater than start datetime');
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
    if (rentOwnedOnClick.value == true) {
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
    if (ownedOnClick.value == true) {
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
      if (expenseAmountController.value.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter ExpenseAmount!",
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

    }
    return true;
  }

  Future<void> insertFuel() async {
    String id = AppPreference().getEmpId.toString();
    print('idPrint:$id');
    print(
      "Project12334:" + userDataProvider.projectCode.toString(),
    );
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'projectCode': userDataProvider.projectCode.toString(),
        'category1': 'Fuel',
        'category2': userDataProvider.subCategoryName.toString(),
        'category3': typeControllerOne.text,
        'category4': typeControllerTwo.text,
        'category5': typeControllerThree.text,
        'rentedOrOwned': buttonAndImageHoldVisible.value && selectedRadioRented.value
                ? 'Rented'
                : selectedRadioOwned.value
                    ? 'Owned'
                    : '',
        'vendorName': vendorNameController.text,
        'StartingHr': startDateAndTimeController.text,
        'closingHourse': closeDateAndTimeController.text,
        'Quantity': quantityController.text,
        'Amount': expenseAmountController.text,
        'RegisterationNumber': registrationNumberController.text,
        'vechicalDetails': vehicleDetailsController.text,
        'startingKM': staringKmController.text,
        'closingKM': closingKmController.text,
        'Comments': commentController.text,
        'rate': rateController.text,
        'lumsumCharges': '',
        'otherMachineCategories': typeControllerOne.text == 'Machines'
            ? othersVehicleController.text
            : '',
        'otherVehicleCategories': typeControllerOne.text == 'Vehicles'
            ? othersVehicleController.text
            : '',
        'phase': '',
        'otherPhase': '',
        'expenseAmount': expenseAmountController.text,
        'expenseDate': currentDateController.text,
        'addedFrom': 'Android',
        'LedgerName': '',
        'LedgerGroups': '',
        'LedgerCategory1': '',
        'LedgerCategory2': '',
        'OverallExpenseStatus': '4',
        'LedgerCategory3': '',
        'LedgerCategory4': '',
        'LedgerCategory5': '',
        'expenseStatus': '0',
        'Types': '',
        'SGST': '',
        'CGST': '',
        'IGST': '',
      };
      print("insertPayload:$payload");
      uploadLoading.value = true;

      var response = await _connect.imgUpload(
          ApiUrl.insertFuel,
          itemImagePick.value.file,
          itemImageStart.value.file,
          itemImageEnd.value.file,
          payload,
          recordFilePath.value ?? "");
      uploadLoading.value = false;
      debugPrint("insertFuel: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.fuelSummary.toName);
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

  Future<void> updateFuel() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'ProjectCode': userDataProvider.projectCode.toString(),
        'fuelExpenseId':
            userDataProvider.getFuelExpenseData!.fuelExpenseId.toString(),
        'Category1': 'Fuel',
        'Category2': userDataProvider.subCategoryName.toString(),
        'Category3': typeControllerOne.text,
        'Category4': typeControllerTwo.text,
        'Category5': typeControllerThree.text,
        'RentedOrOwned':
            buttonAndImageHoldVisible.value && selectedRadioRented.value
                ? 'Rented'
                : selectedRadioOwned.value
                    ? 'Owned'
                    : '',
        'VendorName': vendorNameController.text,
        'StartingHr': startDateAndTimeController.text,
        'ClosingHourse': closeDateAndTimeController.text,
        'Quantity': quantityController.text,
        'Amount': amountController.text,
        'RegisterationNumber': registrationNumberController.text,
        'VechicalDetails': vehicleDetailsController.text,
        'StartingKM': staringKmController.text,
        'ClosingKM': closingKmController.text,
        'Comments': commentController.text,
        'Rate': rateController.text,
        'LumsumCharges': '',
        'OtherMachineCategories': '',
        'Phase': '',
        'OtherPhase': '',
        'NewExpenseAmount': expenseAmountController.text,
        'ExpenseDate': currentDateController.text,
        'OldExpenseAmount': '',
      };
      print('122updateRequest$payload');
      var response = await _connect.imgUpdate(
          ApiUrl.updateFuelList,
          itemImagePick.value.file,
          itemImageStart.value.file,
          itemImageEnd.value.file,
          payload,
          recordFilePath.value ?? "");
      debugPrint("updateResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.fuelSummary.toName);
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
    ;
  }

  void setData() {
    FuelExpenseData data = userDataProvider.getFuelExpenseData!;
    typeControllerOne.text = data.category3 ?? "";
    typeControllerTwo.text = data.category4 ?? "";
    typeControllerThree.text = data.category5 ?? "";
    vendorNameController.text = data.vendorName ?? "";
    currentDateController.text = data.expenseDate ?? "";
    vendorNameController.text = data.vendorName ?? "";
    startDateAndTimeController.text = data.startingHr ?? "";
    closeDateAndTimeController.text = data.endHr ?? "";
    amountController.text = data.amount ?? "";
    registrationNumberController.text = data.registerationNumber ?? "";
    vehicleDetailsController.text = data.vechicalDetails ?? "";
    staringKmController.text = data.startKM ?? "";
    closingKmController.text = data.endKM ?? "";
    commentController.text = data.comment ?? "";
    rateController.text = data.rate ?? "";
    quantityController.text = data.quantity ?? "";
    expenseAmountController.text = data.expenseAmount ?? "";
    othersVehicleController.text = data.otherVehicleCategories ?? "";

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
      if (data.startingImage != null && data.startingImage!.isNotEmpty) {
        startImagePathFromData.value =
            "${ApiUrl.baseUrl}expense/${data.startingImage!}";
        isUpdateStartImageAvailable.value = true;
      }
      if (data.endingImage != null && data.endingImage!.isNotEmpty) {
        endImagePathFromData.value =
            "${ApiUrl.baseUrl}expense/${data.endingImage!}";
        isUpdateEndImageAvailable.value = true;
      }
    }
    subCategoryDropDownTwo.value = true;

    vehicleVisibleRadio.value = false;
    buttonAndImageHoldVisible.value = false;
    buttonAndImageHoldVisible.value = false;
    rentOwnedOnClick.value = false;
    selectedRadioOwned.value = false;
    selectedRadioRented.value = false;
    machineDetailVisible.value = false;
    kmVisible.value = false;
    othersVisible.value = false;
    hoursVisibleDiesel.value = false;
    ownedOnClick1.value = false;
    if (typeControllerOne.text == 'Machines') {
      machineDetailVisible.value = true;
    } else if (typeControllerOne.text == 'Vehicles') {
      machineDetailVisible.value = true;
    }

    if (typeControllerTwo.text == 'Others') {
      buttonAndImageHoldVisible.value = true;
      kmVisible.value = false;
      hoursVisibleDiesel.value = true;
    } else if (typeControllerOne.text == 'Vehicles' &&
        typeControllerTwo.text == 'Others' &&
        userDataProvider.getFuelTypes == "Petrol") {
      machineDetailVisible.value = true;
      kmVisible.value = false;
      hoursVisibleDiesel.value = true;
      refreshDataHr();
    } else if (typeControllerTwo.text == 'Mud Pump' &&
        userDataProvider.getFuelTypes == "Petrol") {
      machineDetailVisible.value = true;
      othersVisible.value = false;
      subCategoryDropDownThree.value = false;
      buttonAndImageHoldVisible.value = true;
      kmVisible.value = false;
      hoursVisibleDiesel.value = true;
      refreshDataKm();
    } else if (typeControllerTwo.text == 'Suction Machine' &&
        userDataProvider.getFuelTypes == "Petrol") {
      othersVisible.value = false;
      machineDetailVisible.value = true;
      subCategoryDropDownThree.value = false;
      buttonAndImageHoldVisible.value = true;
      kmVisible.value = false;
      hoursVisible.value = true;
      refreshDataKm();
    } else if (typeControllerTwo.text == 'RIG' &&
        userDataProvider.getFuelTypes == "Diesel") {
      generatorVisible.value = false;
      subCategoryDropDownThree.value = true;
      buttonAndImageHoldVisible.value = true;
      hoursVisibleDiesel.value = true;
      kmVisible.value = false;
    } else if (typeControllerOne.text == 'Machines' &&
        typeControllerTwo.text == 'Generator set' &&
        userDataProvider.getFuelTypes == "Diesel") {
      generatorVisible.value = true;
      subCategoryDropDownThree.value = true;
      kmVisible.value = false;
      hoursVisibleDiesel.value = true;
      buttonAndImageHoldVisible.value = true;
    } else if (typeControllerTwo.text == 'Mud Pump' &&
        userDataProvider.getFuelTypes == "Diesel") {
      generatorVisible.value = false;
      subCategoryDropDownThree.value = true;
      kmVisible.value = false;
      hoursVisibleDiesel.value = true;
      buttonAndImageHoldVisible.value = true;
    } else if (typeControllerTwo.text == 'Earth Movers') {
      generatorVisible.value = false;
      subCategoryDropDownThree.value = true;
      hoursVisibleDiesel.value = true;
      buttonAndImageHoldVisible.value = true;
    } else if (typeControllerTwo.text == 'Hydra') {
      generatorVisible.value = false;
      subCategoryDropDownThree.value = true;
      hoursVisibleDiesel.value = true;
      buttonAndImageHoldVisible.value = true;
    } else if (typeControllerTwo.text == 'Jack Hammer') {
      generatorVisible.value = false;
      subCategoryDropDownThree.value = true;
      hoursVisibleDiesel.value = true;
      buttonAndImageHoldVisible.value = true;
    } else if (typeControllerTwo.text == 'Suction Machine') {
      machineDetailVisible.value = true;
      generatorVisible.value = false;
      hoursVisibleDiesel.value = true;
      buttonAndImageHoldVisible.value = true;
    } else if (typeControllerTwo.text == 'Three Wheeler') {
      machineDetailVisible.value = true;
      generatorVisible.value = false;
      hoursVisibleDiesel.value = false;
      buttonAndImageHoldVisible.value = true;
      buttonAndImageHoldVisibleOther.value = false;
      kmVisible.value = true;
      // ownedOnClick.value = true;
    } else if (typeControllerTwo.text == 'Car') {
      machineDetailVisible.value = true;
      generatorVisible.value = false;
      hoursVisibleDiesel.value = false;
      buttonAndImageHoldVisible.value = true;
      buttonAndImageHoldVisibleOther.value = false;
      kmVisible.value = true;
      // ownedOnClick.value = true;
    } else if (typeControllerTwo.text == 'Van') {
      machineDetailVisible.value = true;
      generatorVisible.value = false;
      hoursVisibleDiesel.value = false;
      buttonAndImageHoldVisible.value = true;
      buttonAndImageHoldVisibleOther.value = false;
      kmVisible.value = true;
      refreshDataHr();
    } else if (typeControllerTwo.text == '2 wheeler') {
      machineDetailVisible.value = true;
      generatorVisible.value = false;
      hoursVisibleDiesel.value = false;
      buttonAndImageHoldVisible.value = true;
      buttonAndImageHoldVisibleOther.value = false;
      kmVisible.value = true;
      refreshDataHr();
    } else if (typeControllerTwo.text == 'Machine Lorry' ||
        typeControllerTwo.text == 'Water Lorry' ||
        typeControllerTwo.text == 'ToolLorry' ||
        typeControllerTwo.text == 'Mini Trucks') {
      subCategoryDropDownThree.value = false;
      machineDetailVisible.value = true;
      generatorVisible.value = false;
      hoursVisibleDiesel.value = false;
      buttonAndImageHoldVisible.value = true;
      buttonAndImageHoldVisibleOther.value = false;
      kmVisible.value = true;
    } else if (typeControllerTwo.text == 'Machine Lorry' &&
        userDataProvider.getFuelTypes == "Diesel") {
      kmVisible.value = true;
      othersVisible.value = false;
    } else if (typeControllerTwo.text == 'Water Lorry' &&
        userDataProvider.getFuelTypes == "Diesel") {
      kmVisible.value = true;
      othersVisible.value = false;
    } else if (typeControllerTwo.text == 'Tool Lorry' &&
        userDataProvider.getFuelTypes == "Diesel") {
      subCategoryDropDownThree.value = false;
      machineDetailVisible.value = true;
      generatorVisible.value = false;
      hoursVisibleDiesel.value = false;
      buttonAndImageHoldVisible.value = true;
      buttonAndImageHoldVisibleOther.value = false;
      kmVisible.value = true;
    } else if (typeControllerTwo.text == 'Mini Trucks' &&
        userDataProvider.getFuelTypes == "Diesel") {
      kmVisible.value = true;
      buttonAndImageHoldVisible.value = true;
      othersVisible.value = false;
    } else if (typeControllerTwo.text == 'Car' &&
        userDataProvider.getFuelTypes == "Diesel") {
      kmVisible.value = true;
      othersVisible.value = false;
    } else if (typeControllerTwo.text == 'Van' &&
        userDataProvider.getFuelTypes == "Diesel") {
      kmVisible.value = true;
      othersVisible.value = false;
    } else if (typeControllerTwo.text == 'Car' &&
        userDataProvider.getFuelTypes == "Electricity") {
      kmVisible.value = true;
      othersVisible.value = false;
    } else if (typeControllerTwo.text == 'Van' &&
        userDataProvider.getFuelTypes == "Electricity") {
      kmVisible.value = true;
      othersVisible.value = false;
    } else if (typeControllerTwo.text == 'Two Wheeler' &&
        userDataProvider.getFuelTypes == "Electricity") {
      subCategoryDropDownThree.value = false;
      machineDetailVisible.value = true;
      generatorVisible.value = false;
      hoursVisibleDiesel.value = false;
      buttonAndImageHoldVisible.value = true;
      buttonAndImageHoldVisibleOther.value = false;
      kmVisible.value = true;
      othersVisible.value = false;
    } else if (typeControllerTwo.text == 'Others' &&
        userDataProvider.getFuelTypes == "Electricity") {
      subCategoryDropDownThree.value = false;
      machineDetailVisible.value = true;
      generatorVisible.value = false;
      hoursVisibleDiesel.value = false;
      buttonAndImageHoldVisible.value = true;
      buttonAndImageHoldVisibleOther.value = false;
      kmVisible.value = true;
      othersVisible.value = true;
    } else {
      subCategoryDropDownThree.value = true;
      machineDetailVisible.value = true;
      generatorVisible.value = true;
      hoursVisibleDiesel.value = true;
      buttonAndImageHoldVisible.value = true;
      kmVisible.value = true;
      othersVisible.value = true;
    }
    if (data.rentedOrOwned != null && !data.rentedOrOwned!.isEmpty) {
      buttonAndImageHoldVisible.value = true;
    } else {
      buttonAndImageHoldVisible.value = false;
    }

    if (data.rentedOrOwned!.isNotEmpty) {
      if (data.rentedOrOwned == 'Rented') {
        rentOwnedOnClick.value = true;
        selectedRadioRented.value = true;
      } else if (data.rentedOrOwned == 'Owned') {
        selectedRadioOwned.value = true;
        ownedOnClick1.value = true;
      }
    } else {
      buttonAndImageHoldVisible.value == false;
    }
    // if (typeControllerOne.text == 'Machines' &&
    //     userDataProvider.getFuelTypes == "Petrol") {
    //   machineDetailVisible.value = true;
    // }

    // if (typeControllerOne.text == "Machines") {
    //   fetchSubCategoryThree(
    //       fetchCategoryTwo[selectedSub2Index.value].sub2CategoryId, "");
    //   print("MachinesOnclick");
    // }
    // if (typeControllerOne.text == "Vehicles") {
    //   fetchSubCategoryThree(
    //       fetchCategoryTwo[selectedSub2Index.value].sub2CategoryId, "");
    //   print("VehiclesOnclick");
    // }

    // for (int j = 0; j < fetchCategoryTwo.length; j++) {
    //   if (fetchCategoryTwo[i].sub2CategoryId ==
    //       fetchCategoryThree[j].sub2CategoryId) {
    //     if (typeControllerOne.text == "Machines") {
    //       fetchSubCategoryThree(
    //           fetchCategoryTwo[selectedSub2Index.value].sub2CategoryId, "");
    //       print("MachinesOnclick ${fetchCategoryThree[j].sub2CategoryId}");
    //     }
    //   }
    // }
  }
}
