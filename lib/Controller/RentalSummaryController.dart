import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../Utils/AppPreference.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/GetRentExpenseResponse.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class RentalSummaryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxList<GetRentData> getData = RxList();

  RxBool isLoading = RxBool(false);
  RxInt selectedValues = RxInt(0);
  RxString editButtonText = RxString('Edit');
  RxString reuseButtonText = RxString('Re-Use');
  bool isCall = false;

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getRendExpense();
      ();
    }
  }

  Future<void> refreshData() async {
    getRendExpense();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getRendExpense() async {
    Map<String, dynamic> payload = {
      'projectCode': userDataProvider.projectCode.toString(),
      'EmployeeId': AppPreference().getEmpId.toString(),
    };
    isLoading.value = true;
    print("getRendExpense:$payload");
    var response = await _connect.getRendExpenseCall(payload);
    isLoading.value = false;
    debugPrint("getRendExpenseResponse: ${response.toJson()}");
    if (!response.error!) {
      getData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.rentedScreen.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.rentedScreen.toName);
    }
  }

  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': getData[selectedValues.value].id,
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId.toString(),
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': 'Rental',
      'mainCategoryId': getData[selectedValues.value].id,

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
      getRendExpense();
    } else {}
    ;
  }
}
