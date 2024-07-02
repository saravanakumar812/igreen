import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:igreen_flutter/forms/theme.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/FetchExpenseCategoryResponse.dart';
import '../model/responseModel/GetBalanceResponse.dart';
import '../provider/menuProvider.dart';

class ExpenseScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxList<Data> fetchData = RxList();
  RxBool isLoading = RxBool(false);
  RxInt colorIndex = RxInt(0);
  bool isCall = false;
  DataBalance? dataValues = DataBalance();
  // RxString totalBalanceValue = RxString('0');
  RxInt totalBalanceValue = RxInt(0);
  RxInt CurrentProjecttotalBalanceValue = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getExpense();
      //
    }
  }

  getExpense() async {
    isLoading.value = true;
    var response = await _connect.getFetchExpenseCategory();
    if (response.data != null) {
      fetchData.value = response.data!;
      getBalance();
      debugPrint("getFetchResponse: ${response.toJson()}");
      log("getFetchResponse: ${response.toJson()}");
    } else {}
  }
  Future<void> refreshData() async {
    getBalance();
    return Future.delayed(Duration(seconds: 0));
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
          int.tryParse(response.data?.EmployeeBalance?.toString() ?? '0') ?? 0;
      CurrentProjecttotalBalanceValue.value =
          int.tryParse(response.data?.availableBalance?.toString() ?? '0') ?? 0;
    }
    isLoading.value = false;
  }

  List<Color> myColors = [
    AppTheme.liteBlue,
    AppTheme.lite,
    AppTheme.liteBlue97,
    AppTheme.litePink,
    AppTheme.mateGreen,
    AppTheme.maroon,
    AppTheme.successShade4,
    AppTheme.redShade1,
    AppTheme.purple1,
    AppTheme.corrosion,
    AppTheme.liteBlue2,
    AppTheme.liteYellow,
  ];
}
