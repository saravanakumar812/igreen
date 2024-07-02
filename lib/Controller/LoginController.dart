import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../api_connect/api_connect.dart';
import '../UI/BottomNavBarScreen.dart';
import '../Utils/AppPreference.dart';
import '../provider/menuProvider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class LoginController extends GetxController {
  RxBool initialLoading = RxBool(false);
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxString currentLongitude = RxString("");
  RxString currentLatitude = RxString("");
  RxString currentLongitudeController = RxString("");
  RxString currentLatitudeController = RxString("");
  RxString selectItemOne = RxString("Select Type");
  RxBool selectDropDown = RxBool(false);
  final auth = LocalAuthentication();
  String authorized = " not authorized";
  bool canCheckBiometric = false;
  late List<BiometricType> availableBiometric;

  @override
  void onInit() async {
    super.onInit();
    determinePosition();
    checkBiometric();
    getAvailableBiometric();
  }

  String get platform1 {
    if (Platform.isIOS) {
      return 'Android';
    } else if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isMacOS) {
      return 'MacOS';
    } else {
      return 'Unknown';
    }
  }

  Future<void> checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

   // if (!mounted) return;


      canCheckBiometric = canCheckBiometric;

  }

  Future getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }


      availableBiometric = availableBiometric;

  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan your finger to authenticate",
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    authorized =
      authenticated ? "Login successfully" : "Failed to authenticate";
      print(authorized);
      if(authenticated == true){
        AppPreference().getEmpId.toString();
        AppPreference().getEmpName.toString();
        AppPreference().getMobileNumber.toString();
        AppPreference().getDepId.toString();
        print( AppPreference().getEmpId.toString());
        print( AppPreference().getEmpName.toString());
        print( AppPreference().getMobileNumber.toString());
        print( AppPreference().getDepId.toString());

        Get.toNamed(AppRoutes.bottomNavBar.toName);
      }
    Fluttertoast.showToast(
      msg: authorized,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );

  }
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled, show a toast message
      Fluttertoast.showToast(
          msg: 'Location services are disabled. Please enable them.');
      return; // You may want to handle this case differently based on your app's logic
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      var status = await Permission.location.request();
      if (status == PermissionStatus.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
    var positions = await Geolocator.getCurrentPosition();
    var accuracy = await Geolocator.getLocationAccuracy();
    print('Accuracy: $accuracy');
    print('Latitude: ${positions.latitude}');
    print('Longitude: ${positions.longitude}');
    currentLongitudeController.value = positions.longitude.toString();
    currentLatitudeController.value = positions.latitude.toString();
  }

  bool firstValidation() {
    determinePosition();
    if (selectItemOne.value == 'Select Type') {
      Fluttertoast.showToast(
        msg: "Please Select Type!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  loginCall(context) async {
    if (phoneNoController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter Mobile number",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
if (phoneNoController.text.length < 10) {
      Fluttertoast.showToast(
        msg: "Please Enter Valid 10  number",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    if (passwordController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter Password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    Map<String, dynamic> payload = {
      'MobileNum': phoneNoController.value.text.toString(),
      'Password': passwordController.value.text.toString(),
      'Longitude': currentLongitudeController.value.toString(),
      'Latitude': currentLatitudeController.value.toString(),
      'Place': selectItemOne.value,
      'Device': platform1,
    };
    print(payload);

    var response = await _connect.login(payload);
    debugPrint("loginCallResponse: ${response.toJson()}");
    if (!response.error!) {
      AppPreference().updateEmpId(response.data!.employeeId!);
      AppPreference().updateEmpName(response.data!.employeeName!);
      AppPreference().updateMobileNumber(response.data!.mobileNum!);
      AppPreference().updateDepId(response.data!.departmentId!);
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
        (route) => false,
      );
      // Get.toNamed(AppRoutes.home.toName);

      passwordController.text = "";
      phoneNoController.text = "";
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  List<String> selectedItemDropDown = [
    'Office',
    'Factory',
    'Site',
    'WFH',
  ];
}
