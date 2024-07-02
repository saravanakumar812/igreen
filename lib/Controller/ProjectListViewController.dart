
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';

import '../Components/Key.dart';
import '../api_connect/api_connect.dart';
import '../model/ProjectViewResponseModel.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class ProjectListViewController extends GetxController{

  RxInt selectedTabIndex = 0.obs;
  RxInt currentIndex = RxInt(0);
  RxBool isLoading = RxBool(false);
  RxBool isSub1 = RxBool(false);
  RxInt overallTotal = RxInt(0);
  RxInt overallExpense = RxInt(0);
  final ApiConnect _connect = Get.put(ApiConnect());
  RxList<ProjectViewResponseModelData> projectView = RxList();
  TextEditingController projectCodeController = TextEditingController();
  RxList<ProjectViewResponseModelData> filterDemoCarList= RxList();
  late menuDataProvider userDataProvider;

  @override
  void onInit() {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);

    projectViewData("");
    filterDemoCarList.clear();
  }
  List<Keyvalues> listValues = [
    Keyvalues(key: "0", value: "Site"),
   // Keyvalues(key: "1", value: "Site"),
  ];

  updateCurrentTabIndex(int index) {
    print("INDEX$index");
    selectedTabIndex.value = index;
    listValues[selectedTabIndex.value].key;
    update();
  }
  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      if (query.length < 2) {
        return;
      }
      String lowercaseQuery = query.toLowerCase();
      List<ProjectViewResponseModelData> filteredList = <ProjectViewResponseModelData>[];
      for (var item in projectView) {
        String lowercaseValue = item.projectCode!.toLowerCase();
        if (lowercaseValue.contains(lowercaseQuery)) {
          filteredList.add(item);
        }
      }
      filterDemoCarList.value = filteredList;
      update();
    } else {
      print("else");
      filterDemoCarList.value = projectView;
      update();
   }
    }
  Future<void> projectViewData(String code) async {

      Map< String ,dynamic> payload = {
        'projectCode': code,

      };
      print("projectViewDataPayLoad:$payload");
      isLoading.value = true;
      var response = await _connect.projectViewCall(payload);

      debugPrint("projectViewDataResponse: ${response.toJson()}");
      if (!response.error!) {
        projectView.value = response.data!;
        filterDemoCarList.value = response.data!;
      }
      isLoading.value = false;
    }



}