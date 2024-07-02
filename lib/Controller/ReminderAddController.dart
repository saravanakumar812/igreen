// import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../Components/Key.dart';
import '../Utils/AppPreference.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/FactoryDepartmentResponse.dart';
import '../model/responseModel/FactoryEmployeeDataResponse.dart';
import '../model/responseModel/ProjectCodeListResponse.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class ReminderAddController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  TextEditingController startDateController = TextEditingController();
  TextEditingController reminderDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController reminderTypeController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController projectCodeController = TextEditingController();
  TextEditingController resourcesController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  RxBool selectProjectList = false.obs;
  RxBool departmentSelection = false.obs;
  RxBool resourceSelection = false.obs;
  RxList<ProjectListData> projectData = RxList();
  RxList<FactoryDepartmentData> factoryDepartmentData = RxList();
  RxList<FactoryEmployeeData> factoryEmployeeData = RxList();
  TextEditingController staffDetails = TextEditingController();
  TextEditingController teamSelection = TextEditingController();
  RxBool factoryDepartment = RxBool(false);
  RxBool assign = RxBool(false);
  RxBool factoryEmployee = RxBool(false);
  late menuDataProvider userDataProvider;
  List<String> resourceDetails = [];
  List<String> departmentDetails = [];
  RxInt selectedTabIndex = 0.obs;
  RxString selectItems = RxString("Select Project");
  RxBool isLoading = RxBool(false);
  bool isCall = false;
  RxString depId = RxString('');
  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getProjectList();
      getFactoryDepartmentTeam();
    }

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

  getProjectList() async {
    isLoading.value = true;
    var response = await _connect.getProjectListCall();
    isLoading.value = false;
    if (response.data != null) {
      projectData.value = response.data!;
      debugPrint("getProjectList: ${response.toJson()}");
    } else {}
  }
  bool firstValidation() {

    if (commentsController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Comment!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  updateCurrentTabIndex(int index) {
    print("INDEX$index");
    selectedTabIndex.value = index;
    listValues[selectedTabIndex.value].key;
    update();
  }
  List<Keyvalues> listValues = [
    Keyvalues(key: "0", value: "Self reminder"),
    Keyvalues(key: "1", value: "General reminder"),
  ];

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
  Future<void> insertReminder() async {
    if (firstValidation()) {
      Map<String, dynamic> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'ProjectCode': userDataProvider.projectCode.toString(),
        'Comments': commentsController.text,
        'ReminderType': "",
        'ReminderDate': reminderDateController.text,
        'Amount': "",
        'Department': teamSelection.text,
      };
      print("insertReminderRequest:$payload");
      var response = await _connect.insertReminderCall(payload);
      debugPrint("insertFoodResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.reminder.toName);
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
  }


}
