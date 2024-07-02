import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:igreen_flutter/model/responseModel/FoodSummaryList.dart';
import 'package:provider/provider.dart';

import '../../../api_connect/api_connect.dart';
import '../../../provider/menuProvider.dart';
import '../../../routes/app_routes.dart';
import '../../model/responseModel/FoodSummaryList.dart';
import '../../model/responseModel/FoodSummaryList.dart';
import '../../model/responseModel/FoodSummaryList.dart';
import '../../model/responseModel/GeneralSummaryList.dart';
import '../../model/responseModel/TravelSummaryList.dart';

class GeneralSummaryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<GeneralData> generalData = RxList();
  RxString reuseButtonText = RxString('Re-Use');
  RxString editButtonText = RxString('Edit');
  RxInt selectedValues = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    getGeneral();
  }

  Future<void> refreshData() async {
    getGeneral();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getGeneral() async {
    Map<String, dynamic> payload = {
      'projectCode': userDataProvider.projectCode.toString(),
      'EmployeeId': AppPreference().getEmpId,
    };

    isLoading.value = true;
    print("Payload $payload");
    var response = await _connect.getGeneralExpenseCall(payload);
    isLoading.value = false;
    if (!response.error!) {
      generalData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.generalEntryScreen.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.generalEntryScreen.toName);
    }
  }

  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': generalData[selectedValues.value].id,
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId,
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': 'General',
      'mainCategoryId': generalData[selectedValues.value].id,

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
      getGeneral();
    } else {}
    ;
  }
}
