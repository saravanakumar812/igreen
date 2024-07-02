import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../Utils/AppPreference.dart';
import '../Utils/image_picker.dart';
import '../api_connect/api_connect.dart';
import '../model/EscalationRespondRequestModel.dart';
import '../model/responseModel/EscalationPostResponse.dart';
import '../model/responseModel/ParticularTaskResponse.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class GriVanceController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<ParticularData> taskData = RxList();
  RxInt taskIdValue = RxInt(0);
  RxInt selectedId = RxInt(0);
  RxList<EscalationValues> getData = RxList();




  Future<void> refreshData() async {
    griVance();
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      griVance();
    }
  }

  Future<void> griVance() async {
    Map<String, dynamic> payload = {
      'EmployeeId': AppPreference().getEmpId,
    };
    isLoading.value = true;
    print("griVance$payload");
    var response = await _connect.escalationPostCall(payload);
    isLoading.value = false;
    debugPrint("griVanceResponse: ${response.toJson()}");
    if (!response.error!) {
      getData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.griVanceCreateScreen.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.griVanceCreateScreen.toName);
    }
  }
  Future<void> escalationRespond(int? escalationId) async {

    Map<String, dynamic> payload = {
      'EscalationId':
      escalationId,

    };
    print('object:$payload');
    var response = await _connect.escalationRespondCall(  payload);
    debugPrint("escalationApprovalResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );

      Get.offNamed(AppRoutes.escalationThree.toName);
    } else {}
  }

}
