import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/model/OnDutyResponseModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
//import 'package:record/record.dart';

import '../../../Utils/AppPreference.dart';
import '../../../Utils/image_picker.dart';
import '../../../api_connect/api_connect.dart';
import '../../../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../../../model/responseModel/FuelSubCategoryResponse.dart';
import '../../../provider/menuProvider.dart';
import '../api_config/ApiUrl.dart';
import '../model/GetOnDutyEmployeeIdResponse.dart';
import '../model/responseModel/EmployeeNameResponseModel.dart';
import '../model/responseModel/GeneralSummaryList.dart';
import '../routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:io';

class OnDutyEntryScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxInt selectedSub1Index = RxInt(0);
  RxInt selectedSub2Index = RxInt(0);
  RxBool isLoading = RxBool(false);
  RxBool isExpanded = RxBool(false);
  RxBool isSub1 = RxBool(false);
  RxBool isSub2 = RxBool(false);
  RxBool isSub2Available = RxBool(false);
  RxBool entries = RxBool(false);
  RxBool isOpened = RxBool(false);
  RxBool selectPerson = RxBool(false);
  RxBool commonVisible = RxBool(false);
  RxBool employeeNameSelect = RxBool(false);
  RxString currentDate = RxString("Spend Date");
  late menuDataProvider userDataProvider;
  RxBool popUpValue = RxBool(false);
  TextEditingController currentDateController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();
  TextEditingController subCategory1Controller = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController subCategory2Controller = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController noOfPeopleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController ticketController = TextEditingController();
  TextEditingController driveTipsController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController startDateAndTimeController = TextEditingController();
  TextEditingController closeDateAndTimeController = TextEditingController();
  RxString imagePathFromData  = RxString("");
  RxBool isUpdateImageAvailable = false.obs;
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(imagePath: null, file: null, renderType: RenderImage.platform, extension: '', base64: ''));
  RxString currentLongitude = RxString("");
  RxString currentLatitude = RxString("");
  RxString currentLongitudeController = RxString("");
  RxString currentLatitudeController = RxString("");

  RxBool pickImageSelected = false.obs;
  RxBool allVisible = RxBool(false);

  //final record = AudioRecorder();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  RxList<FuelSubOneData> subCategory1 = RxList();
  RxList<EmployeeNameResponseData> employeeName = RxList();
  RxList<SubcategoryTwoData> fetchCategoryTwo = RxList();
  bool isCall = false;
  bool isComplete = false;
  final FocusNode amountFocusNode = FocusNode();
  int i = 0;
  RxString? recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);

  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    determinePosition();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      if (userDataProvider.getCurrentStatus == 'Edit' ||
          userDataProvider.getCurrentStatus == 'Re-Use') {
        setData();
      }
    }

  }

  Future<bool> checkPermission() async {
    Map<Permission, PermissionStatus> permissions =
        await [Permission.storage, Permission.microphone].request();
    print(permissions[Permission.microphone]);
    return permissions[Permission.microphone] == PermissionStatus.granted;
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/test_${i++}.mp3";
  }

  void startRecord() async {
    audioPlayer = AudioPlayer();

    bool hasPermission = await checkPermission();
    if (hasPermission) {
      if (recordFilePath != null && File(recordFilePath!.value).existsSync()) {
        File(recordFilePath!.value).deleteSync();
        print("record1$recordFilePath");
      }

      if (userDataProvider.currentStatus == "Edit" ||
          userDataProvider.currentStatus == "Re-Use") {
        if (recordFilePath != null &&
            File(recordFilePath!.value).existsSync()) {
          File(recordFilePath!.value).deleteSync();
        }
      }

      recordFilePath!.value = await getFilePath();
      print("record2$recordFilePath");
      isComplete = false;
      RecordMp3.instance.start(recordFilePath!.value, (type) {});
      isAudio.value = false;
      isAudio.value = true;
    } else {}
  }
  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      isComplete = true;
    }
  }
  void deleteOldData() async {
    File(recordFilePath!.value).deleteSync();
    print("delete1$recordFilePath");
    recordFilePath!.value = "";
    print("delete2$recordFilePath");
    isComplete = false;
    isAudio.value = false;
  }
  void play() {
    if (recordFilePath != null && File(recordFilePath!.value).existsSync()) {
      audioPlayer.setFilePath(recordFilePath!.value);
      audioPlayer.play();
    } else if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      audioPlayer.setUrl("${ApiUrl.baseUrl}ideas/${userDataProvider
          .getOnDutyEmployeeData!.audioFile}");
      audioPlayer.play();
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {}
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {}
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {}
    }
  }



  bool firstValidation() {
    determinePosition();
    if (startDateAndTimeController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Start Date and Time!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }if (closeDateAndTimeController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Close Date and Time!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (remarksController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Remarks!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (selectedStartDate != null &&
        selectedEndDate != null &&
        selectedStartDate!.isAfter(selectedEndDate!)) {
      if (selectedStartDate!.isAfter(selectedEndDate!)) {
        Fluttertoast.showToast(
          msg: "End Date and Hours is greater than Starting Date and Hours!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return false;
      }

      return false;
    }

    return true;
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

  getEmployee() async {
    isLoading.value = true;
    var response = await _connect.getEmployeeNameCall();
    isLoading.value = false;
    if (!response.error!) {
      employeeName.value = response.data!;
      debugPrint("getUser: ${response.toJson()}");
    } else {}
  }

  Future<void> onDutyAdd() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'latitude': currentLatitudeController.value.toString(),
        'longitude': currentLongitudeController.value.toString(),
        'employeeId': AppPreference().getEmpId.toString(),
        'startingDate': startDateAndTimeController.text,
        'endingDate': closeDateAndTimeController.text,
        'remarks': remarksController.text,
        'ondutyStatus': "pending",
      };
      print("generalInsertPayload:$payload");
      var response = await _connect.imgIdeasUpload(ApiUrl.insertOnDuty,
          itemImagePick.value.file , payload, recordFilePath!.value ?? "");
      debugPrint("generalInsertResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        Get.offNamed(AppRoutes.onDutyScreen.toName);
        Get.deleteAll();
      } else
        () {};
    }
  }

  Future<void> updateOnDuty() async {
    if (firstValidation()) {
      Map<String, String> payload = {
        'Id': userDataProvider.getOnDutyEmployeeData!.id.toString(),
        'latitude': currentLatitudeController.value.toString(),
        'longitude': currentLongitudeController.value.toString(),
        'employeeId': AppPreference().getEmpId.toString(),
        'startingDate': startDateAndTimeController.text,
        'endingDate': closeDateAndTimeController.text,
        'remarks': remarksController.text,
        'ondutyStatus': "",
      };

      print('OnDutyUpdateRequest$payload');
      var response = await _connect.imgIdeasUpdate(ApiUrl.updateOnDuty,
          itemImagePick.value.file, payload, recordFilePath!.value ?? "");
      debugPrint("OnDutyUpdateResponse: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.onDutyScreen.toName);
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
    ;
  }

  void setData() {
    GetOnDutyEmployeeIdResponseData data = userDataProvider.getOnDutyEmployeeData!;
    startDateAndTimeController.text = data.startingDate ?? "";
    closeDateAndTimeController.text = data.endingDate ?? "";
    remarksController.text = data.remarks ?? "";

    if(userDataProvider.currentStatus == "Edit"){
      if(data.audioFile != null && !data.audioFile!.isEmpty) {
        isAudio.value = true;
      } else {
        isAudio.value = false;
      }
      if(data.images != null && data.images!.isNotEmpty){
        imagePathFromData.value = "${ApiUrl.baseUrl}ideas/${data.images!}";
        isUpdateImageAvailable.value = true;
      }}
  }
}
