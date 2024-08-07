class ApiUrl {

  static const bool isProductionUrl = false;
  static const String appVersion = "1.6";

  static const String baseUrl = isProductionUrl
      ? "https://igreentechnologies.in/cmsapi/production/"
      : "https://igreentechnologies.in/cmsapi/igreen_dev/";
      // : "https://mdqualityapps.in/API/igreen_cms/development/";

  static String login = 'login';
  static String fetchExpenseCategory = "fetch_expense_category";
  static const String currentStatus = 'attendanceEmployeeId';
  static String fuelSubCategory = "fetch_sub1_category";
  static String fetchCategoryTwo = "fetch_sub2_category";
  static String getSubCategoryMaintenanceList = "getSubCategoryDropdown";
  static String fetchCategoryThree = "fetch_sub3_category";
  static String fetchCategoryFour = "fetch_sub4_category";
  static String getProjectList = "getEmployeeProjectCode";
  static String getCategoryList = "fetch_expense_category";
  static String insertFuel = "insertFuelExpense";
  static String checklistDays = "getMaintenanceDays";
  static String getMaintenanceChecklist = "getMaintenanceList";
  static String getFuelList = "getFuelExpense";
  static String updateFuelList = "updateFuleExpense";
  static String getRendList = "getRentedExpense";
  static String getAllDataSummary = "getAllDataSummary";
  static String getSuggestionBox = "getSuggestionBox";
  static String getOfficeList = "getEmployeeOfficeExpense";
  static String insertRend = "insertRentedExpense";
  static String updateExpenceInSummary = "UpdateOverallExpenseStatus";
  static String insertMaintenanceExpense = "insertMaintenance";
  static String updateMaintenanceExpense = "updateMaintenanceList";
  static String updateMaintenanceList = "updateMaintenance";
  static String insertGreenThank = "insertGreenThanks";
  static String updateRend = "updateRentedExpense";
  static String getAccommodation = "getAccommodationExpense";
  static String insertAccommodation = "insertAccommodationExpense";
  static String updateAccommodation = "updateAccommodationExpense";
  static String getTravelList = "getTravelExpense";
  static String getFoodList = "getFoodExpense";
  static String getRepairsAndMaintenanceList = "getRepairsMaintenanceExpense";
  static String getGeneralList = "getGeneralExpense";
  static String getWagesList = "getWagesExpense";
  static String getPurchase = "getPurchase";
  static String insertWagesEmp = "insertWagesEmployee";
  static String updateWagesEmp = "updateWagesEmployee";
  static String insertFood = "insertFoodExpense";
  static String updateFood = "updateFoodExpense";
  static String insertTravel = "insertTravelExpense";
  static String updateTravel = "updateTravelExpense";
  static String getUtilizationList = "getUtilizationExpense";
  static String getOthersList = "getOtherExpense";
  static String getTransportsList = "getTransportExpense";
  static String insertTransport = "insertTransportExpense";
  static String updateTransport = "updateTransportExpense";
  static String insertMaintenance = "insertRepairsMaintenanceExpense";
  static String updateMaintenance = "updateRepairsMaintenanceExpense";
  static String insertOthers = "insertOtherExpense";
  static String updateOthers = "updateOtherExpense";
  static String insertGeneral = "insertGeneralExpense";
  static String insertOnDuty = "addOndutyDetails";
  static String insertWages = "insertWagesExpense";
  static String insertUtilization = "insertUtilizationExpense";
  static String updateGeneral = "updateGeneralExpense";
  static String updateOnDuty = "updateOndutyDetails";
  static String updateIdeaLogy = "updateIdeasDetails";
  static String updateOffice = "updateOfficeExpense";
  static String updateWages = "updateWagesExpense";
  static String updateUtilization = "updateUtilizationExpense";
  static String getCity = "getCity";
  static String fundRequest = "fundRequest";
  static String getNotification = "getNotification";
  static String deleteNotification = "deleteNotification";
  static String getVendorDropdown = "getVendorDropdown";
  static String getCustomerDropdown = "getAllTransportCustomerName";
  static String getMaterialNameDropdown = "getAllPurchaseMaterialName";
  static String getUnit = "getAllPurchaseMaterialUnit";
  static String getMaintenance = "getMaintenance";
  static String getIdeaLogy= "getIdeasDetails";
  static String getSupport= "getAllHelpSupport";
  static String getOwnerName = "getAllOwner";
  static String getEmployeeNameIdeaLogy = "getEmployeeIdeasDetails";
  static String getGreenThanks = "getGreenThanksEmployee";
  static String insertPurchase = "insertPurchase";
  static String addVendor = "addvendor";
  static String addOwner = "addOwner";
  static String addCustomer = "addTransportCustomerName";
  static String addMaterial = "addPurchaseMaterialName";
  static String addChangePassword = "changeEmployeePassword";
  static String addUnit = "addPurchaseMaterialUnit";
  static String updatePurchase = "updatePurchaseExpense";
  static String statusUpdate = "deleteStatusUpdateExpense";
  static String deleteIdea = "deleteIdeasDetails";
  static String deleteOffice = "deleteOfficeExpense";
  static String getBalance = "get_available_balance";
  static String getSummary = "get_overall_expense_summary";
  static String updateCommercialToTechnical = "updateCommercialToTechnical";
  static String updateSalesTeam = "update_factory_project";
  static String getSalesTeamList = "get_all_factory_project";
  static String getCommercialList = "getCommercialFromSales";
  static String getTechnicalList = "getTechnicalFromCommercial";
  static String getAllExpenseSummary = "get_allexpense_summary";
  static String insertSalesTeam = "add_factory_project";
  static String getAppliedLeave = "getall_applied_leave";
  static String leaveApprove = "approve_leave";
  static String leaveReject = "reject_leave";
  static String getEscalation = "get_all_escalation";
  static String escalationApproval = "escalation_approval";
  static String getFeedback = "get_all_feedback";
  static String feedbackRespond = "feedback_respond";
  static String getAttendance = "get_all_attendance";
  static String attendanceApproval = "attendance_approval";
  static String getUser = "getalluser";
  static String getEmployeeName = "getAllEmployeeName";
  static String getOfficeCategory = "getOfficeDropdown";
  static String getItems = "get_factory_project_items";
  static String getSize = "get_size";
  static String particularTask = "particularTask";
  static String updateTask = "updateTaskStatus";
  static String support = "add_help_support";
  static String escalation = "get_escalation";
  static String escalationRespond = "escalation_respond";
  static String addEscalation = "add_escalation";
  static String getEventList = "getall_message";
  static String insertReminder = "insertReminder";
  static String updateReminder = "UpdateReminderStatus";
  static String addAgree = "addIdeasAgree";
  static String getReminderList = "getEmployeeReminder";
  static String getUserLeave = "get_user_leave";
  static String applyLeave = "apply_leave";
  static String getCommercialFromTechnical = "getCommercialFromTechnical";
  static String attendance = "attendance";
  static String updateTechnicalToCommercial = "updateTechnicalToCommercial";
  static String factory = "factorydepartment";
  static String getFactoryProject = "get_all_factory_project";
  static String factoryEmployeeResponse = "get_factory_employees";
  static String getFactoryDepartment = "factorydepartment";
  static String getFactoryEmployeeDetails = "get_all_factory_project";
  static String updateAssignProject = "assignproject";
  static String getCompletedProject = "completedproject";
  static String factoryUpdate = "factoryupdates";
  static String factoryCompletion = "factorycompletion";
  static String getReviewApproval = "get_factory_project";
  static String getWaitingForApproval = "waitingforapproval";
  static String managerApproval = "managerapproval";
  static String onDutyApproval = "getOnDuty";
  static String addIdea = "addIdeasDetails";
  static String addOffice = "insertOfficeExpense";
  static String getOnDuty= "getOnDutyApprovel";
  static String getOnDutyApproved= "getOnDutyApproved";
  static String getOnDutyPending= "getOnDutyApprovel";
  static String getOnDutyReject = "getOnDutyRejected";
  static String getLeaveDynamic = "getleaveDynamic";
  static String getLeaveList = "getYearlyCalendar";
  static String projectViewScreen = "getDashboardExpense";
  static String getGraphForProject = "getGraffDashboardExpense";
  static String getClient="get_client";
  static String getGeneralCodeClient = "getGeneralClientDropdown";
  static String getState="get_state";
  static String getDistrict="get_district";
  static String createProjectCode="create_project_code";
  static String updateTenderDetails="update_tender_details";
  static String siteProjectCDode="getAllSiteProject";
  static String getParticularSiteProjectC = "getParticularSiteProject";
  static String getSiteProjectTender = "getTenderSiteProject";
  static String getParticularSiteProjectTender = "siteProjectsTender";
  static String addGeneralCodeClientName = "createGeneralCodeClient";
  static String addGeneralCode = "create_general_code";
  static String tenderDescriptionDropDown = "getSiteDescriptionDropdown";
  static String tenderUnitDropdown = "getSiteUnitDropdown";
  static String deductionDropDownResponseModel = "getDeduction";
  static String flowOfBillDropdownResponse = "getFlowOfBill";

}
