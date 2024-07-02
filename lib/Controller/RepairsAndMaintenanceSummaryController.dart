import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';

// import 'package:igreen_flutter/model/responseModel/FoodSummaryList.dart';
import 'package:provider/provider.dart';

import '../../../api_connect/api_connect.dart';
import '../../../provider/menuProvider.dart';
import '../../../routes/app_routes.dart';

import '../../model/responseModel/TravelSummaryList.dart';
import '../model/responseModel/GetBalanceResponse.dart';
import '../model/responseModel/RepairsAndMaintenanceSummaryList.dart';

class RepairsAndMaintenanceSummaryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<RepairsAndMaintenanceData> repairsAndMaintenanceData = RxList();
  RxString editButtonText = RxString('Edit');
  RxString reuseButtonText = RxString('Re-Use');
  bool isCall = false;
  RxInt selectedValues = RxInt(0);
  DataBalance? dataValues = DataBalance();
  RxInt totalBalanceValue = RxInt(0);

  @override
  void onInit() async {
    super.onInit();

    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getRepairs();
      getBalance();
    }
  }

  Future<void> refreshData() async {
    getRepairs();

    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getRepairs() async {
    Map<String, dynamic> payload = {
      'projectCode': userDataProvider.projectCode.toString(),
      'EmployeeId': AppPreference().getEmpId,
    };
    isLoading.value = true;
    print("Payload $payload");
    var response = await _connect.getRepairsAndMaintenanceExpenseCall(payload);
    isLoading.value = false;
    if (!response.error!) {
      repairsAndMaintenanceData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.repairsAndMaintenanceEntryScreen.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.repairsAndMaintenanceEntryScreen.toName);
    }
  }
  Future<void> getBalance() async {
    Map<String, String> payload = {
      'ProjectName': userDataProvider.projectCode.toString(),
      'EmployeeId': AppPreference().getEmpId.toString(),
    };
    print('getBalance:$payload');
    var response = await _connect.getBalanceCall(payload);
    if (!response.error!) {
      dataValues = response.data!;
      totalBalanceValue.value =
          int.tryParse(response.data?.availableBalance?.toString() ?? '0') ?? 0;
    }
    isLoading.value = false;
  }
  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': repairsAndMaintenanceData[selectedValues.value].id,
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId,
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': 'Repairs',
      'mainCategoryId': repairsAndMaintenanceData[selectedValues.value].id,

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
      getRepairs();

    } else {}
    ;
  }
}
