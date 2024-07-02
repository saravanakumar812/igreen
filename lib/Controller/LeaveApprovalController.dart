import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/GetAllAppliedLeaveResponse.dart';
import '../provider/menuProvider.dart';

class LeaveApprovalController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<AppliedLeaveData> leaveListData = RxList();

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getApprovalList();
      isCall = true;
    }
  }

  Future<void> refreshData() async {
    getApprovalList();
    return Future.delayed(Duration(seconds: 0));
  }

  getApprovalList() async {
    isLoading.value = true;
    var response = await _connect.getAppliedLeaveCall();
    isLoading.value = false;
    if (response.data != null) {
      leaveListData.value = response.data!;
      debugPrint("getApprovalList: ${response.toJson()}");
    } else {}
  }
}
