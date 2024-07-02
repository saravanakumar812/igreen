import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/OverAllSumOfCategoryAmountResponse.dart';
import '../provider/menuProvider.dart';
import '../model/responseModel/GetOverAllExpenseSummaryResponse.dart';

class ExpenseID {
  String? expenseId;

  ExpenseID(
      {this.expenseId,
        });

  ExpenseID.fromJson(Map<String, dynamic> json) {
    expenseId = json['expenseId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expenseId'] = this.expenseId;
    return data;
  }
}

class SummaryScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<GraphData> getSummaryListData = RxList();
  RxList<CategoryAmount> getSummaryCategoryAmount = RxList();
  RxInt selectedValues = RxInt(0);
  RxInt SumValue = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    getSummaryList();
    getAllSumValue();
  }

  Future<void> refreshData() async {
    getSummaryList();
    getAllSumValue();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getSummaryList() async {

    Map<String, dynamic> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
      'projectCode': userDataProvider.projectCode.toString(),
    };

    print("getSummaryList:$payload");
    SumValue.value = 0;
    var response = await _connect.getSummaryCall(payload);
    debugPrint("getSummaryListResponse: ${response.toJson()}");
    getSummaryListData.clear();
    if (!response.error! && response.data!.isNotEmpty) {
      getSummaryListData.value = response.data!;
      for(int i =0 ; i<getSummaryListData.length!; i++) {
        SumValue.value += getSummaryListData[i]
            .expenseAmount!;
      }
    } else {
    }
    isLoading.value = true;
    isLoading.value = false;
  }

  Future<void> getAllSumValue() async {

    Map<String, dynamic> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
      'StartDate': "",
      'EndDate': "",
    };

    var response = await _connect.getAllExpenseSummary(payload);
    debugPrint("getSummaryListResponse: ${response.toJson()}");

    if (!response.error!) {
      getSummaryCategoryAmount.value = response.data!;
    } else {}

    isLoading.value = true;
    isLoading.value = false;

  }

  Future<void> addUpload() async {

    if(getSummaryListData.isEmpty){
      Fluttertoast.showToast(
        msg: "List is Empty.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    List<ExpenseID> expenseIDs =  [];

    for(int i = 0; i< getSummaryListData!.length; i++){
      ExpenseID expenseID = ExpenseID();
      expenseID.expenseId = getSummaryListData[i].id.toString() ?? "0";
      expenseIDs.add(expenseID);
    }

    print("json.encode(expenseIDs)${json.encode(expenseIDs)}");

    Map<String, dynamic> payload = {
      'expenseIds':json.encode(expenseIDs)
    };

    print("getSummaryList:$payload");
    isLoading.value = true;
    var response = await _connect.addOverAllSummary(payload);
    isLoading.value = false;

    debugPrint("getSummaryListResponse: ${response.toJson()}");
    if (!response.error!) {

      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      getSummaryList();
      getAllSumValue();
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': getSummaryListData[selectedValues.value].id.toString(),
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId.toString(),
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': getSummaryListData[selectedValues.value].mainCategory.toString(),
      'mainCategoryId': getSummaryListData[selectedValues.value].id.toString(),
      'Types': '',
      'SGST': '',
      'CGST': '',
      'IGST': '',
      'LedgerName': '',
      'LedgerGroups': '',
      'LedgerCategory1': '',
      'LedgerCategory2': '',
      'LedgerCategory3': '',
      'LedgerCategory4': '',
      'LedgerCategory5': '',
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
      getSummaryList();
      getAllSumValue();
    } else {}
    ;
  }

}
