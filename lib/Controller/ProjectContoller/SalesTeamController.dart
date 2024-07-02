import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/model/responseModel/SalesTeamList.dart';
import 'package:provider/provider.dart';

import '../../Utils/AppPreference.dart';
import '../../api_connect/api_connect.dart';
import '../../provider/menuProvider.dart';
import '../../routes/app_routes.dart';

class SalesTeamController extends GetxController {
  // RxBool isExpanded = false.obs;
  TextEditingController customerNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController secondaryContactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController customerLocationController = TextEditingController();
  TextEditingController websiteDetailsController = TextEditingController();
  TextEditingController deliveryAddressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController gstNameController = TextEditingController();
  TextEditingController serviceDomainController = TextEditingController();
  TextEditingController approxBudgetController = TextEditingController();
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectDescriptionController = TextEditingController();
  TextEditingController pickUpAddressController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController shipmentAddressController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController itemValueController = TextEditingController();
  TextEditingController rawMaterialController = TextEditingController();
  TextEditingController orderValueController = TextEditingController();
  TextEditingController processController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController managerDetailsController = TextEditingController();
  TextEditingController itemsController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController orderConfirmedDateController = TextEditingController();
  TextEditingController customerRequireDateController = TextEditingController();
  TextEditingController dispatchDateController = TextEditingController();


  final FocusNode mobileNumberFocusNode = FocusNode();
  final FocusNode secondaryContactFocusNode = FocusNode();
  final FocusNode approxBudjetFocusNode = FocusNode();
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxBool rendList = false.obs;
  RxBool managerSelection = false.obs;
  RxBool process = false.obs;
  RxBool pickUp = false.obs;
  RxBool itemList = false.obs;
  RxBool sizeList = false.obs;
  RxBool isSwitched = false.obs;
  RxBool isSwitchedTransport = false.obs;
  bool margin = false;
  bool isEntryField = false;

  void toggleSwitch() {
    isSwitched.value = !isSwitched.value;
  }
  void toggleSwitchTransport() {
    isSwitchedTransport.value = !isSwitchedTransport.value;
  }

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (userDataProvider.getCurrentStatus == "Edit" ||
        userDataProvider.getCurrentStatus == "Re-Use") {
      setData();
    }
  }

  List<String> rendDetails = [];
  List<String> managerDetailsSelection = [];

  List<String> itemDetails = [];
  List<String> sizeDetails = [];
  List<String> processDetails = [];

  bool firstValidation() {
    if (mobileNumberController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please valid mobile number!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (mobileNumberController.text.length < 10) {
      Fluttertoast.showToast(
        msg: "Please Enter 10 Number In Mobile Number!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (secondaryContactController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please valid mobile number!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (secondaryContactController.text.length < 10) {
      Fluttertoast.showToast(
        msg: "Please Enter 10 number  in Secondary Contact Number!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  Future<void> insertSalesTeam() async {
    if (firstValidation()) {
      Map<String, dynamic> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'DepartmentId': "",
        'CustomerName': customerNameController.text,
        'MobileNum': mobileNumberController.text,
        'Email': emailController.text,
        'CompanyName': companyNameController.text,
        'CompanyAddress': companyAddressController.text,
        'GstNum': gstNameController.text,
        'Services': serviceDomainController.text,
        'ProjectBudget': approxBudgetController.text,
        'ProjectName': projectNameController.text,
        'ProjectType': typeController.text,
        'ProjectDescp': userDataProvider.getSalesTeamData,
        'OrderConfirmedDate': orderConfirmedDateController.text,
        'CustomerRequiredDate': customerRequireDateController.text,
        'DispatchCommittedDate': dispatchDateController.text,
        'demant': 'sr',
        'OrderValue': 'tr67',
        'ShipmentAddress': shipmentAddressController.text,
        'TranspotationScope': 'sf',
        'ProjectDescp': projectDescriptionController.text,
        'CommercialUpload': "",
        'TechnicalUpload': "",
        'CustomerLocation': customerLocationController.text,
        'WebsiteDetails': websiteDetailsController.text,
        'DeliveryAddress': deliveryAddressController.text,
        'SecondaryContact': secondaryContactController.text,
        'MaterialFromClient': 'No',
        'PickupAddress': pickUpAddressController.text,
        'process': processController.text
      };
      print("insertSalesTeamRequest:$payload");
      var response = await _connect.insertSalesTeamCall(payload);
      debugPrint("insertSalesTeamRequest: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.salesTeamOne.toName);
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

  Future<void> updateSalesTeam() async {
    Map<String, dynamic> payload = {
      'CustomerName': customerNameController.text,
      'MobileNum': mobileNumberController.text,
      'Email': emailController.text,
      'CompanyName': companyNameController.text,
      'CompanyAddress': companyAddressController.text,
      'GstNum': gstNameController.text,
      'Services': serviceDomainController.text,
      'ProjectBudget': approxBudgetController.text,
      'ProjectName': projectNameController.text,
      'ProjectDescp': '',
      'EmployeeId': AppPreference().getEmpId.toString(),
      'DepartmentId': '',
      'ProjectType': typeController.text,
      'StartDate': startDateController.text,
      'EndDate': endDateController.text,
      'OrderConfirmedDate': orderConfirmedDateController.text,
      'CustomerRequiredDate': customerRequireDateController.text,
      'DispatchCommittedDate': dispatchDateController.text,
      'RawMatirialyGrade': '',
      'OrderValue': '',
      'ShipmentAddress': shipmentAddressController.text,
      'TranspotationScope': '',
      'ProjectId': userDataProvider.getSalesTeamData!.projectId,
      'ProjectCode': "",
      'FactoryProjectId': ""
    };
    print("updateTravelRequest:$payload");

    var response = await _connect.updateSalesTeamCall(payload);
    debugPrint("updateSalesTeamResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.salesTeamOne.toName);
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

  void setData() {
    SalesTeamData data = userDataProvider.getSalesTeamData!;
    customerNameController.text = data.customerName ?? "";
    mobileNumberController.text = data.mobileNum ?? "";
    emailController.text = data.email ?? "";
    secondaryContactController.text = data.secondaryContact.toString() ?? "";
    companyNameController.text = data.companyName ?? "";
    companyAddressController.text = data.companyAddress ?? "";
    gstNameController.text = data.gST ?? "";
    serviceDomainController.text = data.services ?? "";
    approxBudgetController.text = data.projectBudget ?? "";
    projectNameController.text = data.projectName ?? "";
    typeController.text = data.projectType ?? " ";
    startDateController.text = data.startDate ?? "";
    endDateController.text = data.endDate ?? "";
    orderConfirmedDateController.text = data.orderConfirmedDate ?? "";
    customerRequireDateController.text = data.customerRequiredDate ?? "";
    deliveryAddressController.text = data.deliveryAddress ?? "";
    websiteDetailsController.text = data.websiteDetails ?? "";
    customerLocationController.text = data.customerLocation ?? "";
    processController.text = data.process ?? "";
    shipmentAddressController.text = data.shipmentAddress ?? "";
    dispatchDateController.text = data.dispatchCommittedDate ?? "";
    processController.text = data.process ?? "";
    pickUpAddressController.text = data.pickupAddress ?? "";
  }
}
