import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../api_connect/api_connect.dart';
import '../model/SiteProjectCodeResponseModel.dart';
import '../provider/menuProvider.dart';

class ProjectCodeScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxList<SiteProjectCodeResponseModelData> siteProject = RxList([]);
  RxBool isLoading = RxBool(false);
  bool isCall = false;
  @override
  void onInit() {
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);

    super.onInit();
    if (!isCall) {
      getSiteProjectCodeData();
      isCall = true;
    }
  }
  Future<void> refreshData() async {
    getSiteProjectCodeData();
    return Future.delayed(Duration(seconds: 0));
  }
  getSiteProjectCodeData() async {
    isLoading.value = true;
    var response = await _connect.siteProjectCode();
    if (!response.error!) {
      siteProject.value = response.data!;
      debugPrint("getSiteProjectCodeResponse: ${response.toJson()}");
    } else {}
    isLoading.value = false;
  }


}
