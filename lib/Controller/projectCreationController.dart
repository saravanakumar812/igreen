import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:igreen_flutter/model/GetClientCodeResponseModel.dart';
import 'package:igreen_flutter/model/responseModel/InsertCommonResponse.dart';
import 'package:provider/provider.dart';
import '../UI/ProjectCreation/ProjectCodeDetails.dart';
import '../Utils/image_picker.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/ClientProjectResponse.dart';
import '../model/CreateCodeResponseModel.dart';
import '../model/DistrictResponseModel.dart';
import '../model/StateReponseModel.dart';
import '../model/responseModel/EmployeeNameResponseModel.dart';
import '../model/responseModel/ParticularTaskResponse.dart';
import '../provider/menuProvider.dart';
import 'package:intl/intl.dart';

class ProjectCreationController extends GetxController {
  RxString projectCode = RxString("");
  RxString generalCode = RxString("");
  RxString siteProjectId = RxString("");
  RxString assignProjectId = RxString("");
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxBool isFileSelected = RxBool(false);
  File? brqFile;
  File? tenderFile;
  File? emdFile;
  RxList<GetGeneralCodeClientNameResponseModelData> getClientNameGeneralCode =
      RxList();
  RxList<EmployeeNameResponseData> employeeName = RxList();
  RxList<ClientDepartmentData> fetchData = RxList();
  RxList<StateDepartmentData> getStateData = RxList();
  RxList<DistrictDepartmentData> getDistrictData = RxList();
  RxList<CreatecodeResponse> getCreatecodeData = RxList();
  RxBool rendList = false.obs;
  RxBool tenderType = false.obs;
  List<String> rendDetails = [];
  List<String> tenderTypeList = [];
  RxList<ParticularData> taskData = RxList();
  RxInt taskIdValue = RxInt(0);
  Rx<PickedImage?> item_image = Rx<PickedImage?>(null);
  RxBool ClientDepartment = RxBool(false);
  RxBool StateDepartment = RxBool(false);
  RxBool DistrictDepartment = RxBool(false);
  RxBool CreateCodevalue = RxBool(false);
  RxString depId = RxString('');
  RxBool isImageSelected = false.obs;
  RxBool selectPerson = false.obs;
  RxBool generalEmployee = false.obs;
  RxBool generalClientName = false.obs;

  Future<void> refreshData() async {
    return Future.delayed(Duration(seconds: 0));
  }

  bool selectableDay(DateTime day) {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime dayBeforeYesterday = today.subtract(Duration(days: 2));

    return day.year == today.year &&
        day.month == today.month &&
        (day.day == today.day ||
            day.day == yesterday.day ||
            day.day == dayBeforeYesterday.day);
  }

  TextEditingController openingDateController = TextEditingController();
  TextEditingController closingDateController = TextEditingController();
  TextEditingController staffDetails = TextEditingController();
  TextEditingController teamSelection = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController TeamSelection = TextEditingController();
  TextEditingController DistrictController = TextEditingController();
  TextEditingController createCodeController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController tenderTypeController = TextEditingController();
  TextEditingController TypeController = TextEditingController();
  TextEditingController tenderSpecRemarkController = TextEditingController();
  TextEditingController openingDateRemarkController = TextEditingController();
  TextEditingController closingDateRemarkController = TextEditingController();
  TextEditingController brqRemarkController = TextEditingController();
  TextEditingController emdRemarkController = TextEditingController();
  TextEditingController generalCodeEmployeeName = TextEditingController();
  TextEditingController generalCodeClientName = TextEditingController();
  TextEditingController addGeneralCodeClientName = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getClientData();
      getStateDataApi();
      getEmployee();
      getGeneralCodeClientData();
      isCall = true;
    }
  }

  Future<void> brqPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      brqFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> tenderSpecPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      tenderFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> emdPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      emdFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> openingDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        // selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      openingDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> closingDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        // selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      closingDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  getGeneralCodeClientData() async {
    isLoading.value = true;
    var response = await _connect.getGeneralCodeClientProject();
    if (response.data != null) {
      getClientNameGeneralCode.value = response.data!;
      /* getBalance();*/
      debugPrint("getGeneralCodeClientData: ${response.toJson()}");
    } else {}
  }

  getClientData() async {
    isLoading.value = true;
    var response = await _connect.getClientProject();
    if (response.data != null) {
      fetchData.value = response.data!;
      /* getBalance();*/
      debugPrint("getFetchResponse: ${response.toJson()}");
    } else {}
  }

  getStateDataApi() async {
    isLoading.value = true;
    var response = await _connect.getStateProject();
    if (response.data != null) {
      getStateData.value = response.data!;
      /* getBalance();*/
      debugPrint("getFetchResponse: ${response.toJson()}");
    } else {}
  }

  getDistrictDataApi(String stateName) async {
    Map<String, dynamic> payload = {
      'StateName': stateName,
    };
    isLoading.value = true;
    var response = await _connect.getDistrictData(payload);
    if (response.data != null) {
      getDistrictData.value = response.data!;
      /* getBalance();*/
      debugPrint("getFetchResponse: ${response.toJson()}");
    } else {}
  }

  getCreateCodeApi() async {
    Map<String, dynamic> payload = {
      "EmployeeId": AppPreference().getEmpId.toString(),
      "ClientName": teamSelection.text,
      "ProjectType": typeController.text,
      "ProjectState": TeamSelection.text,
      "ProjectDistrict": DistrictController.text,
      "ProjectArea": areaController.text
    };
    isLoading.value = true;
    var response = await _connect.getCreatecodeData(payload);
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      projectCode.value = response.projectCode!;
      siteProjectId.value = response.siteProjectId!;
      print(response.projectCode!);
      debugPrint("CreateCodeResponse: ${response.toJson()}");
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
    isLoading.value = false;
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

  TenderUpdateApi() async {
    Map<String, String> payload = {
      "EmployeeID": AppPreference().getEmpId.toString(),
      "EmployeeName": AppPreference().getEmpName.toString(),
      "TenderType": tenderTypeController.text,
      "TenderSpecRemarks": tenderSpecRemarkController.text,
      "bqrRemarks": brqRemarkController.text,
      "OpeningDateRemarks": openingDateRemarkController.text,
      "OpeningDate": openingDateController.text,
      "ClosingDateRemarks": closingDateRemarkController.text,
      "ClosingDate": closingDateController.text,
      "SiteProjectId": siteProjectId.value,
      "emdExemptionRemarks": emdRemarkController.text,
      "AssignEmployeeID": assignProjectId.value
    };
    print("tenderUpdatePayload${payload}");

    isLoading.value = true;

    InsertCommonResponse response;

    if (brqFile == null && tenderFile == null && emdFile == null) {
      response =
          await _connect.commonUpload(payload, ApiUrl.updateTenderDetails);
    } else {
      response = await _connect.fileUpload(
          ApiUrl.updateTenderDetails, brqFile!, tenderFile!, emdFile!, payload);
    }

    isLoading.value = false;
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.to(ProjectCodeDetails());
      debugPrint("CreateCodeResponse: ${response.toJson()}");
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
    isLoading.value = false;
  }

  Future<void> addGeneralCodeClientNameCall() async {
    Map<String, dynamic> payload = {
      'ClientName': addGeneralCodeClientName.text,
      "EmployeeId": AppPreference().getEmpId.toString()
    };
    addGeneralCodeClientName.clear();

    print('addGeneralCodeClientNamePayload:$payload');
    var response = await _connect.addGeneralCodeClientNameCall(payload);
    debugPrint("addGeneralCodeClientNameResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.back();
    } else
      () {};
  }

  Future<void> addGeneralCodeCall() async {
    Map<String, dynamic> payload = {
      'ClientName': generalCodeClientName.text,
      "EmployeeId": AppPreference().getEmpId.toString(),
      "Details": detailsController.text,
      "Place": placeController.text
    };


    print('addGeneralCodePayload:$payload');
    var response = await _connect.addGeneralCodeCall(payload);
    debugPrint("addGeneralCodeResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      generalCode.value = response.generalCode!;

    } else
      () {};
  }
}
