import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';

import '../api_connect/api_connect.dart';
import '../routes/app_routes.dart';

class ChangePasswordScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  TextEditingController numController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  var oldPass = true.obs;
  var newPass = true.obs;
  var conFirmPass = true.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  bool firstValidation() {
    if (newPassController.value.text != confirmPassController.value.text) {
      Fluttertoast.showToast(
        msg: "Please Enter Confirm Password And new Password same",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  Future<void> changePassword() async {
    if (firstValidation()) {
      Map<String, dynamic> payload = {
        "EmployeeId": AppPreference().getEmpId.toString(),
        "OldPassword": oldPassController.text,
        "Password": newPassController.text,
        "ConfirmPassword": confirmPassController.text
      };
      print("statusUpdate:$payload");
      var response = await _connect.changePasswordCall(payload);
      debugPrint("statusUpdateResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.bottomNavBar.toName);
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

  Future<void> forgotPassword() async {

    if (mobileNumberController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Mobile password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    if (mobileNumberController.value.text.length != 10) {
      Fluttertoast.showToast(
        msg: "Please Enter Correct Mobile password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    if (newPassController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter New password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    if (confirmPassController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Confirm password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    if (newPassController.value.text != confirmPassController.value.text) {
      Fluttertoast.showToast(
        msg: "Please Enter Confirm Password And new Password same",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    Map<String, dynamic> payload = {
      "MobileNum": mobileNumberController.text,
      "Password": newPassController.text,
    };
    print("statusUpdate:$payload");
    var response = await _connect.changePasswordCall(payload);
    debugPrint("statusUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.bottomNavBar.toName);
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
