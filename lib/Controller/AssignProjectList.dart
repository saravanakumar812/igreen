import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../Components/Key.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/GetFactoryProject.dart';
import '../provider/menuProvider.dart';

class AssignProjectListController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxInt selectedTabIndex = RxInt(0);
  RxInt currentIndex = RxInt(0);
  RxList<GetFactoryProjectData> projectData = RxList();
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  List<Keyvalues> listValues = [
    Keyvalues(key: "0", value: "Progress "),
    Keyvalues(key: "1", value: "Completed"),
  ];

  updateCurrentTabIndex(int index) {
    print("INDEX$index");
    selectedTabIndex.value = index;
    listValues[selectedTabIndex.value].key;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getFactoryProject();
      isCall = true;
    }
  }

  Future<void> refreshData() async {
    getFactoryProject();
    return Future.delayed(Duration(seconds: 0));
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
