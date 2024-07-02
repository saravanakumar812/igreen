import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../api_connect/api_connect.dart';
import '../model/EscalationRespondRequestModel.dart';
import '../model/responseModel/GetEscalationResponse.dart';
import '../provider/menuProvider.dart';

class EscalationOneController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<EscalationData> escalationData = RxList();
  RxList<EscalationRespondData> escalationResponseData = RxList();

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getEscalation();
      isCall = true;
    }
  }

  Future<void> refreshData() async {
    getEscalation();
    return Future.delayed(Duration(seconds: 0));
  }

  getEscalation() async {
    isLoading.value = true;
    var response = await _connect.getEscalationCall();
    isLoading.value = false;
    if (response.data != null) {
      escalationData.value = response.data!;
      debugPrint("getApprovalList: ${response.toJson()}");
    } else {}
  }
}
