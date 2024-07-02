import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:igreen_flutter/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../provider/menuProvider.dart';

class SupportMessageScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  TextEditingController messageController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
    }
  }

  bool firstValidation() {
    if (messageController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Message!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  Future<void> support() async {
    if (firstValidation()) {
      Map<String, dynamic> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'EmployeeName': AppPreference().getEmpName.toString(),
        'Mobile': AppPreference().getMobileNumber.toString(),
        'Message': messageController.text,
      };
      messageController.clear();
      print('support:$payload');
      var response = await _connect.supportCall(payload);
      debugPrint("supportResponse: ${response.toJson()}");

      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response!.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.bottomNavBar.toName);
      }
    }
  }
}
