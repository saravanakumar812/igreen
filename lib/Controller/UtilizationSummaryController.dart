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
import '../model/responseModel/UtilizationSummaryList.dart';
import '../model/responseModel/WagesSummarylist.dart';

class UtilizationSummaryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);

  late menuDataProvider userDataProvider;
  RxList<UtilizationData> utilizationData = RxList();
  RxString editButtonText = RxString('Edit');
  RxString reuseButtonText = RxString('Re-Use');

  RxInt selectedValues = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    getUtilization();
  }

  Future<void> refreshData() async {
    getUtilization();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getUtilization() async {
    isLoading.value = true;

    Map<String, dynamic> payload = {
      'projectCode': userDataProvider.projectCode.toString(),
      'EmployeeId': AppPreference().getEmpId,
    };

    print("Payload $payload");
    var response = await _connect.getUtilizationExpenseCall(payload);
    isLoading.value = false;
    if (!response.error!) {
      utilizationData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.utilizationEntryScreen.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.utilizationEntryScreen.toName);
    }
  }

  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': utilizationData[selectedValues.value].id,
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId.toString(),
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': 'Utilization',
      'mainCategoryId': utilizationData[selectedValues.value].id,

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
      getUtilization();
    } else {}
    ;
  }
}
