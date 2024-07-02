import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/GetFuelExpenseResponse.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class FuelSummaryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxList<FuelExpenseData> getData = RxList();
  RxBool isLoading = RxBool(false);
  RxString editButtonText = RxString('Edit');
  RxString reuseButtonText = RxString('Re-Use');
  bool isCall = false;
  RxInt selectedValues = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getFuelExpense();
    }
  }

  Future<void> refreshData() async {
    getFuelExpense();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getFuelExpense() async {
    Map<String, dynamic> payload = {
      'projectCode': userDataProvider.projectCode.toString(),
      'EmployeeId': AppPreference().getEmpId,
      'Category': userDataProvider.subCategoryName.toString(),
    };
    isLoading.value = true;
    print("78945666$payload");
    var response = await _connect.getFuelExpenseCall(payload);
    isLoading.value = false;
    debugPrint("1234566: ${response.toJson()}");
    if (!response.error!) {
      getData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.addFuelExpense.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.addFuelExpense.toName);
    }
  }

  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': getData[selectedValues.value].fuelExpenseId,
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId.toString(),
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': 'Fuel',
      'mainCategoryId': getData[selectedValues.value].fuelExpenseId,

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
      getFuelExpense();
    } else {}
    ;
  }

}
