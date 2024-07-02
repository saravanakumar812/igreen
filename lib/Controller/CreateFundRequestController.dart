import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../../model/responseModel/GetNotificationResponse.dart';
import '../Utils/AppPreference.dart';
import '../api_connect/api_connect.dart';
import '../provider/menuProvider.dart';

class CreateFundRequestController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxList<FundData> listData = RxList();
  bool isCall = false;
  RxBool isLoading = RxBool(false);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getNotificationList();
    }
  }

  Future<void> refreshData() async {
    getNotificationList();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> deleteFunction(String Id) async {
    Map<String, String> payload = {
      'NotifiId': Id,
    };
    var response = await _connect.deleteNotification(payload);

    if (!response.error!) {
      getNotificationList();
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.red,
      );
    }
    ;
  }

  Future<void> getNotificationList() async {
    Map<String, dynamic> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
    };
    isLoading.value = true;
    print('getNotificationList:$payload');
    isLoading.value = false;
    var response = await _connect.getNotificationCall(payload);
    debugPrint("getNotificationListResponse: ${response.toJson()}");
    if (!response.error!) {
      listData.value = response.data!;
    } else
      () {};
  }
}
