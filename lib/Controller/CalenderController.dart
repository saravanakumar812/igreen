import 'dart:io';
import 'dart:math';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../api_connect/api_connect.dart';
import '../model/CalenderLeaveListResponseModel.dart';

import '../routes/app_routes.dart';

class CalenderController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  RxList<CalenderLeaveListData> getLeaveList = RxList();
  DateTime currentDate = DateTime(2024, 1, 6);
  DateTime _currentDate2 = DateTime(2023, 2, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
  DateTime _targetDateTime = DateTime(2023, 2, 3);
  String selectedDate = '';
  String dateCount = '';
  String range = '';
  String rangeCount = '';
  RxList<DateTime> leaveDateTime = RxList();
  final ImagePicker picker = ImagePicker();
  final DateTime startDate = DateTime.now().subtract(const Duration(days: 990));
  final DateTime endDate = DateTime.now().add(const Duration(days: 990));
  final Random random = Random();
  bool isCall = false;
  File? imageFile;

  Future pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {

      imageFile = File(pickedImage.path);

    }
  }
  Future cropImage() async {
    if (imageFile != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: imageFile!.path,
          aspectRatioPresets:
          [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],

          uiSettings: [
          AndroidUiSettings(
          toolbarTitle: 'Crop',
          cropGridColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
          IOSUiSettings(title: 'Crop')
    ]);

    if (cropped != null) {

    imageFile = File(cropped.path);

    }
  }
  }

  void clearImage() {

    imageFile = null;

  }



//   Rx<XFile> imageFile  = XFile('').obs;
// pickedGalleryImage() async {
//   imageFile.value = (await picker.pickImage(source:
//   ImageSource.gallery,imageQuality: 100))!;
//   imageFile.refresh();
//
//
// }pickedCameraImage() async {
//   imageFile.value = (await picker.pickImage(source:
//   ImageSource.camera,imageQuality: 100))!;
//   imageFile.refresh();
// }

  @override
  void onInit() async {
    super.onInit();

    if (!isCall) {
      isCall = true;
      getLeaveDateList();
    }
  }
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
      // ignore: lines_longer_than_80_chars
          ' ${DateFormat('dd/MM/yyyy').format(
          args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      selectedDate = args.value.toString();
    } else if (args.value is List<DateTime>) {
      dateCount = args.value.length.toString();
    } else {
      rangeCount = args.value.length.toString();
    }
  }

  List<DateTime> getSpecialDates() {
    List<DateTime> specialDates = [];

    // Add weekends
    for (int i = 0; i < 30; i++) {
      DateTime date = DateTime.now().add(Duration(days: i));
      if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
        specialDates.add(date);
      }
    }

    // Add holidays (for demonstration, you can replace this with actual holiday dates)
    specialDates.add(DateTime.now().add(Duration(days: 2))); // Example holiday date
    specialDates.add(DateTime.now().add(Duration(days: 5))); // Example holiday date

    return specialDates;
  }

  Future<void> getLeaveDateList() async {
    isLoading.value = true;
    var response = await _connect.getLeaveList();
    isLoading.value = false;
    if (!response.error!) {
      getLeaveList.value = response.data!;
      update();



        //print('LeaveDateList:$leaveDateTime');
        for (int i = 0; i < getLeaveList.length; i++) {
          if (getLeaveList[i].leaveDate != null && getLeaveList[i].leaveDate!.isNotEmpty) {
            DateTime leaveDate = DateTime.parse(getLeaveList[i].leaveDate!);
            leaveDateTime.add(leaveDate);
            // print('LeaveDateInApi:$leaveDate');
           // print('LeaveDateList:$leaveDateTime');
          }
        }


      if (response.data!.isEmpty) {
        Get.toNamed(AppRoutes.onDutyEntry.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.onDutyEntry.toName);
    }
  }

}



