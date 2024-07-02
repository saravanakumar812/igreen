import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../api_connect/api_connect.dart';
import '../model/responseModel/GetFactoryProject.dart';
import '../provider/menuProvider.dart';

class EmployeeProjectListController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxList<GetFactoryProjectData> projectData = RxList();

  Future<void> refreshData() async {
    getFactoryProject();

    return Future.delayed(Duration(seconds: 0));
  }

  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getFactoryProject();
      isCall = true;
    }
  }

  getFactoryProject() async {
    isLoading.value = true;
    var response = await _connect.getFactoryProjectCall();
    isLoading.value = false;
    if (response.data != null) {
      projectData.value = response!.data!;
      debugPrint("getFactory: ${response.toJson()}");
    } else {}
  }
}
