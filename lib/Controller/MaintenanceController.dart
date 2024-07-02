import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../Utils/AppPreference.dart';
import '../api_connect/api_connect.dart';
import '../model/CheckListDaysResponseModel.dart';
import '../model/GetMaintenanceCheckListResponse.dart';
import '../model/MaintenanceCheckLIstResponseModel.dart';
import '../model/MaintenanceListResponseModel.dart';
import '../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../model/responseModel/MaintenanceSummaryListResponsemodel.dart';
import '../model/responseModel/getSubCategoryDropdownMaintenance.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class BoolList {
  RxBool main = RxBool(false);
  RxBool good = RxBool(false);
  RxBool bad = RxBool(false);
  RxBool newReplacement = RxBool(false);
}

class MaintenanceResponseList {
  String? checklistName;
  String? checklistStatus;

  MaintenanceResponseList({this.checklistName, this.checklistStatus});

  MaintenanceResponseList.fromJson(Map<String, dynamic> json) {
    checklistName = json['checklistName'];
    checklistStatus = json['checklistStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checklistName'] = this.checklistName;
    data['checklistStatus'] = this.checklistStatus;
    return data;
  }
}

class MaintenanceController extends GetxController {
  RxList<bool> onClickGood = RxList();
  RxList<CheckListData>? checkData = RxList();
  RxBool subCategoryDropDownOne = false.obs;
  TextEditingController typeControllerOne = TextEditingController();
  TextEditingController typeControllerTwo = TextEditingController();
  TextEditingController typeControllerThree = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController startDateAndTimeController = TextEditingController();
  TextEditingController closeDateAndTimeController = TextEditingController();
  TextEditingController checkerNameController = TextEditingController();
  TextEditingController staringKmController = TextEditingController();
  TextEditingController closingKmController = TextEditingController();
  late menuDataProvider userDataProvider;
  final ApiConnect _connect = Get.put(ApiConnect());
  RxList<SubcategoryTwoData> fetchCategoryTwo = RxList();
  RxList<GetSubCategoryDropdownData> getCategoryTwo = RxList();
  RxList<CheckListData> checkListDay = RxList();
  RxList<GetMaintenanceListData> getCheckList = RxList();
  RxBool hrVisible = RxBool(false);
  RxBool popUpValue = RxBool(false);
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  RxBool kmVisible = RxBool(false);

  // RxList<MaintenanceResponseList> maintenanceCheckData = RxList();
  RxBool isLoading = RxBool(false);
  RxBool selectAllCheckValue = RxBool(false);
  RxBool checkListDates = RxBool(false);
  RxBool rendList = false.obs;
  RxBool isOpened = false.obs;
  RxBool checklist = false.obs;
  List<String> rendDetails = [];
  List<MaintenanceResponseList> checkingData = [];
  List<MapEntry<String, dynamic>> entryList = [];
  List<String> checkList = [];
  RxList<BoolList> onClickList = RxList();
  String subcategoryName = '';

  RxBool sub2 = RxBool(false);
  RxBool sub3 = RxBool(false);

  RxInt typeID = RxInt(1);

  bool isCall = false;
  RxInt list = RxInt(0);
  RxInt selected = RxInt(0);
  late Map<String, dynamic> checkDataMap = {};

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
       checkListDays();
      if (userDataProvider.getCurrentStatus == "Edit") {
        setData();
      } else if (userDataProvider.getCurrentStatus == "Re-Use") {
        //setOnlyData();
        setData();
      }
    }

    rendDetails.add('Machines');
    rendDetails.add('Vehicles');
    checkList.add('daily');
    checkList.add('15days');
    checkList.add('30days');
    checkList.add('90days');
  }

  Future<void> fetchSubCategoryTwo() async {
    Map<String, dynamic> payload = {"maintenanceCategoryId": typeID.value};
    print('addPayload:$payload');
    var response = await _connect.getMaintenanceCall(payload);
    if (!response.error!) {
      getCategoryTwo.value = response.data!;

      update();
    } else
      () {};
  }

  Future<void> refreshData() async {
    checkListDays();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> checkListDays() async {
    Map<String, dynamic> payload = {
      "maintenanceCategoryId": typeID.value,
      'day': typeControllerThree.text
    };
    print('addPayload:$payload');
    var response = await _connect.getCheckListCall(payload);
    if (!response.error!) {
      onClickList.clear();

      for (int i = 0; i < response.data!.length; i++) {
        BoolList list = BoolList();
        list.newReplacement = RxBool(false);
        list.good = RxBool(false);
        list.bad = RxBool(false);
        list.main = RxBool(false);

        if (userDataProvider.getCurrentStatus == "Edit" ||
            userDataProvider.getCurrentStatus == "Re-Use") {
          MaintenanceSummaryData data =
              userDataProvider.getMaintenanceSummaryData!;

          for (int j = 0; j < data.maintenanceList!.length; j++) {
            if (data.maintenanceList![j].checklistName ==
                response.data![i].names) {
              if (data.maintenanceList![j].checklistStatus == "Replacement") {
                list.newReplacement = RxBool(true);
              }
              if (data.maintenanceList![j].checklistStatus == "Fair") {
                list.bad = RxBool(true);
              }
              if (data.maintenanceList![j].checklistStatus == "Good") {
                list.good = RxBool(true);
              }
            }
          }
        }

        onClickList.add(list);
        Map<String, dynamic> payload = {response.data![i].names ?? "": ""};
        checkDataMap.addAll(payload);
        print("onClickList${onClickList.length}");
      }
      checkListDay.value = response.data!;
    }
  }

  bool firstValidation() {
    if (typeControllerOne.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Category !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    } if (typeControllerTwo.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Comments !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (typeControllerThree.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Amount !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (remarksController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Current date !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (checkerNameController.value.text.isEmpty) {
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



  Future<void> insertMaintenanceExpenseCall() async {
    Map<String, dynamic> payload = {
      'remark': remarksController.text,
      'checkerName': checkerNameController.text,
      'category': typeControllerOne.text,
      'subCategory': typeControllerTwo.text,
      'days': typeControllerThree.text,
      'MaintenanceList': json.encode(checkingData),
    };

    print(json.encode(checkingData));
    print("rentInsertPayload:$payload");
    var response = await _connect.insertMaintenanceExpenseCall(payload);
    debugPrint("rentInsertResponse: ${response.toJson()}");

    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.maintenanceSummary.toName);
      Get.deleteAll();
      checkListDays();
    } else
       {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      };
  }

  Future<void> updateMaintenanceCall(String status) async {
    Map<String, dynamic> payload = {
      'checklistStatus': status,
      'Id': userDataProvider
          .getMaintenanceSummaryData!.maintenanceList![selected.value].id
    };

    // print(json.encode(checkingData));
    print("rentInsertPayload:$payload");
    var response = await _connect.updateMaintenanceExpenseCall(payload);
    debugPrint("rentInsertResponse: ${response.toJson()}");
    //checkDataMap.addAll(payload);
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      // Get.offNamed(AppRoutes.maintenanceSummary.toName);
      //Get.deleteAll();
    } else
      () {};
  }

  Future<void> updateMaintenance() async {
    Map<String, dynamic> payload = {
      'category': typeControllerOne.text,
      'subCategory': typeControllerTwo.text,
      'remark': remarksController.text,
      'checkerName': checkerNameController.text,
      'Id': userDataProvider.getMaintenanceSummaryData!.id.toString()
    };

    print(json.encode(checkingData));
    print("rentInsertPayload:$payload");
    var response = await _connect.updateMaintenanceExpense(payload);
    debugPrint("rentInsertResponse: ${response.toJson()}");
    //checkDataMap.addAll(payload);
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.maintenanceSummary.toName);
      Get.deleteAll();
    } else
      () {};
  }

  void setData() {
    MaintenanceSummaryData data = userDataProvider.getMaintenanceSummaryData!;
    typeControllerOne.text = data.category ?? "";
    typeControllerTwo.text = data.subCategory ?? "";
    typeControllerThree.text = data.daysCount ?? "";
    checkerNameController.text = data.checkerName ?? "";
    remarksController.text = data.remark ?? "";
    if (typeControllerOne.text == "Vehicles") {
      typeID.value = 2;
      print("vehiclesID$typeID");
    } else {
      typeID.value = 1;
      print("machinesID$typeID");
    }

    checkListDays();
    checkListDates.value = true;
  }


}
