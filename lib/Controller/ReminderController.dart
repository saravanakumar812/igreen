import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../Utils/AppPreference.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/ReminderList.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class ReminderController extends GetxController {
  RxBool isLoading = false.obs;
  final ApiConnect _connect = Get.put(ApiConnect());
  RxList<ReminderData> reminderData = RxList();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController reminderDateController = TextEditingController();
  TextEditingController reminderTypeController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  RxString completedButtonText = RxString('Completed');
  RxString updateButtonText = RxString("Update");
  late menuDataProvider userDataProvider;
  bool isCall = false;
  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getReminderList();
      if(userDataProvider.getCurrentStatus == "Update"){
        setData();
      }
    }
  }

  Future<void> refreshData() async {
    getReminderList();
    return Future.delayed(Duration(seconds: 0));
  }

  getReminderList() async {
    Map<String, dynamic> payload = {
      'EmployeeId': AppPreference().getEmpId,
    };
    isLoading.value = true;
    print("Payload $payload");
    isLoading.value = true;
    var response = await _connect.getReminderListCall(payload);
    isLoading.value = false;
    if (!response.error!) {
      reminderData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.addReminder.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.addReminder.toName);
    }
  }
  Future<void> updateReminderCall(String s) async {

      Map<String, dynamic> payload = {
        'ReminderDate': userDataProvider.getReminderData!.reminderDate,
        'Amount': "",
        'Department': departmentController.text,
        'Id':userDataProvider.getReminderData!.remainderId.toString(),
        'ReminderStatus':userDataProvider.getCurrentStatus.toString() == 'Completed' ? "Completed":"Reject",
        'FromTransaction':"",
        'ReminderImage':"",
        'ImageProof':"",

      };
      print("updateReminderRequest:$payload");
      var response = await _connect.updateReminderCall(payload);
      debugPrint("updateReminderStatus: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.reminder.toName);

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
  Future<void> updateReminder() async {
    Map<String, dynamic> payload = {
        'ReminderDate': reminderDateController.text,
        'Amount': "",
        'Department': "",
        'Id':userDataProvider.getReminderData!.remainderId.toString(),
        'ReminderStatus':"",
        'FromTransaction':"",
        'ReminderImage':"",
        'ImageProof':"",

      };
      print("updateReminderRequest:$payload");
      var response = await _connect.updateReminderCall(payload);
      debugPrint("insertFoodResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        //Get.toNamed(AppRoutes.reminder.toName);

        Get.back();
        getReminderList();
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
    void setData(){
      ReminderData data = userDataProvider.getReminderData!;
      reminderDateController.text = data.reminderDate ?? "";
     // departmentController.text = data.department ?? "";
      print(" reminderdate${data.reminderDate}");
    }
  }

