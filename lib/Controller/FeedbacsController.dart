import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../api_connect/api_connect.dart';
import '../model/responseModel/GetAllFeedbackResponse.dart';
import '../provider/menuProvider.dart';

class FeedBackController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<FeedbackData> feedbackData = RxList();

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getFeedBack();
      isCall = true;
    }
  }

  Future<void> refreshData() async {
    getFeedBack();
    return Future.delayed(Duration(seconds: 0));
  }

  getFeedBack() async {
    isLoading.value = true;
    var response = await _connect.getFeedbackCall();
    isLoading.value = false;
    if (response.data != null) {
      feedbackData.value = response.data!;
      debugPrint("getFeedBackList: ${response.toJson()}");
    } else {}
  }
}
