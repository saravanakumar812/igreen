import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:igreen_flutter/model/GetGreenThankResponseModel.dart';
import 'package:igreen_flutter/model/responseModel/AddEscalationResponse.dart';
import 'package:igreen_flutter/model/responseModel/GetAllAppliedLeaveResponse.dart';
import 'package:igreen_flutter/model/responseModel/GetCityData.dart';
import 'package:igreen_flutter/model/responseModel/GetNotificationResponse.dart';
import 'package:igreen_flutter/model/responseModel/UpdateCommonResponse.dart';
import 'package:image_picker/image_picker.dart';
import '../api_config/ApiUrl.dart';
import '../model/AttendanceResponseModel.dart';
import '../model/CalenderLeaveListResponseModel.dart';
import '../model/CheckListDaysResponseModel.dart';
import '../model/ClientProjectResponse.dart';
import '../model/CompletedProjectResponse.dart';
import '../model/CreateCodeResponseModel.dart';
import '../model/DeductionDropDownResponse.dart';
import '../model/DistrictResponseModel.dart';
import '../model/EscalationRespondRequestModel.dart';
import '../model/FlowOfBillDropDownResponse.dart';
import '../model/GeneralCodeResponse.dart';
import '../model/GetClientCodeResponseModel.dart';
import '../model/GetMaintenanceCheckListResponse.dart';
import '../model/GetOfficeEmployeeResponseModel.dart';
import '../model/GetOnDutyEmployeeIdResponse.dart';
import '../model/GetParticularSiteProjectResponse.dart';
import '../model/GetSiteProjectTenderResponse.dart';
import '../model/GetSupportResponseModel.dart';
import '../model/IdealogyResponseModel.dart';
import '../model/IdeasUserDataResponse.dart';
import '../model/LeaveDynamicResponseModel.dart';
import '../model/LoginResponseModel.dart';
import '../Utils/app_utility.dart';
import '../model/OfficeCategoryResponse.dart';
import '../model/OnDutyRejectedResponseModel.dart';
import '../model/OnDutyResponseModel.dart';
import '../model/OndutyApprovedResponseModel.dart';
import '../model/OndutyPendingResponseModel.dart';
import '../model/ProjectViewResponseModel.dart';
import '../model/PurchaseResponseModel.dart';
import '../model/SiteProjectCodeResponseModel.dart';
import '../model/StateReponseModel.dart';
import '../model/TenderDescriptionDropDownResponse.dart';
import '../model/TenderUnitDropDownResponse.dart';
import '../model/responseModel/AddOwnerResponse.dart';
import '../model/responseModel/AddVendorResponse.dart';
import '../model/responseModel/ApplyResponse.dart';
import '../model/responseModel/AttendanceApprovalResponse.dart';
import '../model/responseModel/AttendanceResponse.dart';
import '../model/responseModel/CategoryList.dart';
import '../model/responseModel/CommercialList.dart';
import '../model/responseModel/EmployeeDetailsResponse.dart';
import '../model/responseModel/EmployeeNameResponseModel.dart';
import '../model/responseModel/EscalationApprovalResponse.dart';
import '../model/responseModel/EscalationPostResponse.dart';
import '../model/responseModel/EventsList.dart';
import '../model/responseModel/FactoryCompletionResponse.dart';
import '../model/responseModel/FactoryDepartmentResponse.dart';
import '../model/responseModel/FactoryEmployeeDataResponse.dart';
import '../model/responseModel/FactoryUpdateResponse.dart';
import '../model/responseModel/FeedbackResponse.dart';
import '../model/responseModel/FetchExpenseCategoryResponse.dart';
import '../model/responseModel/FetchSubcategoryFourResponse.dart';
import '../model/responseModel/FetchSubcategoryThreeResponse.dart';
import '../model/responseModel/FetchSubcategoryTwoResponse.dart';
import '../model/responseModel/FoodSummaryList.dart';
import '../model/responseModel/FuelSubCategoryResponse.dart';
import '../model/responseModel/FundRequestResponse.dart';
import '../model/responseModel/GeneralSummaryList.dart';
import '../model/responseModel/GetAccommodationResponse.dart';
import '../model/responseModel/GetAllFeedbackResponse.dart';
import '../model/responseModel/GetAllUserResponse.dart';
import '../model/responseModel/GetAttendanceListResponse.dart';
import '../model/responseModel/GetBalanceResponse.dart';
import '../model/responseModel/GetCommercialFromTechnicalResponse.dart';
import '../model/responseModel/GetEscalationResponse.dart';
import '../model/responseModel/GetFactoryDepartmentResponse.dart';
import '../model/responseModel/GetFactoryProject.dart';
import '../model/responseModel/GetFactoryProjectReviewResponse.dart';
import '../model/responseModel/GetFuelExpenseResponse.dart';
import '../model/responseModel/GetOverAllExpenseSummaryResponse.dart';
import '../model/responseModel/GetOwnerResponse.dart';
import '../model/responseModel/GetPurchaseResponse.dart';
import '../model/responseModel/GetRentExpenseResponse.dart';
import '../model/responseModel/GetUserLeaveListResponse.dart';
import '../model/responseModel/GetVendorNameResponse.dart';
import '../model/responseModel/InsertCommonResponse.dart';
import '../model/responseModel/InsertFuelExpenseResponse.dart';
import '../model/responseModel/InsertWagesEmployeeResponse.dart';
import '../model/responseModel/ItemListResponse.dart';
import '../model/responseModel/LeaveApproveResponse.dart';
import '../model/responseModel/LeaveRejectResponse.dart';
import '../model/responseModel/MaintenanceSummaryListResponsemodel.dart';
import '../model/responseModel/ManagerApprovalResponse.dart';
import '../model/responseModel/OthersSummaryListResponse.dart';
import '../model/responseModel/OverAllSumOfCategoryAmountResponse.dart';
import '../model/responseModel/ParticularTaskResponse.dart';
import '../model/responseModel/ProjectCodeListResponse.dart';
import '../model/responseModel/PurchaseMaterialNameRespnseModel.dart';
import '../model/responseModel/PurchaseSummaryList.dart';
import '../model/responseModel/PurchaseUnitResponse.dart';
import '../model/responseModel/ReminderList.dart';
import '../model/responseModel/RepairsAndMaintenanceSummaryList.dart';
import '../model/responseModel/SalesTeamList.dart';
import '../model/responseModel/SizeListResponse.dart';
import '../model/responseModel/StatusUpdateResponse.dart';
import '../model/responseModel/SuggestionCommentsModel.dart';
import '../model/responseModel/SupportResponse.dart';
import '../model/responseModel/TechnicalList.dart';
import '../model/responseModel/TransportCustomerNameResponseModel.dart';
import '../model/responseModel/TransportSummaryList.dart';
import '../model/responseModel/TravelSummaryList.dart';
import '../model/responseModel/UpDateFuelExpenseResponse.dart';
import '../model/responseModel/UpdateAccommodationResponse.dart';
import '../model/responseModel/UpdateTaskResponse.dart';
import '../model/responseModel/UpdateWagesEmployeeResponse.dart';
import '../model/responseModel/UtilizationSummaryList.dart';
import '../model/responseModel/WagesSummarylist.dart';
import '../model/responseModel/WailtingForApprovalReviewResponseModel.dart';
import '../model/responseModel/getSubCategoryDropdownMaintenance.dart';
import 'package:http/http.dart' as http;

class ApiConnect extends GetConnect {
  @override
  onInit() {
    super.allowAutoSignedCert = true;
    super.onInit();

    httpClient.addResponseModifier((request, response) {
      debugPrint("------------ AUTH ------------");
      debugPrint(
          "REQUEST METHOD: ${request.method} ; ENDPOINT:  ${request.url}");
      debugPrint("RESPONSE : ${response.bodyString}");
      return response;
    });
  }

  Future<LoginResponseModel> login(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.login, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return LoginResponseModel.fromJson(response.body);
  }

  Future<AttendanceResponseModel> currentStatusCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.currentStatus, formData);
    if (response.body == null) throw Exception('NO Values');
    return AttendanceResponseModel.fromJson(response.body);
  }

  Future<FetchExpenseCategoryResponse> getFetchExpenseCategory() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.fetchExpenseCategory);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return FetchExpenseCategoryResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> commonUpload(
      Map<String, dynamic> payload, String endpoint) async {
    FormData formData = FormData(payload);

    var response = await post(ApiUrl.baseUrl + endpoint, formData);

    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateTravelCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateTravel, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<FuelSubCategoryResponse> fuelSubCategory(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.fuelSubCategory, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FuelSubCategoryResponse.fromJson(response.body);
  }

  Future<ProjectViewResponseModel> projectViewCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.projectViewScreen, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return ProjectViewResponseModel.fromJson(response.body);
  }

  Future<FetchSubcategoryTwoResponse> fetchCategoryTwoCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.fetchCategoryTwo, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FetchSubcategoryTwoResponse.fromJson(response.body);
  }

  Future<FetchSubcategoryThreeResponse> fetchCategoryThreeCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.fetchCategoryThree, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FetchSubcategoryThreeResponse.fromJson(response.body);
  }

  Future<FetchSubcategoryFourResponse> fetchCategoryFourCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.fetchCategoryFour, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FetchSubcategoryFourResponse.fromJson(response.body);
  }

  Future<GetSubCategoryDropdownList> getMaintenanceCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(
        ApiUrl.baseUrl + ApiUrl.getSubCategoryMaintenanceList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetSubCategoryDropdownList.fromJson(response.body);
  }

  Future<CheckListDays> getCheckListCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.checklistDays, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return CheckListDays.fromJson(response.body);
  }

  Future<GetMaintenanceList> getMaintenanceCheckList(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getMaintenanceChecklist, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetMaintenanceList.fromJson(response.body);
  }

  Future<SuggestionCommentsModel> getSuggestionList(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getSuggestionBox, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return SuggestionCommentsModel.fromJson(response.body);
  }

  Future<ProjectCodeListResponse> getProjectListCall() async {
    Map<String, dynamic> payload = {
      "EmployeeId": AppPreference().getEmpId,
    };

    print(payload);

    FormData formData = FormData(payload);

    var response = await post(ApiUrl.baseUrl + ApiUrl.getProjectList, formData);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return ProjectCodeListResponse.fromJson(response.body);
  }

  Future<CategoryList> getCategoryListCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getCategoryList);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return CategoryList.fromJson(response.body);
  }

  Future<InsertFuelExpenseResponse> insertFuelExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertFuel, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertFuelExpenseResponse.fromJson(response.body);
  }

  Future<GetFuelExpenseResponse> getFuelExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getFuelList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetFuelExpenseResponse.fromJson(response.body);
  }

  Future<OverAllSumOfCategoryAmountResponse> getAllExpenseSummary(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getAllExpenseSummary, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return OverAllSumOfCategoryAmountResponse.fromJson(response.body);
  }

  Future<UpDateFuelExpenseResponse> updateFuelExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateFuelList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpDateFuelExpenseResponse.fromJson(response.body);
  }

  Future<GetRentExpenseResponse> getRendExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getRendList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetRentExpenseResponse.fromJson(response.body);
  }

  Future<OfficeEmployeeResponse> getOfficeExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getOfficeList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return OfficeEmployeeResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertRendExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertRend, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> addOverAllSummary(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.updateExpenceInSummary, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertMaintenanceExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.insertMaintenanceExpense, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateMaintenanceExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.updateMaintenanceExpense, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateMaintenanceExpense(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.updateMaintenanceList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertGreenThankCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.insertGreenThank, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateRendExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateRend, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<GetAccommodationResponse> getAccommodationCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getAccommodation, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetAccommodationResponse.fromJson(response.body);
  }

  Future<TravelSummaryList> getTravelExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getTravelList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return TravelSummaryList.fromJson(response.body);
  }

  Future<FoodSummaryList> getFoodExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getFoodList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FoodSummaryList.fromJson(response.body);
  }

  Future<RepairsAndMaintenanceSummaryList> getRepairsAndMaintenanceExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(
        ApiUrl.baseUrl + ApiUrl.getRepairsAndMaintenanceList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return RepairsAndMaintenanceSummaryList.fromJson(response.body);
  }

  Future<GeneralSummaryList> getGeneralExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getGeneralList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GeneralSummaryList.fromJson(response.body);
  }

  Future<WagesSummaryList> getWagesExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getWagesList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return WagesSummaryList.fromJson(response.body);
  }

  Future<GetPurchaseResponse> getPurchaseExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getPurchase, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetPurchaseResponse.fromJson(response.body);
  }

  Future<InsertWagesEmployeeResponse> empInsertCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertWagesEmp, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertWagesEmployeeResponse.fromJson(response.body);
  }

  Future<UpdateWagesEmployeeResponse> empUpdateCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateWagesEmp, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateWagesEmployeeResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertAccommodationCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.insertAccommodation, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UpdateAccommodationResponse> updateAccommodationCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.updateAccommodation, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateAccommodationResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertFoodCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertFood, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateFoodCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateFood, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertTravelCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertTravel, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UtilizationSummaryList> getUtilizationExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getUtilizationList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UtilizationSummaryList.fromJson(response.body);
  }

  Future<OthersSummaryListResponse> getOthersExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getOthersList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return OthersSummaryListResponse.fromJson(response.body);
  }

  Future<TransportSummaryList> getTransportExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getTransportsList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return TransportSummaryList.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertTransportCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.insertTransport, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateTransportCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.updateTransport, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateMaintenanceCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.updateMaintenance, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertMaintenanceCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.insertMaintenance, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertOthersCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertOthers, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateOthersCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateOthers, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateGeneralExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateGeneral, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateOnDutyCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateOnDuty, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateIdeaLogyCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateIdeaLogy, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertGeneralExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertGeneral, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertOnDutyCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertOnDuty, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertIdeaCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addIdea, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateWagesExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateWages, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertWagesExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertWages, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertUtilizationExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.insertUtilization, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateUtilizationExpenseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.updateUtilization, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<GetCityData> getCityCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getCity, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetCityData.fromJson(response.body);
  }

  Future<FundRequestResponse> fundRequestCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.fundRequest, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FundRequestResponse.fromJson(response.body);
  }

  Future<GetNotificationResponse> getNotificationCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getNotification, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetNotificationResponse.fromJson(response.body);
  }

  Future<GetNotificationResponse> deleteNotification(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.deleteNotification, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetNotificationResponse.fromJson(response.body);
  }

  Future<GetVendorNameResponse> getVendorCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getVendorDropdown, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetVendorNameResponse.fromJson(response.body);
  }

  Future<TransportCustomerNameList> getCustomerCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getCustomerDropdown, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return TransportCustomerNameList.fromJson(response.body);
  }

  Future<PurchaseMaterialNameList> getMaterialNameCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getMaterialNameDropdown, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return PurchaseMaterialNameList.fromJson(response.body);
  }

  Future<PurchaseUnitList> getUnitCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    print(ApiUrl.baseUrl + ApiUrl.getUnit);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getUnit, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return PurchaseUnitList.fromJson(response.body);
  }

  Future<MaintenanceSummaryList> getMaintenanceListCall() async {
    var response = await get(
      ApiUrl.baseUrl + ApiUrl.getMaintenance,
    );
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return MaintenanceSummaryList.fromJson(response.body);
  }

  Future<IdeasEmployeeResponse> getIdeaLogyEmployeeCall() async {
    var response = await get(
      ApiUrl.baseUrl + ApiUrl.getIdeaLogy,
    );
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return IdeasEmployeeResponse.fromJson(response.body);
  }

  Future<GetSupportResponse> getSupportCall() async {
    var response = await get(
      ApiUrl.baseUrl + ApiUrl.getSupport,
    );
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetSupportResponse.fromJson(response.body);
  }

  Future<IdeaLogyUserResponse> getUserIdeaLogyCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getEmployeeNameIdeaLogy, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return IdeaLogyUserResponse.fromJson(response.body);
  }

  Future<GetGreenThankResponse> getGreenThanksCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getGreenThanks, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetGreenThankResponse.fromJson(response.body);
  }

  Future<GetOwnerResponse> getOwnerCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getOwnerName, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetOwnerResponse.fromJson(response.body);
  }

  Future<InsertPurchaseData> insertPurchaseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertPurchase, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertPurchaseData.fromJson(response.body);
  }

  Future<AddVendorResponse> addVendorCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addVendor, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return AddVendorResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> addCustomerCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addCustomer, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> addMaterialNameCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addMaterial, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> addGeneralCodeClientNameCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.addGeneralCodeClientName, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<GeneralCodeResponse> addGeneralCodeCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addGeneralCode, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GeneralCodeResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> changePasswordCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.addChangePassword, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> addUnitCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addUnit, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<AddOwnerResponse> addOwnerCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addOwner, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return AddOwnerResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updatePurchaseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updatePurchase, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<StatusUpdateResponse> statusUpdateCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.statusUpdate, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return StatusUpdateResponse.fromJson(response.body);
  }

  Future<StatusUpdateResponse> deleteIdeasCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.deleteIdea, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return StatusUpdateResponse.fromJson(response.body);
  }

  Future<StatusUpdateResponse> deleteOfficeCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.deleteOffice, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return StatusUpdateResponse.fromJson(response.body);
  }

  Future<GetBalanceResponse> getBalanceCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getBalance, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetBalanceResponse.fromJson(response.body);
  }

  Future<GetOverAllExpenseSummaryResponse> getSummaryCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getSummary, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetOverAllExpenseSummaryResponse.fromJson(response.body);
  }

  Future<GetOverAllExpenseSummaryResponse> getProjectGraphData(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getGraphForProject, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetOverAllExpenseSummaryResponse.fromJson(response.body);
  }

  Future<GetOverAllExpenseSummaryResponse> getOverAllSummaryCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getAllDataSummary, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetOverAllExpenseSummaryResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateSalesTeamCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.updateSalesTeam, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateCommercialToTechnicalCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(
        ApiUrl.baseUrl + ApiUrl.updateCommercialToTechnical, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<SalesTeamList> getSalesTeamExpenseCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getSalesTeamList);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return SalesTeamList.fromJson(response.body);
  }

  Future<CommercialList> getCommercialTeamExpenseCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getCommercialList);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return CommercialList.fromJson(response.body);
  }

  Future<TechnicalList> getTechnicalExpenseCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getTechnicalList);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return TechnicalList.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertSalesTeamCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.insertSalesTeam, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<GetAllAppliedLeaveResponse> getAppliedLeaveCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getAppliedLeave);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return GetAllAppliedLeaveResponse.fromJson(response.body);
  }

  Future<LeaveApproveResponse> leaveApproveCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.leaveApprove, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return LeaveApproveResponse.fromJson(response.body);
  }

  Future<LeaveRejectResponse> leaveRejectCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.leaveReject, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return LeaveRejectResponse.fromJson(response.body);
  }

  Future<GetEscalationResponse> getEscalationCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getEscalation);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return GetEscalationResponse.fromJson(response.body);
  }

  Future<EscalationApprovalResponse> escalationApprovalCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.escalationApproval, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return EscalationApprovalResponse.fromJson(response.body);
  }

  Future<GetAllFeedbackResponse> getFeedbackCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getFeedback);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return GetAllFeedbackResponse.fromJson(response.body);
  }

  Future<FeedbackResponse> feedbackCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.feedbackRespond, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FeedbackResponse.fromJson(response.body);
  }

  Future<GetAttendanceListResponse> getAttendanceCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getAttendance);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return GetAttendanceListResponse.fromJson(response.body);
  }

  Future<AttendanceApprovalResponse> attendanceApprovalCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.attendanceApproval, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return AttendanceApprovalResponse.fromJson(response.body);
  }

  Future<GetAllUserResponse> getUserCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getUser);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return GetAllUserResponse.fromJson(response.body);
  }

  Future<EmployeeNameResponseList> getEmployeeNameCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getEmployeeName);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return EmployeeNameResponseList.fromJson(response.body);
  }

  Future<OfficeCategoryResponse> getOfficeCategoryCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getOfficeCategory);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return OfficeCategoryResponse.fromJson(response.body);
  }

  Future<SizeList> getSizeCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getSize);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return SizeList.fromJson(response.body);
  }

  Future<ItemSummaryList> getItemsCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getItems, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return ItemSummaryList.fromJson(response.body);
  }

  Future<SupportResponse> supportCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.support, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return SupportResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateTechnicalToCommercialCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(
        ApiUrl.baseUrl + ApiUrl.updateTechnicalToCommercial, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<ParticularTaskResponse> particularTaskCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.particularTask, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return ParticularTaskResponse.fromJson(response.body);
  }

  Future<UpdateTaskResponse> updateTaskCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateTask, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateTaskResponse.fromJson(response.body);
  }

  Future<EscalationPostResponse> escalationPostCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.escalation, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return EscalationPostResponse.fromJson(response.body);
  }

  Future<EscalationRespondModel> escalationRespondCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.escalationRespond, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return EscalationRespondModel.fromJson(response.body);
  }

  Future<AddEscalationResponse> addEscalationCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addEscalation, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return AddEscalationResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> insertReminderCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.insertReminder, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateReminderCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateReminder, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> addAgreeCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addAgree, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<EventList> getEventCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getEventList);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return EventList.fromJson(response.body);
  }

  Future<ReminderList> getReminderListCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getReminderList, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return ReminderList.fromJson(response.body);
  }

  Future<GetUserLeaveListResponse> getUserLeaveCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getUserLeave, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetUserLeaveListResponse.fromJson(response.body);
  }

  Future<ApplyResponse> applyLeaveCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.applyLeave, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return ApplyResponse.fromJson(response.body);
  }

  Future<GetCommercialFromTechnicalResponse>
      getCommercialFromTechnicalCall() async {
    var response =
        await get(ApiUrl.baseUrl + ApiUrl.getCommercialFromTechnical);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return GetCommercialFromTechnicalResponse.fromJson(response.body);
  }

  Future<AttendanceResponse> attendanceCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.attendance, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return AttendanceResponse.fromJson(response.body);
  }

  Future<GetFactoryDepartmentResponse> getFactoryCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.factory);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return GetFactoryDepartmentResponse.fromJson(response.body);
  }

  Future<GetFactoryProjectResponse> getFactoryProjectCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getFactoryProject);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return GetFactoryProjectResponse.fromJson(response.body);
  }

  Future<FactoryDepartmentResponse> getFactoryDepartmentCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getFactoryDepartment);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return FactoryDepartmentResponse.fromJson(response.body);
  }

  Future<FactoryEmployeeResponse> factoryEmployeeResponseCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.factoryEmployeeResponse, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FactoryEmployeeResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateAssignProjectCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.updateAssignProject, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<UpdateCommonResponse> updateAgreeCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.updateIdeaLogy, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return UpdateCommonResponse.fromJson(response.body);
  }

  Future<EmployeeDetailsResponse> getEmployeeDetailsCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getFactoryEmployeeDetails);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return EmployeeDetailsResponse.fromJson(response.body);
  }

  Future<CompletedProjectResponse> completedProjectCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getCompletedProject, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return CompletedProjectResponse.fromJson(response.body);
  }

  Future<FactoryUpdateResponse> factoryUpdateCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.factoryUpdate, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FactoryUpdateResponse.fromJson(response.body);
  }

  Future<FactoryCompletionResponse> factoryCompletionCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.factoryCompletion, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return FactoryCompletionResponse.fromJson(response.body);
  }

  Future<GetFactoryProjectReviewList> getReviewApproval(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getReviewApproval, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetFactoryProjectReviewList.fromJson(response.body);
  }

  Future<ManagerApprovalResponse> managerApproval(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.managerApproval, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return ManagerApprovalResponse.fromJson(response.body);
  }

  Future<GetOnDutyEmployeeIdResponse> onDutyApproval(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.onDutyApproval, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetOnDutyEmployeeIdResponse.fromJson(response.body);
  }

  Future<WaitingForApprovalList> getReviewWaitingForApproval() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getWaitingForApproval);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return WaitingForApprovalList.fromJson(response.body);
  }

  Future<OnDutyResponseList> getOnDuty() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getOnDuty);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return OnDutyResponseList.fromJson(response.body);
  }

  Future<OnDutyApprovedResponse> getOnDutyApproved() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getOnDutyApproved);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return OnDutyApprovedResponse.fromJson(response.body);
  }

  Future<OnDutyPendingResponse> getOnDutyPending() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getOnDutyPending);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return OnDutyPendingResponse.fromJson(response.body);
  }

  Future<OnDutyRejectedResponse> getOnDutyRejected() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getOnDutyReject);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return OnDutyRejectedResponse.fromJson(response.body);
  }

  Future<LeaveDynamic> getLeaveDynamic() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getLeaveDynamic);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return LeaveDynamic.fromJson(response.body);
  }

  Future<CalenderLeaveList> getLeaveList() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getLeaveList);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return CalenderLeaveList.fromJson(response.body);
  }

  Future<InsertCommonResponse> imgUpload(
      String url,
      XFile? imageFile,
      XFile? startingImageFile,
      XFile? endingImageFile,
      Map<String, String> payload,
      String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (startingImageFile != null) {
      var startImageStream = http.ByteStream(startingImageFile.openRead());
      var startImageLength = await startingImageFile.length();
      var multipartFile = http.MultipartFile(
          'StartingImages', startImageStream, startImageLength,
          filename: startingImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (endingImageFile != null) {
      var endImageStream = http.ByteStream(endingImageFile.openRead());
      var endImageLength = await endingImageFile.length();
      var multipartFile = http.MultipartFile(
          'EndingImages', endImageStream, endImageLength,
          filename: endingImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return InsertCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = InsertCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<InsertCommonResponse> imgTaskUpload(String url, XFile? imageFile,
      Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return InsertCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = InsertCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<InsertCommonResponse> imgTransportUpload(
      String url,
      XFile? dcUploadImageFile,
      XFile? eWayBillImageFile,
      XFile? invoiceBillFile,
      XFile? packingListImageBillFile,
      Map<String, String> payload,
      String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (dcUploadImageFile != null) {
      var imageStream = http.ByteStream(dcUploadImageFile.openRead());
      var imageLength = await dcUploadImageFile.length();
      var multipartFile = http.MultipartFile(
          'DCUploads', imageStream, imageLength,
          filename: dcUploadImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (eWayBillImageFile != null) {
      var startImageStream = http.ByteStream(eWayBillImageFile.openRead());
      var startImageLength = await eWayBillImageFile.length();

      var multipartFile = http.MultipartFile(
          'EWayBill', startImageStream, startImageLength,
          filename: eWayBillImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (invoiceBillFile != null) {
      var endImageStream = http.ByteStream(invoiceBillFile.openRead());
      var endImageLength = await invoiceBillFile.length();
      var multipartFile = http.MultipartFile(
          'InvoiceBill', endImageStream, endImageLength,
          filename: invoiceBillFile.path.split('/').last);
      request.files.add(multipartFile);
    }
    if (packingListImageBillFile != null) {
      var packingImageStream =
          http.ByteStream(packingListImageBillFile.openRead());
      var packingImageLength = await packingListImageBillFile.length();
      var multipartFile = http.MultipartFile(
          'Images', packingImageStream, packingImageLength,
          filename: packingListImageBillFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return InsertCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = InsertCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<InsertCommonResponse> imgAccommodationUpload(String url,
      XFile? imageFile, Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return InsertCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = InsertCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<InsertCommonResponse> imgIdeasUpload(String url, XFile? imageFile,
      Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'VoiceNote', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return InsertCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = InsertCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<InsertCommonResponse> imgOfficeUpload(String url, XFile? imageFile,
      Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return InsertCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = InsertCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<InsertCommonResponse> imgTransportThreeUpload(
      String url,
      XFile? dcUploadImageFile,
      XFile? eWayBillImageFile,
      XFile? invoiceBillFile,
      Map<String, String> payload,
      String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (dcUploadImageFile != null) {
      var imageStream = http.ByteStream(dcUploadImageFile.openRead());
      var imageLength = await dcUploadImageFile.length();
      var multipartFile = http.MultipartFile(
          'DCUploads', imageStream, imageLength,
          filename: dcUploadImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (eWayBillImageFile != null) {
      var startImageStream = http.ByteStream(eWayBillImageFile.openRead());
      var startImageLength = await eWayBillImageFile.length();
      var multipartFile = http.MultipartFile(
          'EWayBill', startImageStream, startImageLength,
          filename: eWayBillImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (invoiceBillFile != null) {
      var endImageStream = http.ByteStream(invoiceBillFile.openRead());
      var endImageLength = await invoiceBillFile.length();
      var multipartFile = http.MultipartFile(
          'InvoiceBill', endImageStream, endImageLength,
          filename: invoiceBillFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return InsertCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = InsertCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<UpDateFuelExpenseResponse> imgUpdate(
      String url,
      XFile? imageFile,
      XFile? startingImageFile,
      XFile? endingImageFile,
      Map<String, String> payload,
      String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (startingImageFile != null) {
      var startImageStream = http.ByteStream(startingImageFile.openRead());
      var startImageLength = await startingImageFile.length();

      var multipartFile = http.MultipartFile(
          'StartingImages', startImageStream, startImageLength,
          filename: startingImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (endingImageFile != null) {
      var endImageStream = http.ByteStream(endingImageFile.openRead());
      var endImageLength = await endingImageFile.length();
      var multipartFile = http.MultipartFile(
          'EndingImages', endImageStream, endImageLength,
          filename: endingImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return UpDateFuelExpenseResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = UpDateFuelExpenseResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<UpdateCommonResponse> imgTaskUpdate(String url, XFile? imageFile,
      Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return UpdateCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = UpdateCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<UpdateCommonResponse> imgTransportUpdate(
      String url,
      XFile? dcUploadImageFile,
      XFile? eWayBillImageFile,
      XFile? invoiceBillFile,
      XFile? packingListImageBillFile,
      Map<String, String> payload,
      String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (dcUploadImageFile != null) {
      var imageStream = http.ByteStream(dcUploadImageFile.openRead());
      var imageLength = await dcUploadImageFile.length();

      var multipartFile = http.MultipartFile(
          'DCUploads', imageStream, imageLength,
          filename: dcUploadImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (eWayBillImageFile != null) {
      var startImageStream = http.ByteStream(eWayBillImageFile.openRead());
      var startImageLength = await eWayBillImageFile.length();
      var multipartFile = http.MultipartFile(
          'EWayBill', startImageStream, startImageLength,
          filename: eWayBillImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (invoiceBillFile != null) {
      var endImageStream = http.ByteStream(invoiceBillFile.openRead());
      var endImageLength = await invoiceBillFile.length();
      var multipartFile = http.MultipartFile(
          'InvoiceBill', endImageStream, endImageLength,
          filename: invoiceBillFile.path.split('/').last);
      request.files.add(multipartFile);
    }
    if (packingListImageBillFile != null) {
      var packingImageStream =
          http.ByteStream(packingListImageBillFile!.openRead());
      var packingImageLength = await packingListImageBillFile.length();
      var multipartFile = http.MultipartFile(
          'Images', packingImageStream, packingImageLength,
          filename: packingListImageBillFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return UpdateCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = UpdateCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<UpdateCommonResponse> imgTransportThreeUpdate(
      String url,
      XFile? dcUploadImageFile,
      XFile? eWayBillImageFile,
      XFile? invoiceBillFile,
      Map<String, String> payload,
      String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (dcUploadImageFile != null) {
      var imageStream = http.ByteStream(dcUploadImageFile!.openRead());
      var imageLength = await dcUploadImageFile.length();
      var multipartFile = http.MultipartFile(
          'DCUploads', imageStream, imageLength,
          filename: dcUploadImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (eWayBillImageFile != null) {
      var startImageStream = http.ByteStream(eWayBillImageFile!.openRead());
      var startImageLength = await eWayBillImageFile.length();
      var multipartFile = http.MultipartFile(
          'EWayBill', startImageStream, startImageLength,
          filename: eWayBillImageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (invoiceBillFile != null) {
      var endImageStream = http.ByteStream(invoiceBillFile!.openRead());
      var endImageLength = await invoiceBillFile.length();
      var multipartFile = http.MultipartFile(
          'InvoiceBill', endImageStream, endImageLength,
          filename: invoiceBillFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return UpdateCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = UpdateCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<UpdateCommonResponse> imgAccommondationUpdate(String url,
      XFile? imageFile, Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'audioUpload', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return UpdateCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = UpdateCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<UpdateCommonResponse> imgIdeasUpdate(String url, XFile? imageFile,
      Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'VoiceNote', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return UpdateCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = UpdateCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<UpdateCommonResponse> imgOfficeUpdate(String url, XFile? imageFile,
      Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return UpdateCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = UpdateCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<UpdateCommonResponse> escalationApproval(
      String url, Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    // if (imageFile != null) {
    //   var imageStream = http.ByteStream(imageFile.openRead());
    //   var imageLength = await imageFile.length();
    //   var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
    //       filename: imageFile.path.split('/').last);
    //   request.files.add(multipartFile);
    // }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return UpdateCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = UpdateCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<InsertCommonResponse> leaveApply(
      String url, Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    // if (imageFile != null) {
    //   var imageStream = http.ByteStream(imageFile.openRead());
    //   var imageLength = await imageFile.length();
    //   var multipartFile = http.MultipartFile('Images', imageStream, imageLength,
    //       filename: imageFile.path.split('/').last);
    //   request.files.add(multipartFile);
    // }

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'voicenote', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return InsertCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = InsertCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<InsertCommonResponse> feedback(
      String url, Map<String, String> payload, String audioFile) async {
    XFile file = XFile(audioFile);

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (audioFile.isNotEmpty) {
      var audioStream = http.ByteStream(file.openRead());
      var audioLength = await file.length();
      var multipartAudio = http.MultipartFile(
          'AudioFile', audioStream, audioLength,
          filename: file.path.split('/').last);
      request.files.add(multipartAudio);
    }

    request.fields.addAll(payload);

    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return InsertCommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = InsertCommonResponse.fromJson(parsedResponse);

    return convertedResponse;
  }

  Future<GetGeneralCodeClientNameResponseModel>
      getGeneralCodeClientProject() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getGeneralCodeClient);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return GetGeneralCodeClientNameResponseModel.fromJson(response.body);
  }

  Future<TenderDescriptionDropDownResponse>
      tenderDescriptionDropdownApiCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.tenderDescriptionDropDown);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return TenderDescriptionDropDownResponse.fromJson(response.body);
  }

  Future<TenderUnitDropdownResponse> tenderUnitDropdownResponseApiCall() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.tenderUnitDropdown);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return TenderUnitDropdownResponse.fromJson(response.body);
  }

  Future<DeductionDropDownResponseModel>
      DeductionDropDownResponseModelApiCall() async {
    var response =
        await get(ApiUrl.baseUrl + ApiUrl.deductionDropDownResponseModel);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return DeductionDropDownResponseModel.fromJson(response.body);
  }
  Future<FlowOfBillDropdownResponse>
  FlowOfBillDropdownResponseApiCall() async {
    var response =
        await get(ApiUrl.baseUrl + ApiUrl.flowOfBillDropdownResponse);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return FlowOfBillDropdownResponse.fromJson(response.body);
  }

  Future<ClientProjectResponse> getClientProject() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getClient);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return ClientProjectResponse.fromJson(response.body);
  }

  Future<SiteProjectCodeResponseModel> siteProjectCode() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.siteProjectCDode);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return SiteProjectCodeResponseModel.fromJson(response.body);
  }

  Future<StateResponseModel> getStateProject() async {
    var response = await get(ApiUrl.baseUrl + ApiUrl.getState);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    return StateResponseModel.fromJson(response.body);
  }

  // Future<DistrictResponseModel> getDistrictData() async {
  //   var response = await get(ApiUrl.baseUrl + ApiUrl.getDistrict);
  //   print("response");
  //   if (response.body == null) throw Exception(AppUtility.connectivityMessage);
  //   print(response.body);
  //   return DistrictResponseModel.fromJson(response.body);
  // }
  Future<DistrictResponseModel> getDistrictData(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getDistrict, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return DistrictResponseModel.fromJson(response.body);
  }

  Future<GetParticularSiteProjectResponse> getParticularSiteApiCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getParticularSiteProjectC, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return GetParticularSiteProjectResponse.fromJson(response.body);
  }
  Future<SiteProjectTenderResponse> getSiteProjectTenderApiCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getSiteProjectTender, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return SiteProjectTenderResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> getParticularSiteTenderApiCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getParticularSiteProjectTender, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return InsertCommonResponse.fromJson(response.body);
  }

  Future<CreatecodeResponse> getCreatecodeData(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.createProjectCode, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return CreatecodeResponse.fromJson(response.body);
  }

  Future<InsertCommonResponse> fileUpload(
    String url,
    File? brqFile,
    File? tenderFile,
    File? emdFile,
    Map<String, String> payload,
  ) async {
    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));

    if (brqFile != null) {
      var imageStream = http.ByteStream(brqFile.openRead());
      var imageLength = await brqFile.length();
      var multipartFile = http.MultipartFile(
          'bqrFile', imageStream, imageLength,
          filename: brqFile.path.split('/').last);
      request.files.add(multipartFile);
    }
    if (tenderFile != null) {
      var imageStream = http.ByteStream(tenderFile.openRead());
      var imageLength = await tenderFile.length();
      var multipartFile = http.MultipartFile(
          'TenderSpecFile', imageStream, imageLength,
          filename: tenderFile.path.split('/').last);
      request.files.add(multipartFile);
    }
    if (emdFile != null) {
      var imageStream = http.ByteStream(emdFile.openRead());
      var imageLength = await emdFile.length();
      var multipartFile = http.MultipartFile(
          'emdExemptionFile', imageStream, imageLength,
          filename: emdFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    request.fields.addAll(payload);
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return InsertCommonResponse();
    }

    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = InsertCommonResponse.fromJson(parsedResponse);
    print("Status_Code ${response.statusCode}");

    return convertedResponse;
  }
}
