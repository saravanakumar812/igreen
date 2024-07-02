import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:provider/provider.dart';

import '../../../api_connect/api_connect.dart';
import '../../../provider/menuProvider.dart';
import '../../../routes/app_routes.dart';

import '../../model/responseModel/TravelSummaryList.dart';
import '../model/GetOnDutyEmployeeIdResponse.dart';
import '../model/OnDutyResponseModel.dart';
import '../model/responseModel/FoodSummaryList.dart';

class OnDutySummaryScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<OnDutyResponseData> onDutyData = RxList();
  RxList<GetOnDutyEmployeeIdResponseData> onDutyEmployeeData = RxList();
  RxString editButtonText = RxString('Edit');
  RxString reuseButtonText = RxString('Re-Use');
  bool isCall = false;
  RxInt selectedValues = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getOnDutyList();
      getOnDutyEmployeeList();
    }
  }

  Future<void> refreshData() async {
    getOnDutyList();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getOnDutyList() async {
    isLoading.value = true;
    var response = await _connect.getOnDuty();
    isLoading.value = false;
    if (!response.error!) {
      onDutyData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.onDutyEntry.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.onDutyEntry.toName);
    }
  }

  Future<void> getOnDutyEmployeeList() async {
    Map<String, dynamic> payload = {
      'employeeId': AppPreference().getEmpId
    };
    isLoading.value = true;
    var response = await _connect.onDutyApproval(payload);
    isLoading.value = false;
    if (!response.error!) {
      onDutyEmployeeData.value = response.data!;
      update();
      if (response.data!.isEmpty) {

      } else {}
    } else {

    }
  }

  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': '',
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId,
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': 'Food',
      'mainCategoryId': onDutyData[selectedValues.value].id,
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
    };
    print("statusUpdate:$payload");
    var response = await _connect.statusUpdateCall(payload);
    debugPrint("statusUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      getOnDutyList();
    } else {}
    ;
  }




}
