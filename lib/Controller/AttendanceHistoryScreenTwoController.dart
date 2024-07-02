import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../Utils/AppPreference.dart';
import '../model/responseModel/GetUserLeaveListResponse.dart';
import '../api_connect/api_connect.dart';
import '../provider/menuProvider.dart';

class AttendanceHistoryScreenTwoController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<UserleaveData> userLeaveData = RxList();

  Future<void> refreshData() async {
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getUserLeave();
      isCall = true;
    }
  }

  Future<void> getUserLeave() async {
    Map<String, dynamic> payload = {
      'EmployeeId': userDataProvider.getAttendanceEmpId.toString(),
    };
    isLoading.value = true;

    print("getUserLeave:$payload");
    var response = await _connect.getUserLeaveCall(payload);
    isLoading.value = false;

    debugPrint("getUserLeave: ${response.toJson()}");
    if (!response.error!) {
      userLeaveData.value = response!.data!;
    }
  }
}
