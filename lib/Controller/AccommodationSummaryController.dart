import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/GetAccommodationResponse.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class AccommodationSummaryController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxList<GetAccommodationData> getAccommodation = RxList();
  RxBool isLoading = RxBool(false);
  RxString editButtonText = RxString('Edit');
  RxString reuseButtonText = RxString('Re-Use');
  bool isCall = false;
  RxInt selectedValues = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getAccommodations();
      ();
    }
  }

  Future<void> refreshData() async {
    getAccommodations();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getAccommodations() async {
    Map<String, dynamic> payload = {
      'projectCode': userDataProvider.projectCode.toString(),
      'EmployeeId': AppPreference().getEmpId.toString(),
    };
    isLoading.value = true;
    print("getGetAccommodation:$payload");
    var response = await _connect.getAccommodationCall(payload);
    isLoading.value = false;
    debugPrint("getGetAccommodationResponse: ${response.toJson()}");
    if (!response.error!) {
      getAccommodation.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.addAccommodation.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.addAccommodation.toName);
    }
  }

  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': getAccommodation[selectedValues.value].id.toString(),
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId.toString(),
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': 'Accommodation',
      'mainCategoryId': getAccommodation[selectedValues.value].id.toString(),

    };
    print("statusUpdate:$payload");
    var response = await _connect.statusUpdateCall(payload);
    debugPrint("statusUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      getAccommodations();
    } else {}
    ;
  }
}
