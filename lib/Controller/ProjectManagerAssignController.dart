import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/model/responseModel/FactoryDepartmentResponse.dart';
import 'package:igreen_flutter/model/responseModel/FactoryEmployeeDataResponse.dart';
import 'package:provider/provider.dart';
import '../../api_connect/api_connect.dart';
import '../../provider/menuProvider.dart';

class ProjectManagerAssignController extends GetxController {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController teamSelection = TextEditingController();
  TextEditingController staffDetails = TextEditingController();
  TextEditingController messageController = TextEditingController();
  RxString depId = RxString('');

  RxInt selectedSub1Index = RxInt(0);
  RxInt selectedSub2Index = RxInt(0);
  RxBool isLoading = RxBool(false);
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxList<FactoryDepartmentData> factoryDepartmentData = RxList();
  RxList<FactoryEmployeeData> factoryEmployeeData = RxList();
  RxString editButtonText = RxString('Approved');
  bool isCall = false;
  RxBool factoryDepartment = RxBool(false);
  RxBool factoryEmployee = RxBool(false);
  RxBool assign = RxBool(false);
  RxInt selectValues = RxInt(0);
  RxInt selectEmp = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getFactoryDepartmentTeam();
    }
  }

  Future<void> refreshData() async {
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getFactoryDepartmentTeam() async {
    isLoading.value = true;
    var response = await _connect.getFactoryDepartmentCall();
    isLoading.value = false;
    if (!response.error!) {
      factoryDepartmentData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
      } else {}
    } else {}
  }

  Future<void> getFactoryEmployee(int? departmentId) async {
    Map<String, dynamic> payload = {
      'DepartmentId': departmentId,
    };
    print('1223Payload:$payload');
    var response = await _connect.factoryEmployeeResponseCall(payload);
    debugPrint("fetchSubCategoryTwo: ${response.toJson()}");
    if (!response.error!) {
      factoryEmployeeData.value = response.data!;
      update();
    } else
      () {};
  }

  bool firstValidation() {
    if (messageController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Messages!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> updateAssignProjectTeam() async {
    if (firstValidation()) {
      Map<String, dynamic> payload = {
        'ProjectId': userDataProvider.getEmployeeDetailsData!.projectId,
        'EmployeeId': factoryEmployeeData[selectEmp.value].employeeId,
        'StartDate': startDateController.text,
        'EndDate': endDateController.text,
        'Remarks': messageController.text,
        'DepartmentId': depId.value,
      };

      print("updateRequest:$payload");
      var response = await _connect.updateAssignProjectCall(payload);
      debugPrint("updateResponse: ${response.toJson()}");

      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
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
}
