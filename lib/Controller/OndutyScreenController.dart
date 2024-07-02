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
import '../../provider/menuProvider.dart';
import '../../routes/app_routes.dart';
import '../Components/KeyValueOne.dart';
import '../Utils/AppPreference.dart';
import '../model/GetOnDutyEmployeeIdResponse.dart';
import '../model/OnDutyRejectedResponseModel.dart';
import '../model/OnDutyResponseModel.dart';
import '../model/OndutyApprovedResponseModel.dart';
import '../model/OndutyPendingResponseModel.dart';

class OnDutyScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  RxBool isLoadingOne = RxBool(false);
  late menuDataProvider userDataProvider;

  RxList<OnDutyResponseData> onDutyData = RxList();
  RxList<GetOnDutyEmployeeIdResponseData> onDutyEmployeeData = RxList();
  RxList<OnDutyPendingResponseData> onDutyPendingData = RxList();
  RxList<OnDutyApprovedResponseData> onDutyApprovedData = RxList();
  RxList<OnDutyRejectedResponseData> onDutyRejectedData = RxList();
  RxString editButtonText = RxString('Edit');
  bool isCall = false;
  RxInt selectId = RxInt(0);
  RxInt selectedTabIndex = 0.obs;
  RxInt selectedTabIndexOne = 0.obs;
  RxInt currentIndex = RxInt(0);
  RxInt currentIndexOne = RxInt(0);
  RxString reuseButtonText = RxString('Re-Use');
  RxInt selectedValues = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getOnDutyList();
      getOnDutyEmployeeList();
      getOnDutyApprovedList();
      getOnDutyRejectList();
      getOnDutyPendingList();
    }
  }

  Future<void> refreshData() async {
    getOnDutyList();
    getOnDutyEmployeeList();
    getOnDutyApprovedList();
    getOnDutyRejectList();
    getOnDutyPendingList();
    return Future.delayed(Duration(seconds: 0));
  }

  List<Keyvalues> listValues = [
    Keyvalues(key: "0", value: "User "),
    Keyvalues(key: "1", value: "Admin"),
  ];

  List<KeyvaluesOne> listValuesOne = [
    KeyvaluesOne(key: "0", value: "Pending"),
    KeyvaluesOne(key: "1", value: "Approve"),
    KeyvaluesOne(key: "2", value: "Reject"),
  ];

  updateCurrentTabIndex(int index) {
    print("INDEX$index");
    selectedTabIndex.value = index;
    listValues[selectedTabIndex.value].key;
    update();
  }
  updateCurrentTabIndexOne(int index) {
    print("INDEX$index");
    selectedTabIndexOne.value = index;
    listValuesOne[selectedTabIndexOne.value].key;
    update();
  }




  Future<void> getOnDutyList() async {
    isLoading.value = true;
    var response = await _connect.getOnDuty();
    isLoading.value = false;
    if (!response.error!) {
      onDutyData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.onDutyEntry.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.onDutyEntry.toName);
    }
  }
  Future<void> getOnDutyApprovedList() async {
    isLoading.value = true;
    var response = await _connect.getOnDutyApproved();
    isLoading.value = false;
    if (!response.error!) {
      onDutyApprovedData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.onDutyEntry.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.onDutyEntry.toName);
    }
  }
  Future<void> getOnDutyPendingList() async {
    isLoading.value = true;
    var response = await _connect.getOnDutyPending();
    isLoading.value = false;
    if (!response.error!) {
      onDutyPendingData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.onDutyEntry.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.onDutyEntry.toName);
    }
  }
  Future<void> getOnDutyRejectList() async {
    isLoading.value = true;
    var response = await _connect.getOnDutyRejected();
    isLoading.value = false;
    if (!response.error!) {
      onDutyRejectedData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.onDutyEntry.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.onDutyEntry.toName);
    }
  }
  Future<void> getOnDutyEmployeeList() async {
    Map<String, dynamic> payload = {
      'employeeId': AppPreference().getEmpId
    };
    isLoading.value = true;
    var response = await _connect.onDutyApproval(payload);
    isLoading.value = false;
    if (!response.error!) {
      onDutyEmployeeData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.onDutyEntry.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.onDutyEntry.toName);
    }
  }

  Future<void> updateOnDuty() async {
    Map<String, dynamic> payload = {
      'Id': userDataProvider.getOnDutyEmployeeData!.id.toString(),
      'latitude':" currentLatitudeController.value.toString()",
      'longitude': "currentLongitudeController.value.toString()",
      'employeeId': AppPreference().getEmpId.toString(),
      'startingDate': "",
      'endingDate': "",
      'remarks': "",
      'ondutyStatus': userDataProvider.currentStatus == "Approve"? "Approve" : "Pending",
    };

    print('OnDutyUpdateRequest$payload');
    var response = await _connect.updateOnDutyCall(
        payload);
    debugPrint("OnDutyUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.bottomNavBar.toName);
      Get.deleteAll();
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
  Future<void> statusUpdate() async {
    Map<String, dynamic> payload = {
      'Id': onDutyData[selectedValues.value].id,
      'ExpenseStatus': '3',
      'EmployeeId': AppPreference().getEmpId,
      'projectCode': userDataProvider.projectCode.toString(),
      'Category1': 'Food',
      'mainCategoryId': onDutyData[selectedValues.value].id,
      'Types': '',
      'SGST': '',
      'CGST': '',
      'IGST': '',
      'LedgerName': '',
      'LedgerGroups': '',
      'LedgerCategory1': '',
      'LedgerCategory2': '',
      'LedgerCategory3': '',
      'LedgerCategory4': '',
      'LedgerCategory5': '',
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
      getOnDutyList();
    } else {}
    ;
  }
}
