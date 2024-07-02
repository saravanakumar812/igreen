
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../UI/ProjectCreation/UPdate_Site_Projects.dart';
import '../api_connect/api_connect.dart';
import '../model/GetParticularSiteProjectResponse.dart';
import '../provider/menuProvider.dart';

class ProjectCodeDetailsViewScreenController extends GetxController{
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<GetParticularSiteProjectResponseData> getParticularSiteProjectData = RxList();
  @override
  void onInit() {
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    super.onInit();
  }

getParticularSiteProjectApi(String SiteProjectId) async {
  Map<String, dynamic> payload = {
    'SiteProjectId': SiteProjectId,
  };
  print("getParticularSiteProjectRequestPayLoad${payload}");
  isLoading.value = true;
  var response = await _connect.getParticularSiteApiCall(payload);
  if (!response.error!) {
    getParticularSiteProjectData.value = response.data!;
    debugPrint("getParticularSiteProjectResponse: ${response.toJson()}");
    Get.to(UpdateSiteProjectsOne());
  } else {}

}
}