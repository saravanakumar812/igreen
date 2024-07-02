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
import '../model/GetOfficeEmployeeResponseModel.dart';
import '../model/responseModel/GetRentExpenseResponse.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class OfficeSummaryScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxList<GetRentData> getData = RxList();
  RxList<OfficeEmployeeResponseData> getOfficeEmployeeData = RxList();
  TextEditingController currentDateController = TextEditingController();
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
      getOfficeExpense();
    }

  }

  Future<void> refreshData() async {
    getOfficeExpense();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getOfficeExpense() async {
    Map<String, dynamic> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
    };
    isLoading.value = true;
    print("getRendExpense:$payload");
    var response = await _connect.getOfficeExpenseCall(payload);
    isLoading.value = false;
    debugPrint("getRendExpenseResponse: ${response.toJson()}");
    if (!response.error!) {
      getOfficeEmployeeData.value = response.data!;
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
      'Id': getOfficeEmployeeData[selectedValues.value].id,

    };
    print("statusUpdate:$payload");
    var response = await _connect.deleteOfficeCall(payload);
    debugPrint("statusUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      getOfficeExpense();
    } else {}
    ;
  }
}
