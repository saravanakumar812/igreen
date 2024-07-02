import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/model/responseModel/GetCityData.dart';
import 'package:provider/provider.dart';
import '../../../Utils/AppPreference.dart';
import '../../../Utils/image_picker.dart';
import '../../../api_connect/api_connect.dart';
import '../../../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../../../model/responseModel/FuelSubCategoryResponse.dart';
import '../../../provider/menuProvider.dart';
import '../api_config/ApiUrl.dart';
import '../model/responseModel/SuggestionCommentsModel.dart';
import '../model/responseModel/TransportCustomerNameResponseModel.dart';
import '../model/responseModel/TransportSummaryList.dart';
import '../routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class TransportExpenseController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxInt selectedSub1Index = RxInt(0);
  RxInt selectedSub2Index = RxInt(0);
  RxBool isLoading = RxBool(false);
  RxBool isSub1 = RxBool(false);
  RxBool allVisible = RxBool(false);
  RxBool uploadLoading = RxBool(false);
  RxBool othersVisible = RxBool(false);
  RxBool isSub2 = RxBool(false);
  RxBool isSub2Available = RxBool(false);
  RxBool entries = RxBool(false);
  RxBool fromLocationVisibleDropdown = RxBool(false);
  RxBool toLocationVisibleDropdown = RxBool(false);
  RxBool commonVisible = RxBool(false);
  RxString currentDate = RxString("Spend Date");
  RxInt pageIndex = RxInt(1);
  RxBool popUpValue = RxBool(false);
  RxBool vendorOnClick = RxBool(false);
  String vendorName = "";
  late menuDataProvider userDataProvider;
  TextEditingController currentDateController = TextEditingController();
  TextEditingController othersTransportController = TextEditingController();
  TextEditingController subCategory1Controller = TextEditingController();
  TextEditingController subCategory2Controller = TextEditingController();
  TextEditingController fromLocationController = TextEditingController();
  TextEditingController noOfPeopleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController ticketController = TextEditingController();
  TextEditingController driveTipsController = TextEditingController();
  TextEditingController toLocationController = TextEditingController();
  TextEditingController tripCostController = TextEditingController();
  TextEditingController goodsNameController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerNameAddController = TextEditingController();
  TextEditingController customerContactController = TextEditingController();
  TextEditingController customerAddressAddController = TextEditingController();

  TextEditingController remarksController = TextEditingController();
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  Rx<PickedImage> eWayBillImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  Rx<PickedImage> invoiceBillImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  Rx<PickedImage> packingListUploadImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));

  RxBool pickImageSelected = false.obs;
  RxBool invoiceImageSelected = false.obs;
  RxBool eWayImageSelected = false.obs;
  RxBool packingListUpload = false.obs;
  RxBool isUpdateImageDcAvailable = false.obs;
  RxBool isUpdateEWayImageAvailable = false.obs;
  RxBool isUpdateInVoiceImageAvailable = false.obs;
  RxBool isUpdatePackingImageAvailable = false.obs;
  RxString dcImagePathFromData  = RxString("");
  RxString eWayImagePathFromData  = RxString("");
  RxString inVoiceImagePathFromData  = RxString("");
  RxString packingImagePathFromData  = RxString("");


  RxList<FuelSubOneData> subCategory1 = RxList();
  RxList<FuelSubOneData> subCategory1FixedList = RxList();
  RxList<SubcategoryTwoData> fetchCategoryTwo = RxList();
  bool isCall = false;
  RxList<FuelSubOneData> getData = RxList();
  RxList<CityData> cityValues = RxList();
  bool isComplete = false;
  int i = 0;
  RxString? recordFilePath = RxString("");
  String subcategoryName = "";
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  RxBool packingUpload = RxBool(false);
  final FocusNode tripCostFocusNode = FocusNode();
  RxList<TransportCustomerNameData> customerData = RxList();

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
      getCityTransport("");
      subCategory1Call('');
      getVendor('');
      if (userDataProvider.getCurrentStatus == "Edit" ||
          userDataProvider.getCurrentStatus == "Re-Use") {
        setData();
      }
      suggestion();

    }
  }
  Future<void> suggestion() async {
    Map<String, dynamic> payload = {
      'Category': "Transport",
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
    }  else if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      audioPlayer.setUrl("${ApiUrl.baseUrl}expense/${userDataProvider
          .getTransportData!.audioFile}");
      audioPlayer.play();
    }else
    {
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
      'Sub1CategoryName':subcategory1Name,
    };

    print("1234566$payload");
    isLoading.value = true;
    var response = await _connect.fuelSubCategory(payload);
    isLoading.value = false;
    if (!response.error!) {
      subCategory1.value = response.data!;
      subCategory1FixedList.value = response.data!;
      print("EmptyList value ${subCategory1FixedList.length}");
      print("static Value ${subCategory1.length}");

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

  bool secondValidation() {
    if (customerNameAddController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Customer Name!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (customerContactController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Customer Contact!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }if (customerContactController.text.length < 10 ) {
      Fluttertoast.showToast(
        msg: "Please Enter 10 Numbers  in Customer Contact!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (customerAddressAddController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Customer Address!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }



    return true;
  }
  Future<void> refreshData() async {
    getVendor('');
    return Future.delayed(Duration(seconds: 0));
  }
  Future<void> addCustomer() async {
    if (secondValidation()) {
      Map<String, dynamic> payload = {
        'customerName': customerNameAddController.text,
        'customerContact': customerContactController.text,
        'customerAddress': customerAddressAddController.text,

      };
      customerNameAddController.clear();
      customerContactController.clear();
      customerAddressAddController.clear();

      print('addVendorPayload:$payload');
      var response = await _connect.addCustomerCall(payload);
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
  getVendor(String customerName) async {
    Map<String, dynamic> payload = {
      'customerName': customerName,

    };
    isLoading.value = true;
    var response = await _connect.getCustomerCall(payload);
    isLoading.value = false;
    if (response.data != null) {
      customerData.value = response.data!;
      debugPrint("getVendorResponse: ${response.toJson()}");
    } else {}
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


    if (fromLocationController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter From Location!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (toLocationController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter End Location",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if(fromLocationController.text  ==  toLocationController.text){

      fromLocationController.text = "";
      toLocationController.text = "";
      Fluttertoast.showToast(
        msg: 'starting location and ending location is same.',
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
    if (tripCostController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Trip Cost!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (goodsNameController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Goods Name !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (customerNameController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Customer Name !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> insertTransport() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'projectCode': userDataProvider.projectCode.toString(),
        'category1': "Transport",
        'category2': subCategory1Controller.text,
        'category3': '',
        'category4': '',
        'category5': '',
        'from': fromLocationController.text,
        'to': toLocationController.text,
        'tripCost': tripCostController.text,
        'comments': commentController.text,
        'expenseAmount': tripCostController.text,
        'expenseDate': currentDateController.text,
        'addedFrom': 'Android',
        'expenseStatus': '0',
        'Types': '',
        'SGST': '',
        'CGST': '',
        'IGST': '',
        'LedgerName': '',
        'LedgerGroups': '',        'OverallExpenseStatus': '4',

        'LedgerCategory1': '',
        'LedgerCategory2': '',
        'LedgerCategory3': '',
        'LedgerCategory4': '',
        'LedgerCategory5': '',
        'GoodsName':goodsNameController.text,
        'CustomerName': customerNameController.text,
        "Others":othersTransportController.text,
      };
      print("insertTransportRequest:$payload");





      if(packingListUploadImagePick.value != null)
        {
          uploadLoading.value = true;

          var response = await _connect.imgTransportUpload(
          ApiUrl.insertTransport,itemImagePick.value.file,
          eWayBillImagePick.value.file,
          invoiceBillImagePick.value.file,
          packingListUploadImagePick.value.file ,
          payload, recordFilePath!.value ?? "");
          uploadLoading.value = false;

          if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.transportSummaryScreen.toName);
        Get.deleteAll();
      } else {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.red,
        );
        debugPrint("insertTransportResponse: ${response.toJson()}");
      }

        } else {
        // Three images
        uploadLoading.value = true;

        var response = await _connect.imgTransportThreeUpload(
            ApiUrl.insertTransport,
            itemImagePick.value.file,
            eWayBillImagePick.value.file,
            invoiceBillImagePick.value.file,
            payload,
            recordFilePath!.value ?? "");
        uploadLoading.value = false;
        if (!response.error!) {
          Fluttertoast.showToast(
            msg: response.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          Get.offNamed(AppRoutes.transportSummaryScreen.toName);
          Get.deleteAll();

        }
      }}}




  Future<void> updateTransport() async {
    if (firstValidation()){
    Map<String, String> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
      'ProjectCode': userDataProvider.projectCode.toString(),
      'Category1': "Transport",
      'Category2': subCategory1Controller.text,
      'Category3': '',
      'Category4': '',
      'Category5': '',
      'From': fromLocationController.text,
      'To': toLocationController.text,
      'TripCost': tripCostController.text,
      'Comments': commentController.text,
      'ExpenseDate': currentDateController.text,
      'TransportExpenseId': userDataProvider.getTransportData!.id.toString(),
      'NewExpenseAmount': '',
      'OldExpenseAmount': '',
      'GoodsName':goodsNameController.text,
      'CustomerName': customerNameController.text,
      "Others":othersTransportController.text,

    };
    print("updateTransportRequest:$payload");
    if(packingListUploadImagePick.value != null)
    {
      var response = await _connect.imgTransportUpdate(
          ApiUrl.updateTransport,itemImagePick.value!.file,
          eWayBillImagePick.value.file,
          invoiceBillImagePick.value.file,
          packingListUploadImagePick.value.file ,
          payload, recordFilePath!.value ?? "");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.transportSummaryScreen.toName);
        // Get.deleteAll();
      } else {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.red,
        );
        debugPrint("insertTransportResponse: ${response.toJson()}");
      }

    } else {
      // Three images
      var response = await _connect.imgTransportThreeUpdate(
          ApiUrl.updateTransport,
          itemImagePick.value.file,
          eWayBillImagePick.value.file,
          invoiceBillImagePick.value.file,
          payload,
          recordFilePath!.value ?? "");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.transportSummaryScreen.toName);
      }
    }}





  }

  Future<void> getCityTransport(String cityName) async {
    Map<String, dynamic> payload = {
      'CityName': cityName,
      'page': pageIndex.value,
      'perPage': '10',
    };
    print('city132132amepayload:$payload');
    var response = await _connect.getCityCall(payload);
    debugPrint("getCityTransport: ${response.toJson()}");
    if (!response.error!) {
      cityValues.value = response.data!;
    } else {}
  }

  void setData() {
    TransportData data = userDataProvider.getTransportData!;
    subCategory1Controller.text = data.category2 ?? "";
    fromLocationController.text = data.fromDate ?? "";
    toLocationController.text = data.toDate ?? "";
    commentController.text = data.comment ?? "";
    currentDateController.text = data.expenseDate ?? "";
    tripCostController.text = data.tripCost.toString() ?? "";
    goodsNameController.text = data.goodsName ?? "";
    customerNameController.text = data.customerName ?? "";
    allVisible.value = true;
    commonVisible.value = true;



    if(userDataProvider.currentStatus == "Edit"){
      if(data.audioFile != null && !data.audioFile!.isEmpty) {
        isAudio.value = true;
      } else {
        isAudio.value = false;
      }
    if(data.dcUpload != null && data.dcUpload!.isNotEmpty){
      dcImagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.dcUpload!}";
      isUpdateImageDcAvailable.value = true;
    }
    if(data.eWayBill != null && data.eWayBill!.isNotEmpty){
      eWayImagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.eWayBill!}";
      isUpdateEWayImageAvailable.value = true;
    }
    if(data.invoiceBill != null && data.invoiceBill!.isNotEmpty){
      inVoiceImagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.invoiceBill!}";
      isUpdateInVoiceImageAvailable.value = true;
    }
    }
    if (subCategory1Controller.text == 'Others') {
      othersVisible.value = true;
    } else {
      othersVisible.value = false;
    }
    if(subCategory1Controller
        .text ==
        'Sea-way' || subCategory1Controller
        .text ==
        'Air-way'){
      packingUpload.value = true;
      if(userDataProvider.currentStatus =="Edit"){
      if(data.images != null && data.images!.isNotEmpty){
        packingImagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.images!}";
        isUpdatePackingImageAvailable.value = true;
      }}
    }
  }
}
