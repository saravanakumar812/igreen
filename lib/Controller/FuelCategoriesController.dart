import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../forms/theme.dart';
import '../model/responseModel/FuelSubCategoryResponse.dart';
import '../provider/menuProvider.dart';
import 'package:http/http.dart' as http;

class FuelCategoriesController extends GetxController {
  RxList<FuelSubOneData> fuelSubCategoryData = RxList();
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxBool isLoading = RxBool(false);
  RxInt colorIndex = RxInt(0);
  bool isCall = false;

  @override
  void onInit() async {
    super.onInit();
  }

  subCategoryFuel(String subcategory1Name) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': userDataProvider.expenseId.toString(),
      'Sub1CategoryName':subcategory1Name,
    };
    print("1234566$payload");

    isLoading.value = true;
    var response = await _connect.fuelSubCategory(payload);
    isLoading.value = false;
    debugPrint("subCateory: ${response.toJson()}");
    if (!response.error!) {
      fuelSubCategoryData.value = response.data!;
    } else
      () {};
  }

  List<Color> myColors = [
    AppTheme.liteBlue,
    AppTheme.lite,
    AppTheme.liteBlue97,
    AppTheme.grey,
    AppTheme.bottomTabsLabelInActiveColor,
    AppTheme.litePink
  ];
}
