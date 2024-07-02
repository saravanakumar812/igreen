import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../api_connect/api_connect.dart';
import '../model/responseModel/GetAttendanceListResponse.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class AttendanceApprovalController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxBool completedVisible = RxBool(false);
  RxBool pendingVisible = RxBool(true);
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<Attendance> attendanceData = RxList();
  RxList<Attendance> attendanceCompleteData = RxList();
  RxList<AttendanceCount> attendanceCount = RxList();


  RxList<bool> onClickList = RxList();
  RxInt attendanceIdValue = RxInt(0);
  RxInt attendanceApprove = RxInt(0);
  RxBool selectAllCheckValue = RxBool(false);

  void onSelectAll(bool value) {
    selectAllCheckValue.value = value;

    for (int i = 0; i < onClickList.length; i++) {
      onClickList[i] = value;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getAttendanceList();
      isCall = true;
    }
  }

  Future<void> refreshData() async {
    getAttendanceList();
    return Future.delayed(Duration(seconds: 0));
  }

  getAttendanceList() async {
    isLoading.value = true;
    var response = await _connect.getAttendanceCall();
    isLoading.value = false;
    if (!response.error!) {
      // attendanceData.value = response.attendance!;
      attendanceCount.value = response.attendanceCount!;
      debugPrint("getAttendanceList: ${response.toJson()}");
      onClickList.clear();
      attendanceData.clear();
      attendanceCompleteData.clear();
      for (int i = 0; i < response.attendance!.length; i++) {
        onClickList.add(false);
        if (response.attendance![i].attendanceApproval == 0) {
          attendanceData.add(response.attendance![i]);
        } else {
          attendanceCompleteData.add(response.attendance![i]);
        }
      }
    } else {}
  }

  Future<void> attendance(int attendanceValues) async {
    Map<String, dynamic> payload = {
      'AttendanceApprove': attendanceValues,
      'AttendanceId': attendanceData[attendanceIdValue.value].attendanceId,
    };
    print('attendance:$payload');
    var response = await _connect.attendanceApprovalCall(payload);
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      attendanceData.clear();
      attendanceCount.clear();
      getAttendanceList();
      // Get.offNamed(AppRoutes.fuelSummary.toName);
    } else
      () {};
  }
}
