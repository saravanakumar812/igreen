import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';

import '../../../Utils/AppPreference.dart';
import '../../../Utils/image_picker.dart';
import '../../../api_connect/api_connect.dart';
import '../../../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../../../model/responseModel/FuelSubCategoryResponse.dart';
import '../../../provider/menuProvider.dart';
import '../api_config/ApiUrl.dart';
import '../model/responseModel/GetPurchaseResponse.dart';
import '../model/responseModel/PurchaseMaterialNameRespnseModel.dart';
import '../model/responseModel/PurchaseUnitResponse.dart';
import '../routes/app_routes.dart';

class RepairPurchaseEntryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxInt selectedSub1Index = RxInt(0);
  RxInt selectedSub2Index = RxInt(0);
  RxBool isLoading = RxBool(false);
  RxBool isSub1 = RxBool(false);
  RxBool isSub2 = RxBool(false);
  RxBool isSub2Available = RxBool(false);
  RxBool entries = RxBool(false);
  RxString currentDate = RxString("Spend Date");
  late menuDataProvider userDataProvider;
  RxBool popUpValue = RxBool(false);
  final FocusNode amountFocusNode = FocusNode();
  final FocusNode currentlyPaidAmountFocusNode = FocusNode();
  final FocusNode unitFocusNode = FocusNode();
  String subcategoryName = "";
  RxList<PurchaseMaterialNameData> materialName = RxList();
  RxList<PurchaseUnitData> unit = RxList();
  TextEditingController currentDateController = TextEditingController();
  TextEditingController unitAddController = TextEditingController();
  TextEditingController balanceAmountController = TextEditingController();
  TextEditingController currentlyPaidAmountController = TextEditingController();
  TextEditingController subCategory1Controller = TextEditingController();
  TextEditingController subCategory2Controller = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController materialNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController driveTipsController = TextEditingController();
  TextEditingController materialNameAddController = TextEditingController();
  TextEditingController toController = TextEditingController();
  // Rx<PickedImage?> itemImagePick = Rx<PickedImage?>(null);
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  RxString imagePathFromData  = RxString("");
  RxBool isUpdateImageAvailable = false.obs;
  RxBool pickImageSelected = false.obs;
  RxList<FuelSubOneData> subCategory1 = RxList();
  RxList<SubcategoryTwoData> fetchCategoryTwo = RxList();
  RxBool vendorOnClick = RxBool(false);
  RxBool commonVisible = RxBool(false);
  RxBool unitOnClick = RxBool(false);
  RxInt materialId = RxInt(0);
  RxString? recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  bool isCall = false;
  bool isComplete = false;
  RxBool isOpened = false.obs;
  int i = 0;
  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      setData();
    }
    subCategory1Call("");
    getVendor("");
    currentDateController.text = userDataProvider.getDate!;
  }

  subCategory1Call(String purchase) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryName': purchase,
    };

    print("1234566$payload");
    isLoading.value = true;
    var response = await _connect.fuelSubCategory(payload);
    isLoading.value = false;
    if (!response.error!) {
      subCategory1.value = response.data!;
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
          .getPurchaseData!.audioFile}");
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


  getVendor(String customerName) async {
    Map<String, dynamic> payload = {
      'materialName': customerName,
    };
    isLoading.value = true;
    //log(response.toJson());

    var response = await _connect.getMaterialNameCall(payload);
    isLoading.value = false;
    if (response.data != null) {
      materialName.value = response.data!;
      debugPrint("getVendorResponse: ${response.toJson()}");
      log(response.toJson().toString());
    } else {}
  }

  getUnit(int? unitId ) async {
    Map<String, dynamic> payload = {
      'purchaseMaterialNameId':unitId ,
      'unit': unitAddController.text
    };
    print(payload);
    print(unitId);
    isLoading.value = true;
    unit.clear();
    var response = await _connect.getUnitCall(payload);
    isLoading.value = false;
    if (response.data != null) {
      unit.value = response.data!;
      debugPrint("getVendorResponse: ${response.toJson()}");
    } else {}
  }

  bool firstValidation() {
    if (amountController.value.text.isEmpty) {
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
    if (double.parse(currentlyPaidAmountController.text) >
        double.parse(amountController.text)) {
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

  bool secondValidation() {
    if (materialNameAddController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Material Name!",
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
    if (unitAddController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter unit!",
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
  Future<void> addMaterial() async {
    if (secondValidation()) {
      Map<String, dynamic> payload = {
        'materialName': materialNameAddController.text,
      };
      materialNameAddController.clear();


      print('addVendorPayload:$payload');
      var response = await _connect.addMaterialNameCall(payload);
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

  Future<void> addUnit() async {
    if (thirdValidation()) {
      Map<String, dynamic> payload = {
        'purchaseMaterialNameId': materialName[materialId.value].id,
        'unit': unitAddController.text,
      };
      unitAddController.clear();


      print('addUnitPayload:$payload');
      var response = await _connect.addUnitCall(payload);
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



  Future<void> insertPurchaseApi() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'projectCode': userDataProvider.projectCode.toString(),
        'category1': "Purchases",
        'category2': subCategory1Controller.text,
        'category3': subCategory2Controller.text,
        'category4': "",
        'category5': "",
        'amount': amountController.text,
        'comments': commentController.text,
        'materialName': materialNameController.text,
        'Unit': unitController.text,
        'Owner': ownerNameController.text,
        'addedFrom': "android",
        'expenseAmount': amountController.text,
        'expenseDate': currentDateController.text,
        'Types': "",
        'SGST': "",
        'CGST': "",
        'otherPurchaseExpense': "",
        'currentlyPaidAmount': currentlyPaidAmountController.text,
        'balanceAmount': balanceAmountController.text,
      };

      print("insertPurchaseResponse:$payload");
      var response = await _connect.imgTaskUpload(ApiUrl.insertPurchase, itemImagePick.value.file , payload, recordFilePath!.value ?? "");
      debugPrint("insertPurchaseResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

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

  Future<void> updatePurchase() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'ProjectCode': userDataProvider.projectCode.toString(),
        'Category1': "Purchases",
        'Category2': subCategory1Controller.text,
        'Category3': subCategory2Controller.text,
        'Category4': '',
        'Category5': '',
        'Category6': '',
        'MaterialName': materialNameController.text,
        'Unit': unitController.text,
        'Owner': ownerNameController.text,
        'PurchaseExpenseId': userDataProvider.getPurchaseData!.id.toString(),
        'Amount': amountController.text,
        'ExpenseDate': currentDateController.text,
        'OldExpenseAmount': amountController.text,
        'NewExpenseAmount': '',
        'Comments': commentController.text,
        'currentlyPaidAmount': currentlyPaidAmountController.text,
        'balanceAmount': balanceAmountController.text,
      };
      print('PurchaseUpdateRequest$payload');
      var response = await _connect.imgTaskUpdate(ApiUrl.updatePurchase,itemImagePick.value.file , payload, recordFilePath!.value ?? "");
      debugPrint("PurchaseUpdateRequest: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.repairsAndMaintenanceEntryScreen.toName);
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

  void setData() {
    GetPurchaseData data = userDataProvider.getPurchaseData!;
    subCategory1Controller.text = data.category2 ?? "";
    subCategory2Controller.text = data.category3 ?? "";
    materialNameController.text = data.materialName ?? '';
    unitController.text = data.unit ?? "";
    commentController.text = data.comments ?? "";
    amountController.text = data.amount ?? "";
    ownerNameController.text = data.owner ?? "";
    currentlyPaidAmountController.text = data.currentlyPaidAmount ?? " ";
    balanceAmountController.text = data.balanceAmount ?? "";
    isSub2Available.value = true;
    commonVisible.value = true;

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
