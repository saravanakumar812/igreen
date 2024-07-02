import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../model/AttendanceResponseModel.dart';
import '../provider/menuProvider.dart';

class AttendanceScreeController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxString currentLongitudeController = RxString("");
  RxString currentLatitudeController = RxString("");
  RxInt checkIn = RxInt(1);
  RxInt checkOut = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      determinePosition();
      currentStatusCall();
      isCall = true;
    }
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
          msg: 'Location services are disabled. Please enable them.');
      return;
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
  AttendanceResponseData? statusValues;

  currentStatusCall() async {
    Map<String, dynamic> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
    };
    isLoading.value = true;
    print('currentStatusCallPayload:$payload');
    var response = await _connect.currentStatusCall(payload);
    debugPrint("currentStatusCallResponse: ${response.toJson()}");

    if (response != null) {
      statusValues = response.data!;
      AppPreference()
          .updateAttendanceId(response.data!.id.toString());

      print(response.data!.id.toString());
      //
      // checkIn.value = response.data!.checkIn!;
      // checkOut.value = response.data!.checkOut!;
      // totalHours.value = response.data!.totalHours!;
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
    isLoading.value = false;
  }
  Future<void> attendance() async {
    Map<String, dynamic> payload = {
      'CheckIn': statusValues == null ||
    statusValues!.status == null ||
    statusValues!.status!.isEmpty ||
    statusValues!.status == 'Check In'
    ? ''
        : '1',
      'CheckOut': statusValues!.id.toString().isNotEmpty ? "0" : " ",
      'EmployeeId': AppPreference().getEmpId.toString(),
      'AttendanceId': statusValues!.id.toString(),
      'DepartmentId': AppPreference().getDepId.toString(),
      'Latitude':   currentLatitudeController.value.toString(),
      'Longitude': currentLongitudeController.value.toString(),
      'Area': 'Chennai',
    };
    print("attendanceRequest:$payload");
    var response = await _connect.attendanceCall(payload);
    debugPrint("attendanceResponse: ${response.toJson()}");
    if (!response.error!) {
     // AppPreference().updateAttendanceId(response.data!.attendanceId.toString());
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      currentStatusCall();
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }
}
