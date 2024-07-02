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
import '../model/responseModel/FoodSummaryList.dart';
import '../model/responseModel/GetBalanceResponse.dart';

class FoodSummaryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<FoodData> foodData = RxList();
  RxString editButtonText = RxString('Edit');
  RxString reuseButtonText = RxString('Re-Use');
  RxBool isCall = RxBool(false);
  RxInt selectedValues = RxInt(0);
  DataBalance? dataValues = DataBalance();

  RxInt totalBalanceValue = RxInt(0);
  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall.value) {
      isCall.value = true;
      getFood();
      getBalance();
    }
  }

  Future<bool> onBackPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Exit'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                // User tapped the cancel button, pop the dialog and return false
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Exit'),
              onPressed: () {
                // User tapped the exit button, pop the dialog and return true
                Navigator.of(context).pop(true);
                Get.offNamed(AppRoutes.expenseScreen.toName);
              },
            ),
          ],
        );
      },
    );
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
    print("Payloadfood $payload");
    var response = await _connect.getFoodExpenseCall(payload);
    isLoading.value = false;
    if (!response.error!) {
      foodData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.foodEntryScreen.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.foodEntryScreen.toName);
    }
  }

  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': foodData[selectedValues.value].id,
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId,
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': 'Food',
      'mainCategoryId': foodData[selectedValues.value].id,

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
