import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../Utils/AppPreference.dart';
import '../api_connect/api_connect.dart';
import '../model/LeaveDynamicResponseModel.dart';
import '../model/responseModel/GetUserLeaveListResponse.dart';
import '../provider/menuProvider.dart';

class LeaveStatusScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<UserleaveData> userLeaveData = RxList();
  RxList<Count> countData = RxList();
  RxList<LeaveDynamicData> leaveDynamicData = RxList();

  RxInt taskIdValue = RxInt(0);
  RxInt totalValue = RxInt(0);
  RxInt medicalLeaveValue = RxInt(0);
  RxInt causalLeaveValue = RxInt(0);
  RxInt sickLeaveValue = RxInt(0);
  RxInt privilegeLeaveValue = RxInt(0);
  RxInt otherLeaveValue = RxInt(0);

  Future<void> refreshData() async {
    getDynamicLeave();
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getDynamicLeave();
      getUserLeave();
      isCall = true;
    }
  }

  Future<void> getUserLeave() async {
    Map<String, dynamic> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
    };
    print("getUserLeave:$payload");
    var response = await _connect.getUserLeaveCall(payload);
    debugPrint("getUserLeave: ${response.toJson()}");
    if (!response.error!) {
      userLeaveData.value = response!.data!;
      countData.value = response!.count!;

      // medicalLeaveValue.value = response!.count![0]!.medicalLeave ?? 0;
      // causalLeaveValue.value = response!.count![0]!.casualLeave ?? 0;
      //
      // totalValue.value = response!.count![0]!.total ?? 0;
    }
  }
  Future<void> getDynamicLeave() async {


    var response = await _connect.getLeaveDynamic();
    debugPrint("getUserLeave: ${response.toJson()}");
    if (!response.error!) {
      leaveDynamicData.value = response!.data!;
      leaveDynamicData.value = response!.data!;
      medicalLeaveValue.value = response!.data![0]!.medicalLeave ?? 0;
      causalLeaveValue.value = response!.data![0]!.casualLeave ?? 0;
      totalValue.value = response!.data![0]!.totalLeave ?? 0;
      sickLeaveValue.value = response!.data![0]!.sickLeave ?? 0;
      privilegeLeaveValue.value = response!.data![0]!.privilegeLeave ?? 0;
      otherLeaveValue.value = response!.data![0]!.otherLeave ?? 0;
    }
  }
}
