import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../Utils/image_picker.dart';
import '../api_connect/api_connect.dart';
import '../model/DeductionDropDownResponse.dart';
import '../model/DistrictResponseModel.dart';
import '../model/FlowOfBillDropDownResponse.dart';
import '../model/GetParticularSiteProjectResponse.dart';
import '../model/GetSiteProjectTenderResponse.dart';
import '../model/TenderDescriptionDropDownResponse.dart';
import '../model/TenderUnitDropDownResponse.dart';
import '../model/responseModel/EmployeeNameResponseModel.dart';
import '../model/responseModel/ParticularTaskResponse.dart';
import '../provider/menuProvider.dart';
import 'package:intl/intl.dart';

class UpdateSiteProjectsController extends GetxController {
  RxString projectCode = RxString("");
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxBool tenderLostList = RxBool(false);
  RxBool qualifiedTender = RxBool(false);
  RxList<ParticularData> taskData = RxList();
  RxInt taskIdValue = RxInt(0);
  List<String> tenderLostListDetails = [];
  List<String> qualifiedTenderDetails = [];
  List<String> subContractListDetails = [];
  List<String> ownMachineOrSubContractListDetails = [];
  Rx<PickedImage?> item_image = Rx<PickedImage?>(null);
  RxBool isImageSelected = false.obs;
  RxBool tenderDetails = RxBool(false);
  RxBool tenderDescription = RxBool(false);
  RxBool tenderUnit = RxBool(false);
  RxBool selectPerson = RxBool(false);
  RxBool subContractList = RxBool(false);
  RxBool subContractYes = RxBool(false);
  RxBool ownMachineOrSubContractList = RxBool(false);
  RxBool flowOfBillsList = RxBool(false);
  RxBool deductionTypeList = RxBool(false);
  RxList<EmployeeNameResponseData> employeeName = RxList();
  RxList<GetParticularSiteProjectResponseData> getParticularSiteProjectData = RxList();
  RxList<SiteProjectTenderResponseData> getSiteProjectTenderData = RxList();
  RxList<TenderDescriptionDropDownResponseData>
      tenderDescriptionDropDownResponseData = RxList();
  RxList<TenderUnitDropdownResponseData> tenderUnitDropdownResponse = RxList();
  RxList<DeductionDropDownResponseModelData> deductionDropDownResponseModel =
      RxList();
  RxList<FlowOfBillDropdownResponseData> flowOfBillDropdownResponse = RxList();
  File? brqFile;
  File? tenderFile;
  File? emdFile;
  File? billDeductionFile;
  File? boqFile;
  File? projectDetailsFile;
  File? workOrderFile;
  File? agreementFile;
  File? budgetFile;
  File? billingFile;
  File? emdRetentionFile;
  File? sdRetentionFile;
  File? otherRetentionFile;
  RxBool isFileSelected = RxBool(false);

  TextEditingController clientNameController = TextEditingController();
  TextEditingController projectTypeController = TextEditingController();
  TextEditingController monthYearController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController lastUpdateDateController = TextEditingController();
  TextEditingController tenderTypeQualifiedController = TextEditingController();
  TextEditingController tenderTypeController = TextEditingController();
  TextEditingController tenderRemarksController = TextEditingController();
  TextEditingController tenderLostDropDownController = TextEditingController();
  TextEditingController tenderDescriptionController = TextEditingController();
  TextEditingController tenderUnitController = TextEditingController();
  TextEditingController tenderAmountController = TextEditingController();
  TextEditingController competitorNameController = TextEditingController();
  TextEditingController bqoRemarksController = TextEditingController();
  TextEditingController projectDetailsRemarksController = TextEditingController();
  TextEditingController quoteAmountController = TextEditingController();
  TextEditingController billDeductionController = TextEditingController();
  TextEditingController openingDateController = TextEditingController();
  TextEditingController closingDateController = TextEditingController();
  TextEditingController tenderSpecController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController workOrderRemarksController = TextEditingController();
  TextEditingController profileDrawingRemarksController =
      TextEditingController();
  TextEditingController profileDrawingController = TextEditingController();
  TextEditingController agreementRemarksController = TextEditingController();
  TextEditingController budgetRemarksController = TextEditingController();
  TextEditingController ourSpaceRemarksController = TextEditingController();
  TextEditingController othersController = TextEditingController();
  TextEditingController ownMachineOrSubContactRemarksController =
      TextEditingController();
  TextEditingController ownMachineOrSubContactController =
      TextEditingController();
  TextEditingController billingDetailsRemarksController = TextEditingController();
  TextEditingController remarksFlowOfBillsController = TextEditingController();
  TextEditingController flowOfBillsController = TextEditingController();
  TextEditingController paymentReceivedRemarksController = TextEditingController();
  TextEditingController paymentReceivedController = TextEditingController();
  TextEditingController deductionTypeController = TextEditingController();
  TextEditingController deductionAmountController = TextEditingController();
  TextEditingController emdRetentionRemarksController = TextEditingController();
  TextEditingController emdRetentionAmountController = TextEditingController();
  TextEditingController emdRetentionReceivableDataDateController = TextEditingController();
  TextEditingController sdRetentionRemarksController = TextEditingController();
  TextEditingController sdRetentionAmountController = TextEditingController();
  TextEditingController sdRetentionReceivableDataDateController = TextEditingController();
  TextEditingController othersRetentionRemarksController = TextEditingController();
  TextEditingController othersRetentionAmountController = TextEditingController();
  TextEditingController othersRetentionReceivableDataDateController = TextEditingController();
  TextEditingController subContractController = TextEditingController();
  TextEditingController subContractNameRemarksController = TextEditingController();
  TextEditingController sunContractNameController = TextEditingController();
  TextEditingController subContractOrderRemarkController = TextEditingController();
  TextEditingController subContractOrderController = TextEditingController();
  TextEditingController scopeOfWorkSubContractOrderRemarkController = TextEditingController();
  TextEditingController scopeOfWorkSubContractOrderController = TextEditingController();

  Future<void> refreshData() async {
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      getParticularSiteProjectApi();
      tenderDescriptionDropDownCall();
      tenderUnitDropdownResponseCall();
      deductionDropDownResponseModelCall();
      flowOfBillDropdownResponseCall();
      getEmployee();
      getSiteProjectTenderApi();
      isCall = true;
    }
  }

  tenderDescriptionDropDownCall() async {
    isLoading.value = true;
    var response = await _connect.tenderDescriptionDropdownApiCall();
    debugPrint("tenderDescriptionDropDownResponseData: ${response.toJson()}");
    if (response.data != null) {
      tenderDescriptionDropDownResponseData.value = response.data!;
      /* getBalance();*/
      debugPrint("tenderDescriptionDropDownResponseData: ${response.toJson()}");
    } else {}
  }

  tenderUnitDropdownResponseCall() async {
    isLoading.value = true;
    var response = await _connect.tenderUnitDropdownResponseApiCall();
    debugPrint("tenderUnitDropdownResponse: ${response.toJson()}");
    if (response.data != null) {
      tenderUnitDropdownResponse.value = response.data!;
      /* getBalance();*/
      debugPrint("tenderUnitDropdownResponse: ${response.toJson()}");
    } else {}
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
  deductionDropDownResponseModelCall() async {
    isLoading.value = true;
    var response = await _connect.DeductionDropDownResponseModelApiCall();
    debugPrint("DeductionDropDownResponseModel: ${response.toJson()}");
    if (response.data != null) {
      deductionDropDownResponseModel.value = response.data!;
      /* getBalance();*/
      // debugPrint("tenderUnitDropdownResponse: ${response.toJson()}");
    } else {}
  }

  flowOfBillDropdownResponseCall() async {
    isLoading.value = true;
    var response = await _connect.FlowOfBillDropdownResponseApiCall();
    debugPrint("FlowOfBillDropdownResponseApiCall: ${response.toJson()}");
    if (response.data != null) {
      flowOfBillDropdownResponse.value = response.data!;
      /* getBalance();*/
      // debugPrint("tenderUnitDropdownResponse: ${response.toJson()}");
    } else {}
  }

  getParticularSiteProjectApi() async {
    Map<String, dynamic> payload = {
      'SiteProjectId':
          userDataProvider.getSiteProjectCode!.siteProjectId.toString(),
    };
    print("getParticularSiteProjectRequestPayLoad${payload}");
    isLoading.value = true;
    var response = await _connect.getParticularSiteApiCall(payload);
    if (!response.error!) {
      getParticularSiteProjectData.value = response.data!;
      clientNameController.text = response.data![0].clientName.toString();
      projectTypeController.text = response.data![0].projectType.toString();
      monthYearController.text = response.data![0].monthYear.toString();
      serialNumberController.text = response.data![0].serialNum.toString();
      stateController.text = response.data![0].projectState.toString();
      districtController.text = response.data![0].projectDistrict.toString();
      areaController.text = response.data![0].projectArea.toString();
      employeeNameController.text =
          response.data![0].lastUpdatedEmployeeName.toString();
      employeeIdController.text =
          response.data![0].lastUpdatedEmployeeID.toString();
      lastUpdateDateController.text =
          response.data![0].lastUpdatedDate.toString();
      tenderTypeController.text = response.data![0].tenderType.toString();
      tenderAmountController.text = response.data![0].tenderAmount.toString();
      projectCode.value = response.data![0].projectCode.toString();
      debugPrint("getParticularSiteProjectResponse: ${response.toJson()}");
    } else {}
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

  Future<void> BillDeductionFilePickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      billDeductionFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> BOQPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      boqFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> ProjectDetailsPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      projectDetailsFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> WorKOrderPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      workOrderFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> AgreementPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      agreementFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> BudgetPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      budgetFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> BillingPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      billingFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> EmdRetentionPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      emdRetentionFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> SdRetentionPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      sdRetentionFile = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }
  Future<void> OtherRetentionPickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      otherRetentionFile = File(result.files.single.path!);
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


  Future<void> emdRetentionDate(BuildContext context) async {
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
      emdRetentionReceivableDataDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> sdRetentionDate(BuildContext context) async {
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
      sdRetentionReceivableDataDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }


  Future<void> othersRetentionDate(BuildContext context) async {
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
      othersRetentionReceivableDataDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }



  }

  getParticularSiteProjectTenderApi() async {
    Map<String, dynamic> payload = {
      'siteProjectId':
      userDataProvider.getSiteProjectCode!.siteProjectId.toString(),
    "descriptions":tenderDescriptionController.text,
    "unit":tenderUnitController.text,
    "ratePerUnit":rateController.text,
    "amount":amountController.text,
      "siteProjectsQty":quantityController.text
    };
    print("getParticularSiteProjectRequestPayLoad${payload}");
    isLoading.value = true;
    var response = await _connect.getParticularSiteTenderApiCall(payload);
    if (!response.error!) {
      debugPrint("getParticularSiteProjectResponse: ${response.toJson()}");
    } else {}
  }
  getSiteProjectTenderApi() async {
    Map<String, dynamic> payload = {
      'SiteProjectId': "9"
     //userDataProvider.getSiteProjectCode!.siteProjectId.toString(),
    };
    print("getSiteProjectTenderDataRequestPayLoad${payload}");
    isLoading.value = true;
    var response = await _connect.getSiteProjectTenderApiCall(payload);
    if (!response.error!) {
      getSiteProjectTenderData.value = response.data!;

      debugPrint("getSiteProjectTenderDataResponse: ${response.toJson()}");
    } else {}
  }
}
