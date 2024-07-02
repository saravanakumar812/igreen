import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/model/responseModel/CommercialList.dart';
import 'package:provider/provider.dart';
import '../../Components/Key.dart';
import '../../api_connect/api_connect.dart';
import '../../model/responseModel/GetCommercialFromTechnicalResponse.dart';
import '../../model/responseModel/GetFactoryProject.dart';
import '../../provider/menuProvider.dart';
import '../../routes/app_routes.dart';

class CommercialPageController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<CommercialData> commercialData = RxList();
  RxList<GetFactoryProjectData> projectData = RxList();
  RxString editButtonText = RxString('Approved');
  bool isCall = false;
  RxInt selectId = RxInt(0);
  RxInt selectedTabIndex = 0.obs;
  RxInt currentIndex = RxInt(0);
  RxList<GetCommercialFromTechnicalResponseData> technicalData = RxList();

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getCommercialTeam();
      getCommercialFromTechnical();
      getFactoryProject();
    }
  }

  Future<void> refreshData() async {
    getCommercialTeam();
    getCommercialFromTechnical();
    return Future.delayed(Duration(seconds: 0));
  }

  List<Keyvalues> listValues = [
    Keyvalues(key: "0", value: "Sales "),
    Keyvalues(key: "1", value: "Technical"),
    Keyvalues(key: "2", value: "Assigned"),
  ];

  updateCurrentTabIndex(int index) {
    print("INDEX$index");
    selectedTabIndex.value = index;
    listValues[selectedTabIndex.value].key;
    update();
  }

  Future<void> getCommercialTeam() async {
    isLoading.value = true;
    var response = await _connect.getCommercialTeamExpenseCall();
    isLoading.value = false;
    if (!response.error!) {
      commercialData.value = response.data!;
    }
  }

  Future<void> getCommercialFromTechnical() async {
    isLoading.value = true;
    var response = await _connect.getCommercialFromTechnicalCall();
    isLoading.value = false;
    if (!response.error!) {
      technicalData.value = response.data!;
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

  Future<void> updateCommercialToTechnical() async {
    Map<String, dynamic> payload = {
      'FactoryId': commercialData[selectId.value].projectId,
    };
    print("updateCommercialToTechnicalRequest:$payload");

    var response = await _connect.updateCommercialToTechnicalCall(payload);
    debugPrint("updateCommercialToTechnicalResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.toNamed(AppRoutes.technicalPage.toName);
      // Get.deleteAll();
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.red,
      );
    }
  }
}
