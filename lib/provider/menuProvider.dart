import 'dart:core';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:igreen_flutter/model/GetOnDutyEmployeeIdResponse.dart';
import 'package:igreen_flutter/model/IdealogyResponseModel.dart';

import '../api_config/ApiUrl.dart';
import '../model/EscalationRespondRequestModel.dart';
import '../model/GetEmployeeEscalationResponse.dart';
import '../model/GetOfficeEmployeeResponseModel.dart';
import '../model/IdeasUserDataResponse.dart';
import '../model/OnDutyRejectedResponseModel.dart';
import '../model/OnDutyResponseModel.dart';
import '../model/OndutyApprovedResponseModel.dart';
import '../model/OndutyPendingResponseModel.dart';
import '../model/PurchaseResponseModel.dart';
import '../model/SiteProjectCodeResponseModel.dart';
import '../model/responseModel/CommercialFromTechnicalDataResponse.dart';
import '../model/responseModel/CommercialList.dart';
import '../model/responseModel/EmployeeDetailsResponse.dart';
import '../model/responseModel/EscalationPostResponse.dart';
import '../model/responseModel/EventsList.dart';
import '../model/responseModel/FetchExpenseCategoryResponse.dart';
import '../model/responseModel/FoodSummaryList.dart';
import '../model/responseModel/FuelSubCategoryResponse.dart';
import '../model/responseModel/GeneralSummaryList.dart';
import '../model/responseModel/GetAccommodationResponse.dart';
import '../model/responseModel/GetAllAppliedLeaveResponse.dart';
import '../model/responseModel/GetAllFeedbackResponse.dart';
import '../model/responseModel/GetAllUserResponse.dart';
import '../model/responseModel/GetBalanceResponse.dart';
import '../model/responseModel/GetCommercialFromTechnicalResponse.dart';
import '../model/responseModel/GetEscalationResponse.dart';
import '../model/responseModel/GetFactoryProject.dart';
import '../model/responseModel/GetFuelExpenseResponse.dart';
import '../model/responseModel/GetNotificationResponse.dart';
import '../model/responseModel/GetOwnerResponse.dart';
import '../model/responseModel/GetPurchaseResponse.dart';
import '../model/responseModel/GetRentExpenseResponse.dart';
import '../model/responseModel/GetUserLeaveListResponse.dart';
import '../model/responseModel/GetVendorNameResponse.dart';
import '../model/responseModel/MaintenanceSummaryListResponsemodel.dart';
import '../model/responseModel/OthersSummaryListResponse.dart';
import '../model/responseModel/ParticularTaskResponse.dart';
import '../model/responseModel/PurchaseMaterialNameRespnseModel.dart';
import '../model/responseModel/ReminderList.dart';
import '../model/responseModel/RepairsAndMaintenanceSummaryList.dart';
import '../model/responseModel/SalesTeamList.dart';
import '../model/responseModel/TechnicalList.dart';
import '../model/responseModel/TransportSummaryList.dart';
import '../model/responseModel/TravelSummaryList.dart';
import '../model/responseModel/UtilizationSummaryList.dart';
import '../model/responseModel/WagesSummarylist.dart';
import '../model/responseModel/WailtingForApprovalReviewResponseModel.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
class menuDataProvider extends ChangeNotifier {

  final Record _record = Record();
  bool _isRecording = false;
  String _afterRecordingFilePath = '';

  bool get isRecording => _isRecording;
  String get recordedFilePath => _afterRecordingFilePath;
  final justAudioPlayer = AudioPlayer();
  double currAudioPlaying = 0.0;
  bool _isSongPlaying = false;
  String _audioFilePath = '';
  bool get isSongPlaying => _isSongPlaying;


  String get currSongPath => _audioFilePath;

  int? expenseId;
  int? employeeId;

  int? get getExpenseId => expenseId;
  int? subOneCategoryId;
  int? get getSubOneCategoryId => subOneCategoryId;
  int? subTwoCategoryId;

  FuelSubOneData? fuelSubOneData;
  FuelSubOneData? get getFuelOneExpenseData => fuelSubOneData;


  FuelExpenseData? fuelExpenseData;
  FuelExpenseData? get getFuelExpenseData => fuelExpenseData;
  int? get getSubTwoCategoryId => subTwoCategoryId;


  String? projectCode;

  String? get getProjectCode => projectCode;

  String? subCategoryName;
  String? get getFuelTypes => subCategoryName;



  String? date;
  String? get getDate => date;

  String? currentStatus;
  String? get getCurrentStatus => currentStatus;


  GetRentData? rentData;

  GetRentData? get getRentData => rentData;

  MaintenanceSummaryData?   maintenanceSummaryData;
  MaintenanceSummaryData? get getMaintenanceSummaryData => maintenanceSummaryData;

  GetAccommodationData? accommodationData;

  GetAccommodationData? get getAccommodationData => accommodationData;
  FoodData? foodValues;
  GeneralData? generalValues;
  UtilizationData? utilizationValues;
  WagesData? wagesValues;
  TravelData? travelValues;
  FoodData? get getFoodData => foodValues;
  TransportData? transportValues;

  TransportData? get getTransportData => transportValues;

  RepairsAndMaintenanceData? repairsValues;


  RepairsAndMaintenanceData? get getRepairsAndMaintenanceData => repairsValues;
  OthersData? otherValues;

  OthersData? get getOthersData => otherValues;

  GeneralData? get getGeneralData => generalValues;

  TravelData? get getTravelData => travelValues;

  UtilizationData? get getUtilizationData => utilizationValues;

  WagesData? get getWagesData => wagesValues;
  SalesTeamData? salesTeamValues;
  CommercialData? commercialValues;

  CommercialData? get getCommercialData => commercialValues;

  SalesTeamData? get getSalesTeamData => salesTeamValues;

  AppliedLeaveData? leaveDataValues;

  AppliedLeaveData? get getLeaveDataValues => leaveDataValues;

  EscalationData? escalationValues;

  EscalationData? get getEscalationValues => escalationValues;

  GetEmployeeEscalationModelData? escalationEmployeeValues;

  GetEmployeeEscalationModelData? get getEscalationEmployeeValues => escalationEmployeeValues;

  EscalationRespondData? escalationResponseValues;

  EscalationRespondData? get getEscalationResponseValues => escalationResponseValues;

  EscalationValues? escalationListValues;

  EscalationValues? get getEscalationListValues => escalationListValues;

  FeedbackData? feedbackValues;

  FeedbackData? get getFeedbackValues => feedbackValues;
  GetUserData? userValues;

  GetUserData? get getUserValues => userValues;

  GetCommercialFromTechnicalResponseData? commercialFromTechnicalResponseData;

  GetCommercialFromTechnicalResponseData?
      get getCommercialFromTechnicalResponseData =>
          commercialFromTechnicalResponseData;

  GetFactoryProjectData? factoryProjectData;

  GetFactoryProjectData? get getFactoryProjectData => factoryProjectData;
  EmployeeDetailsData? getEmployeeDetailsDataValues;

  EmployeeDetailsData? get getEmployeeDetailsData =>
      getEmployeeDetailsDataValues;

  UserleaveData? leaveData;

  UserleaveData? get getLeaveData => leaveData;
  int? attendanceEmpId;
  int? get getAttendanceEmpId => attendanceEmpId;

  ReviewApprovalData? reviewApprovalValues;
  ReviewApprovalData? get getApprovalData => reviewApprovalValues;

  GetPurchaseData? getPurchaseDataValues;
  GetPurchaseData? get getPurchaseData => getPurchaseDataValues;

  GetVendorData? getVendorDataValues;
  GetVendorData? get getVendorData => getVendorDataValues;

  GetOwnerData? getOwnerDataValues;
  GetOwnerData? get getOwnerData => getOwnerDataValues;

  String? getInsertPurchaseDataValues;
  String? get getInsertPurchaseData => getInsertPurchaseDataValues;
  WagesEmployee? wagesEmployeeValues;
  WagesEmployee? get getWagesEmployee => wagesEmployeeValues;

  IdeaLogyUserResponseData? ideaLogyValues;
  IdeaLogyUserResponseData? get getIdeaLogyUser => ideaLogyValues;


  OfficeEmployeeResponseData? officeValues;
  OfficeEmployeeResponseData? get getOfficeEmployee => officeValues;


  PurchaseMaterialNameData? purchaseMaterialNameValues;
  PurchaseMaterialNameData? get getPurchaseMaterialNameData => purchaseMaterialNameValues;


  OnDutyResponseData? onDutyValues;
  OnDutyResponseData? get getOnDutyData => onDutyValues;

  IdeasEmployeeResponseData? ideaLogyEmployee;
  IdeasEmployeeResponseData? get getIdeaLogyEmployeeData => ideaLogyEmployee;


  GetOnDutyEmployeeIdResponseData? onDutyEmployeesValues;
  GetOnDutyEmployeeIdResponseData? get getOnDutyEmployeeData => onDutyEmployeesValues;

  OnDutyApprovedResponseData? onDutyApprovedValues;
  OnDutyApprovedResponseData? get getOnDutyApprovedData => onDutyApprovedValues;

  OnDutyRejectedResponseData? onDutyRejectValues;
  OnDutyRejectedResponseData? get getOnDutyRejectData => onDutyRejectValues;

  EventData? eventValues;
  EventData? get getEventData =>eventValues;

  ReminderData? reminderData;
  ReminderData? get getReminderData => reminderData;
  ParticularData? taskViewData;
  ParticularData? get getTaskViewData => taskViewData;
  OnDutyPendingResponseData? ondDutyPendingData;
  OnDutyPendingResponseData? get getOndDutyPendingData => ondDutyPendingData;


  TechnicalData? technicalData;
  TechnicalData? get getTechnicalDataData => technicalData;

  Data? expensesData;
  Data? get getExpensesData => expensesData;

  FundData? fundData;
  FundData? get getFundData => fundData;


  DataBalance? balanceData;
  DataBalance? get getBalanceDataData => balanceData;

  SiteProjectCodeResponseModelData? siteProjectCode;
  SiteProjectCodeResponseModelData? get getSiteProjectCode => siteProjectCode;


  void setBalanceData(DataBalance? data) {
    balanceData = data;
    notifyListeners();
  }
  void setSiteProjectCodeData(SiteProjectCodeResponseModelData? data) {
    siteProjectCode = data;
    notifyListeners();
  }
  void setExpenseData(Data? data) {
    expensesData = data;
    notifyListeners();
  }
  void setFundData(FundData? data) {
    fundData = data;
    notifyListeners();
  }
  void setPurchaseMaterialNameEmployee(PurchaseMaterialNameData? data) {
    purchaseMaterialNameValues = data;
    notifyListeners();
  }
  void setTechnicalData(TechnicalData? data) {
    technicalData = data;
    notifyListeners();
  }
void setTaskView(ParticularData? data) {
  taskViewData = data;
    notifyListeners();
  }

  void setWagesEmployee(WagesEmployee? data) {
    wagesEmployeeValues = data;
    notifyListeners();

    }

    void setOfficeEmployee(OfficeEmployeeResponseData? data) {
    officeValues = data;
    notifyListeners();

    }

    void setEvent(EventData? data) {
      eventValues = data;
    notifyListeners();

    }void setOnDutyPending(OnDutyPendingResponseData? data) {
    ondDutyPendingData = data;
    notifyListeners();

    }
    void setReminder(ReminderData? data) {
       reminderData = data;
    notifyListeners();

    }

    void setOnDuty(OnDutyResponseData? data) {
    onDutyValues = data;
    notifyListeners();
    }
    void setOnDutyEmployee(GetOnDutyEmployeeIdResponseData? data) {
      onDutyEmployeesValues = data;
    notifyListeners();

    }
    void setOnDutyApproved(OnDutyApprovedResponseData? data) {
      onDutyApprovedValues = data;
    notifyListeners();

    }
    void setOnDutyRejected(OnDutyRejectedResponseData? data) {
      onDutyRejectValues = data;
    notifyListeners();
    }

    void setUserIdeaLogy(IdeaLogyUserResponseData? data) {
      ideaLogyValues = data;
      notifyListeners();
    }
    void setEmployeeIdeaLogy(IdeasEmployeeResponseData? data) {
      ideaLogyEmployee = data;
      notifyListeners();
    }
 void setGetEmployeeEscalationModelData(GetEmployeeEscalationModelData? data) {
   escalationEmployeeValues = data;
    notifyListeners();
    }


  void setInsertPurchaseData(String? data) {
    getInsertPurchaseDataValues = data;
    notifyListeners();
  }

  void setPurchaseData(GetPurchaseData? data) {
    getPurchaseDataValues = data;
    notifyListeners();
  }

  void setOwnerData(GetOwnerData? data) {
    getOwnerDataValues = data;
    notifyListeners();
  }

  void setVendorData(GetVendorData? data) {
    getVendorDataValues = data;
    notifyListeners();
  }
  void setApprovalData(ReviewApprovalData? data) {
    reviewApprovalValues = data;
    notifyListeners();
  }

  void setAttendanceEmpIdData(int? data) {
    attendanceEmpId = data;
    notifyListeners();
  }

  void setLeaveData(UserleaveData? data) {
    leaveData = data;
    notifyListeners();
  }

  void setEmployeeDetailsData(EmployeeDetailsData? data) {
    getEmployeeDetailsDataValues = data;
    notifyListeners();
  }

  void setFactoryProjectData(GetFactoryProjectData? data) {
    factoryProjectData = data;
    notifyListeners();
  }

  void setUserData(GetUserData? data) {
    userValues = data;
    notifyListeners();
  }

  void setCommercialFromTechnicalResponseData(
      GetCommercialFromTechnicalResponseData? data) {
    commercialFromTechnicalResponseData = data;
    notifyListeners();
  }

  void setFeedbackValues(FeedbackData? data) {
    feedbackValues = data;
    notifyListeners();
  }

  void setLeaveDataValues(AppliedLeaveData? data) {
    leaveDataValues = data;
    notifyListeners();
  }

  void setEscalationValues(EscalationData? data) {
    escalationValues = data;
    notifyListeners();
  }
  void setEscalationRespondValues(EscalationRespondData? data) {
    escalationResponseValues = data;
    notifyListeners();
  }
  void setEscalationListValues(EscalationValues? data) {
    escalationListValues = data;
    notifyListeners();
  }

  void setOthersData(OthersData? data) {
    otherValues = data;
    notifyListeners();
  }

  void setFoodExpenseData(FoodData? data) {
    foodValues = data;
    notifyListeners();
  }

  void setAccommodationData(GetAccommodationData? data) {
    accommodationData = data;
    notifyListeners();
  }

  void setExpenseId(int? data) {
    expenseId = data;
    notifyListeners();
  }

  void setFuelExpenseData(FuelExpenseData? data) {
    fuelExpenseData = data;
    notifyListeners();
  }

  void setFuelOneExpenseData(FuelSubOneData? data) {
    fuelSubOneData = data;
    notifyListeners();
  }
  void setTransportExpenseData(TransportData? data) {
    transportValues = data;
    notifyListeners();
  }

  void setRepairsAndMaintenanceData(RepairsAndMaintenanceData? data) {
    repairsValues = data;
    notifyListeners();
  }

  void setRendData(GetRentData? data) {
    rentData = data;
    notifyListeners();
  }
  void setMaintenanceData(MaintenanceSummaryData? data) {
    maintenanceSummaryData = data;
    notifyListeners();
  }
  void setSubOneCategoryId(int? data) {
    subOneCategoryId = data;
    notifyListeners();
  }

  void setSubTwoCategoryId(int? data) {
    subTwoCategoryId = data;
    notifyListeners();
  }

  void setWagesExpenseData(WagesData? data) {
    wagesValues = data;
    notifyListeners();
  }

  void setProjectCode(String? data) {
    projectCode = data;
    notifyListeners();
  }

  void setFuelTypes(String? data) {
    subCategoryName = data;
    notifyListeners();
  }

  void setDate(String? data) {
    date = data;
    notifyListeners();
  }

  void setCurrentStatus(String? data) {
    currentStatus = data;
    notifyListeners();
  }

  void setGeneralExpenseData(GeneralData? data) {
    generalValues = data;
    notifyListeners();
  }

  void setUtilizationExpenseData(UtilizationData? data) {
    utilizationValues = data;
    notifyListeners();
  }

  void setTravelExpenseData(TravelData? data) {
    travelValues = data;
    notifyListeners();
  }

  void setSalesTeamExpenseData(SalesTeamData? data) {
    salesTeamValues = data;
    notifyListeners();
  }

  void setCommercialExpenseData(CommercialData? data) {
    commercialValues = data;
    notifyListeners();
  }
  clearOldData(){
    _afterRecordingFilePath = '';
    notifyListeners();
  }




  setAudioFilePath(String filePath) {
    _audioFilePath = filePath;
    notifyListeners();
  }

  clearCurrAudioPath() {
    _audioFilePath = '';
    notifyListeners();
  }

  playAudio(File incomingAudioFile, {bool update = true}) async {
    try {
      justAudioPlayer.positionStream.listen((event) {
        currAudioPlaying = event.inMicroseconds.ceilToDouble();
        if (update) notifyListeners();
      });

      justAudioPlayer.playerStateStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          justAudioPlayer.stop();
          reset();
        }
      });
     if (getCurrentStatus == "Edit" ||
        getCurrentStatus == "Re-Use") {
       justAudioPlayer.setUrl("${ApiUrl.baseUrl}ideas/${
        getOnDutyEmployeeData!.audioFile}");
       justAudioPlayer.play();
    }
      if (_audioFilePath != incomingAudioFile.path) {
        setAudioFilePath(incomingAudioFile.path);

        await justAudioPlayer.setFilePath(incomingAudioFile.path);
        updateSongPlayingStatus(true);
        await justAudioPlayer.play();
      }

      if (justAudioPlayer.processingState == ProcessingState.idle) {
        await justAudioPlayer.setFilePath(incomingAudioFile.path);
        updateSongPlayingStatus(true);

        await justAudioPlayer.play();
      } else if (justAudioPlayer.playing) {
        updateSongPlayingStatus(false);

        await justAudioPlayer.pause();
      } else if (justAudioPlayer.processingState == ProcessingState.ready) {
        updateSongPlayingStatus(true);

        await justAudioPlayer.play();
      } else if (justAudioPlayer.processingState ==
          ProcessingState.completed) {
        reset();
      }
    } catch (e) {
      print('Error in playaudio: $e');
    }
  }

  void reset() {
    currAudioPlaying = 0.0;
    notifyListeners();

    updateSongPlayingStatus(false);
  }

  updateSongPlayingStatus(bool update) {
    _isSongPlaying = update;
    notifyListeners();
  }

  get currLoadingStatus {
    final _currTime = (currAudioPlaying /
        (justAudioPlayer.duration?.inMicroseconds.ceilToDouble() ?? 1.0));

    return _currTime > 1.0 ? 1.0 : _currTime;
  }

}
