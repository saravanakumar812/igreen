
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../forms/theme.dart';
import 'package:url_launcher/url_launcher.dart';


class AppUtility {
  static double getHeight(var percentage) {
    return Get.height * (percentage / 100);
  }

  static double getWidth(var percentage) {
    return Get.width * (percentage / 100);
  }

  static sp(var i) {
    return Get.width / 100 * (i / 3);
  }

  static String serverError = 'Server Error, Try again later';
  static String noDataFound = 'No Data Found';
  static String offlineMessage = 'Your device goes offline';
  static String connectivityMessage =
      'Check your internet connection and try again';
  static String offlineDataMessage =
      'Data Saved Locally, it will be uploaded once your device back online';
  static String onlineMessage = 'Your device back online';
  static String evaluationConfirmationMessage =
      'This lead is not yet confirmed for Evaluation process.';
  static String evaluationCheckMessage =
      'Complete Basic Info section to proceed.';

  static Future<void> showSnackBar(String message) {
    if (message.isNotEmpty) {
      Get.rawSnackbar(message: message, duration: const Duration(seconds: 2));
      return Future.delayed(const Duration(seconds: 2));
    }
    return Future.value();
  }

  static Widget showProgressBar() {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }


  static DateTime dobMinDate() {
    return DateTime(DateTime.now().year - 10);
  }

  static get commonShadow =>
       BoxShadow(color: AppTheme.borderShade1, blurRadius: 1);

  static get commonDecoration => BoxDecoration(
        color: AppTheme.primaryColor,
        boxShadow: [commonShadow],
        border: Border.all(color: AppTheme.borderShade1),
        borderRadius: BorderRadius.circular(5),
      );


  static openCallApp(String phoneNumber) async {
    try {
      if (phoneNumber.isNotEmpty) {
        await launch("tel:${phoneNumber.trim()}");
      } else {
        AppUtility.showSnackBar("Phone Number is Empty");
      }
    } catch (e) {
      AppUtility.showSnackBar("Currently not supported");
    }
  }

  static openEmailApp(String email) async {
    try {
      if (email.isNotEmpty) {
        final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email.trim());
        await launch(emailLaunchUri.toString());
      } else {
        AppUtility.showSnackBar("Email is Empty");
      }
    } catch (e) {
      AppUtility.showSnackBar("Currently not supported");
    }
  }


  static dismissKeyboard() {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
    } catch (e) {}
  }


}
