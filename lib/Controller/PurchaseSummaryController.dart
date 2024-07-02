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
import '../model/responseModel/GetPurchaseResponse.dart';
import '../model/responseModel/PurchaseSummaryList.dart';

class PurchaseSummaryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<GetPurchaseData> purchaseData = RxList();
  RxString reuseButtonText = RxString('Re-Use');
  RxString editButtonText = RxString('Edit');
  RxInt selectedValues = RxInt(0);

  bool isCall = false;
  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getFood();
      ();
    }
  }
  Future<void> refreshData() async {
    getFood();
    return Future.delayed(Duration(seconds: 0));
  }
  Future<void> getFood() async {
    Map<String, dynamic> payload = {
      'projectCode': userDataProvider.projectCode.toString(),
      'EmployeeId': AppPreference().getEmpId,
    };

    isLoading.value = true;
    print("Payload $payload");
    var response = await _connect.getPurchaseExpenseCall(payload);
    isLoading.value = false;
    if (!response.error!) {
      purchaseData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.purchaseEntryScreen.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.purchaseEntryScreen.toName);
    }
  }

  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': purchaseData[selectedValues.value].id,
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId,
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': 'Purchases',
      'mainCategoryId': purchaseData[selectedValues.value].id,

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
      getFood();
    } else {}
    ;
  }
}
