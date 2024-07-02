import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/GetAllUserResponse.dart';
import '../provider/menuProvider.dart';

class AttendanceHistoryScreenOneController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<GetUserData> userData = RxList();

  Future<void> refreshData() async {
    getUser();
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getUser();
      isCall = true;
    }
  }

  getUser() async {
    isLoading.value = true;
    var response = await _connect.getUserCall();
    isLoading.value = false;
    if (!response.error!) {
      userData.value = response.data!;
      debugPrint("getUser: ${response.toJson()}");
    } else {}
  }
}
