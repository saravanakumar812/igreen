import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:igreen_flutter/Binding/AccommodationSummaryBinding.dart';
import 'package:igreen_flutter/Binding/AddAccommodationBinding.dart';
import 'package:igreen_flutter/Binding/AddFuelExpenseBinding.dart';
import 'package:igreen_flutter/Binding/AssignMechanicalTeamBinding.dart';
import 'package:igreen_flutter/Binding/AttendanceHistoryScreenTwoController.dart';
import 'package:igreen_flutter/Binding/ChangePasswordScreenBinding.dart';
import 'package:igreen_flutter/Binding/CreateFundRequestBinding.dart';
import 'package:igreen_flutter/Binding/EarningScreenBinding.dart';
import 'package:igreen_flutter/Binding/EscalationOneBinding.dart';
import 'package:igreen_flutter/Binding/EscalationResponseScreenBinding.dart';
import 'package:igreen_flutter/Binding/ExpenseScreenBinding.dart';
import 'package:igreen_flutter/Binding/GetGreenThanksBinding.dart';
import 'package:igreen_flutter/Binding/GetIdealogyEmployeeBinding.dart';
import 'package:igreen_flutter/Binding/GetOnDutyEmployeeListBinding.dart';
import 'package:igreen_flutter/Binding/IdealogyEntryBinding.dart';
import 'package:igreen_flutter/Binding/FinanceHomeBinding.dart';
import 'package:igreen_flutter/Binding/FuelCategoriesBinding.dart';
import 'package:igreen_flutter/Binding/FuelSummaryBinding.dart';
import 'package:igreen_flutter/Binding/HomeScreenBinding.dart';
import 'package:igreen_flutter/Binding/MaintenanceSummaryBinding.dart';
import 'package:igreen_flutter/Binding/OfficeAddScreenBinding.dart';
import 'package:igreen_flutter/Binding/OfficeSummryScreenBinding.dart';
import 'package:igreen_flutter/Binding/OndutyApprovalScreenBinding.dart';
import 'package:igreen_flutter/Binding/OndutyPendingScreenBinding.dart';
import 'package:igreen_flutter/Binding/OndutyEntryScreenBinding.dart';
import 'package:igreen_flutter/Binding/OndutyRejectScreenBinding.dart';
import 'package:igreen_flutter/Binding/OndutyScreenBinding.dart';
import 'package:igreen_flutter/Binding/PaySlipBinding.dart';
import 'package:igreen_flutter/Binding/ProfileScreenBinding.dart';
import 'package:igreen_flutter/Binding/ProjectListViewBinding.dart';
import 'package:igreen_flutter/Binding/RentedScreenBinding.dart';
import 'package:igreen_flutter/Binding/RepairsPurchaseBinding.dart';
import 'package:igreen_flutter/Binding/SalaryScreenBinding.dart';
import 'package:igreen_flutter/Binding/SupportBinding.dart';
import 'package:igreen_flutter/Binding/SupportMessageScreenBinding.dart';
import 'package:igreen_flutter/UI/Announcement/Events.dart';
import 'package:igreen_flutter/UI/ChangePassword/ChangePasswordScreen.dart';
import 'package:igreen_flutter/UI/ChangePassword/ForgotPasswordScreen.dart';
import 'package:igreen_flutter/UI/Finance/EarningScreen.dart';
import 'package:igreen_flutter/UI/Finance/FinanceHome.dart';
import 'package:igreen_flutter/UI/Finance/PaySlip.dart';
import 'package:igreen_flutter/UI/Finance/SalaryScreen.dart';
import 'package:igreen_flutter/UI/Fund/CreateFundRequest.dart';
import 'package:igreen_flutter/UI/Hrms/EscalationListOne.dart';
import 'package:igreen_flutter/UI/Hrms/Feedback.dart';
import 'package:igreen_flutter/UI/IdeaLogy/GetEmployeeIdeaLogy.dart';
import 'package:igreen_flutter/UI/IdeaLogy/IdeasAgreeScreen.dart';
import 'package:igreen_flutter/UI/Maintanance/MaiintanancePage.dart';
import 'package:igreen_flutter/UI/Maintanance/MaintenanSummaryPage.dart';
import 'package:igreen_flutter/UI/Non%20Project/TaskView.dart';
import 'package:igreen_flutter/UI/Office/OfficeAddScreen.dart';
import 'package:igreen_flutter/UI/Office/OfficeSummaryScreen.dart';
import 'package:igreen_flutter/UI/OnDuty/OnDutyEmployeeList.dart';
import 'package:igreen_flutter/UI/OnDuty/OndutyApprovedScreen.dart';
import 'package:igreen_flutter/UI/OnDuty/OndutyPendingScreen.dart';
import 'package:igreen_flutter/UI/OnDuty/OndutyEntryScreen.dart';
import 'package:igreen_flutter/UI/OnDuty/OndutyRejectedScreen.dart';
import 'package:igreen_flutter/UI/OnDuty/OndutyScreen.dart';
import 'package:igreen_flutter/UI/OnDuty/OndutySummaryScreen.dart';
import 'package:igreen_flutter/UI/Profile/EscalationPendingScreen.dart';
import 'package:igreen_flutter/UI/Profile/GetGreenThanks.dart';
import 'package:igreen_flutter/UI/Profile/ProfileScreen.dart';
import 'package:igreen_flutter/UI/Accomondation/AccommodationSummary.dart';
import 'package:igreen_flutter/UI/Accomondation/AddAccommodation.dart';
import 'package:igreen_flutter/UI/Fuel/AddFuelExpense.dart';
import 'package:igreen_flutter/UI/Fuel/FuelSummary.dart';
import 'package:igreen_flutter/UI/ProjectList/ProjectListView.dart';
import 'package:igreen_flutter/UI/Rentel/RentalSummary.dart';
import 'package:igreen_flutter/UI/RepairsAndMaintenance/repairPurchase.dart';
import 'package:igreen_flutter/UI/Screens/GetSupportScreen.dart';
import '../Binding/AddEventsBinding.dart';
import '../Binding/AddOthersSummary.dart';
import '../Binding/AddReminderBinding.dart';
import '../Binding/AssignProjectListBinding.dart';
import '../Binding/AttenadnceApprovalBinding.dart';
import '../Binding/AttendanceHistoryScreenOneBinding.dart';
import '../Binding/BottomNavBarBinding.dart';
import '../Binding/CommercialBinding.dart';
import '../Binding/EmployeeProjectDetailsBinding.dart';
import '../Binding/EmployeeProjectListBinding.dart';
import '../Binding/EscalationPendingScreenBinding.dart';
import '../Binding/EscalationTwoBinding.dart';
import '../Binding/GetSupportScreenBinding.dart';
import '../Binding/IdeaLogySummaryBinding.dart';
import '../Binding/FeedBacksBinding.dart';
import '../Binding/FeedbackRespondScreenBinding.dart';
import '../Binding/FoodSummaryBinding.dart';
import '../Binding/FundRequestBinding.dart';
import '../Binding/GeneralSummryBinding.dart';
import '../Binding/GetCommercialFromTechnicalBinding.dart';
import '../Binding/GreenThankBinding.dart';
import '../Binding/GriVanceBinding.dart';
import '../Binding/GriVanceCreateScreenBinding.dart';
import '../Binding/HrmsHomeBinding.dart';
import '../Binding/IdeasAgreeBinding.dart';
import '../Binding/LeaveApplyBinding.dart';
import '../Binding/LeaveApplyScreenBinding.dart';
import '../Binding/LeaveApprvalBinding.dart';
import '../Binding/LeaveStatusScreenBinding.dart';
import '../Binding/LoginBinding.dart';

import '../Binding/MaintenanceBinding.dart';
import '../Binding/ManagerHierarchyBinding.dart';
import '../Binding/NonProjectListBindingScreen.dart';
import '../Binding/OndutySummaryScreenBinding.dart';
import '../Binding/ProjectManagerAssignBinding.dart';
import '../Binding/ProjectReviewBinding.dart';
import '../Binding/PurchaseSummaryBinding.dart';
import '../Binding/ReminderBinding.dart';
import '../Binding/RentalSummaryBinding.dart';
import '../Binding/RepairsAndMaintenanceSummaryBinding.dart';
import '../Binding/SalesTeamOneBinding.dart';
import '../Binding/SummaryScreenBinding.dart';
import '../Binding/TaskViewBinding.dart';
import '../Binding/TechnicalPageBinding.dart';
import '../Binding/TechnicalUpdateBinding.dart';
import '../Binding/TransportSummaryBinding.dart';
import '../Binding/TravelSummaryBinding.dart';
import '../Binding/UtilizationSummaryBinding.dart';
import '../Binding/WageEmployeeDetailsBinding.dart';
import '../Binding/WageEmployeeListBinding.dart';
import '../Binding/WagesSummaryBinding.dart';
import '../UI/Announcement/AddEvents.dart';
import '../UI/Announcement/AddReminder.dart';
import '../UI/Announcement/Reminder.dart';
import '../UI/BottomNavBarScreen.dart';
import '../UI/Food/FoodEntry.dart';
import '../UI/Food/FoodSummary.dart';
import '../UI/Fund/FundRequest.dart';
import '../UI/General/GeneralEntryScreen.dart';
import '../UI/General/GeneralSummaryScreen.dart';
import '../UI/Hrms/AttendanceApproval.dart';
import '../UI/Hrms/AttendanceHistoryScreenOne.dart';
import '../UI/Hrms/AttendanceHistoryScreenTwo.dart';
import '../UI/Hrms/EscalationListTwo.dart';
import '../UI/Hrms/FeedbackRespondScreen.dart';
import '../UI/Hrms/HrmsHomePage.dart';
import '../UI/Hrms/LeaveApplyScreen.dart';
import '../UI/IdeaLogy/IdeaLogyEntry.dart';
import '../UI/IdeaLogy/IdeaLogySummary.dart';
import '../UI/Non Project/NonProjectListScreen.dart';
import '../UI/Others/AddOthersExpanseScreen.dart';
import '../UI/Others/AddOthersSummaryScreen.dart';
import '../UI/Profile/EscalationResponseScreen.dart';
import '../UI/Profile/GreenThank.dart';
import '../UI/Profile/GriVanceCreateScreen.dart';
import '../UI/Profile/Grivance.dart';
import '../UI/Profile/LeaveApply.dart';
import '../UI/Profile/LeaveStatusScreen.dart';
import '../UI/Profile/ManagerHierarchy.dart';
import '../UI/Project/AssignMechanicalTeam.dart';
import '../UI/Project/AssignProjectList.dart';
import '../UI/Project/Commercial_Manager.dart';
import '../UI/Project/EmployeeProjectDetails.dart';
import '../UI/Project/EmployeeProjectList.dart';
import '../UI/Project/GetCommercialFromTechnical.dart';
import '../UI/Project/SalesTeam.dart';
import '../UI/Project/SalesTeamOne.dart';
import '../UI/Project/TechnicalUpdate.dart';
import '../UI/Project/Technical_Manager.dart';
import '../UI/Purchases/PurchaseEntryScreen.dart';
import '../UI/Purchases/PurchaseSummaryScreen.dart';
import '../UI/RepairsAndMaintenance/RepairsAndMaintenanceEntryScreen.dart';
import '../UI/RepairsAndMaintenance/RepairsAndMaintenanceSummaryScreen.dart';
import '../UI/Review/ProjectDatailsReview.dart';
import '../UI/Fuel/FuelCategories.dart';
import '../UI/Rentel/RentelScreen.dart';
import '../UI/Screens/ExpenseScreen.dart';
import '../UI/Screens/HomeScreen.dart';
import '../UI/Screens/LoginScreen.dart';
import '../UI/Screens/SupportMessageScreen.dart';
import '../UI/Screens/SupportScreen.dart';
import '../UI/Summary/SummaryScreen.dart';
import '../UI/Transport/TransportExpenseScreen.dart';
import '../UI/Transport/TransportSummaryScreen.dart';
import '../UI/Travel/TravelEntryScreen.dart';
import '../UI/Travel/TravelSummaryScreen.dart';
import '../UI/Utilization/UtilizationEntryScreen.dart';
import '../UI/Utilization/UtilizationSummaryScreen.dart';
import '../UI/Wages/WageEmployeeDetails.dart';
import '../UI/Wages/WageEmployeeList.dart';
import '../UI/Wages/WagesEntryScreen.dart';
import '../UI/Wages/WagesSummaryScreen.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
        name: AppRoutes.login.toName,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.home.toName,
        page: () => const HomeScreen(),
        binding: HomeScreenBinding()),
    GetPage(
        name: AppRoutes.expenseScreen.toName,
        page: () => const ExpenseScreen(),
        binding: ExpenseScreenBinding()),
    GetPage(
        name: AppRoutes.fuelCategories.toName,
        page: () => const FuelCategories(),
        binding: FuelCategoriesBinding()),
    GetPage(
        name: AppRoutes.addFuelExpense.toName,
        page: () => AddFuelExpense(),
        binding: AddFuelExpenseBinding()),
    GetPage(
        name: AppRoutes.fuelSummary.toName,
        page: () => FuelSummary(),
        binding: FuelSummaryBinding()),
    GetPage(
        name: AppRoutes.rentedScreen.toName,
        page: () => RentedScreen(),
        binding: RentedBinding()),
    GetPage(
        name: AppRoutes.rentSummary.toName,
        page: () => RentalSummary(),
        binding: RentalSummaryBinding()),
    GetPage(
        name: AppRoutes.accommodationSummary.toName,
        page: () => AccommodationSummary(),
        binding: AccommodationSummaryBinding()),
    GetPage(
        name: AppRoutes.travelSummaryScreen.toName,
        page: () => TravelSummaryScreen(),
        binding: TravelSummaryBinding()),
    GetPage(
        name: AppRoutes.travelEntryScreen.toName,
        page: () => TravelEntryScreen(),
        binding: TravelSummaryBinding()),
    GetPage(
        name: AppRoutes.addAccommodation.toName,
        page: () => AddAccommodation(),
        binding: AddAccommodationBinding()),
    GetPage(
        name: AppRoutes.foodEntryScreen.toName,
        page: () => FoodEntryScreen(),
        binding: FoodSummaryBinding()),
    GetPage(
        name: AppRoutes.foodSummaryScreen.toName,
        page: () => FoodSummaryScreen(),
        binding: FoodSummaryBinding()),
    GetPage(
        name: AppRoutes.repairsAndMaintenanceEntryScreen.toName,
        page: () => RepairsAndMaintenanceEntryScreen(),
        binding: RepairsAndMaintenanceSummaryBinding()),
    GetPage(
        name: AppRoutes.repairsAndMaintenanceSummaryScreen.toName,
        page: () => RepairsAndMaintenanceSummaryScreen(),
        binding: RepairsAndMaintenanceSummaryBinding()),
    GetPage(
        name: AppRoutes.generalEntryScreen.toName,
        page: () => GeneralEntryScreen(),
        binding: GeneralSummaryBinding()),
    GetPage(
        name: AppRoutes.generalSummaryScreen.toName,
        page: () => GeneralSummaryScreen(),
        binding: GeneralSummaryBinding()),
    GetPage(
        name: AppRoutes.wagesEntryScreen.toName,
        page: () => WagesEntryScreen(),
        binding: WagesSummaryBinding()),
    GetPage(
        name: AppRoutes.wagesSummaryScreen.toName,
        page: () => WagesSummaryScreen(),
        binding: WagesSummaryBinding()),
    GetPage(
        name: AppRoutes.purchaseEntryScreen.toName,
        page: () => PurchaseEntryScreen(),
        binding: PurchaseSummaryBinding()),
    GetPage(
        name: AppRoutes.purchaseSummaryScreen.toName,
        page: () => PurchaseSummaryScreen(),
        binding: PurchaseSummaryBinding()),
    GetPage(
        name: AppRoutes.purchaseEntryScreen.toName,
        page: () => PurchaseEntryScreen(),
        binding: PurchaseSummaryBinding()),
    GetPage(
        name: AppRoutes.purchaseSummaryScreen.toName,
        page: () => PurchaseSummaryScreen(),
        binding: PurchaseSummaryBinding()),
    GetPage(
        name: AppRoutes.utilizationEntryScreen.toName,
        page: () => UtilizationEntryScreen(),
        binding: UtilizationSummaryBinding()),
    GetPage(
        name: AppRoutes.utilizationSummaryScreen.toName,
        page: () => UtilizationSummaryScreen(),
        binding: UtilizationSummaryBinding()),
    GetPage(
        name: AppRoutes.addOthersExpenseScreen.toName,
        page: () => AddOthersExpenseScreen(),
        binding: AddOthersSummaryBinding()),
    GetPage(
        name: AppRoutes.addOthersSummaryScreen.toName,
        page: () => AddOthersSummaryScreen(),
        binding: AddOthersSummaryBinding()),
    GetPage(
        name: AppRoutes.transportExpenseScreen.toName,
        page: () => TransportExpenseScreen(),
        binding: TransportSummaryBinding()),
    GetPage(
        name: AppRoutes.transportSummaryScreen.toName,
        page: () => TransportSummaryScreen(),
        binding: TransportSummaryBinding()),
    GetPage(
        name: AppRoutes.createdFundRequest.toName,
        page: () => CreateFundRequest(),
        binding: CreateFundRequestBinding()),
    GetPage(
        name: AppRoutes.fundRequest.toName,
        page: () => FundRequest(),
        binding: FundRequestBinding()),
    GetPage(
        name: AppRoutes.summaryScreen.toName,
        page: () => SummaryScreen(),
        binding: SummaryScreenBinding()),
    GetPage(
        name: AppRoutes.addSalesTeam.toName,
        page: () => AddSalesTeam(),
        binding: SalesTeamOneBinding()),
    GetPage(
        name: AppRoutes.salesTeamOne.toName,
        page: () => SalesTeamOne(),
        binding: SalesTeamOneBinding()),
    GetPage(
        name: AppRoutes.commercialPage.toName,
        page: () => const CommercialPage(),
        binding: CommercialPageBinding()),
    GetPage(
        name: AppRoutes.technicalPage.toName,
        page: () => TechnicalPage(),
        binding: TechnicalPageBinding()),
    GetPage(
        name: AppRoutes.supportMessageScreen.toName,
        page: () => SupportMessageScreen(),
        binding: SupportMessageScreenBinding()),
    GetPage(
        name: AppRoutes.leaveApplyScreen.toName,
        page: () => LeaveApplyScreen(),
        binding: LeaveApplyScreenBinding()),
    GetPage(
        name: AppRoutes.escalationOne.toName,
        page: () => EscalationListOne(),
        binding: EscalationOneBinding()),
    GetPage(
        name: AppRoutes.escalationTwo.toName,
        page: () => EscalationListTwo(),
        binding: EscalationTwoBinding()),
    GetPage(
        name: AppRoutes.feedbacks.toName,
        page: () => FeedbackPage(),
        binding: FeedbacksBinding()),
    GetPage(
        name: AppRoutes.feedbackRespond.toName,
        page: () => FeedbackRespondScreen(),
        binding: FeedbackRespondScreenBinding()),
    GetPage(
        name: AppRoutes.attendanceApproval.toName,
        page: () => AttendanceApproval(),
        binding: AttendanceApprovalBinding()),
    GetPage(
        name: AppRoutes.attendanceHistoryScreenOne.toName,
        page: () => AttendanceHistoryScreenOne(),
        binding: AttendanceHistoryScreenOneBinding()),
    GetPage(
        name: AppRoutes.attendanceHistoryScreenTwo.toName,
        page: () => AttendanceHistoryScreenTwo(),
        binding: AttendanceHistoryScreenTwoBinding()),
    GetPage(
        name: AppRoutes.nonProjectListScreen.toName,
        page: () => const NonProjectListScreen(),
        binding: NonProjectListBindingScreen()),
    GetPage(
        name: AppRoutes.profileScreen.toName,
        page: () => ProfileScreen(),
        binding: ProfileScreenBinding()),
    GetPage(
        name: AppRoutes.managerHierarchyBinding.toName,
        page: () => ManagerHierarchy(),
        binding: ManagerHierarchyBinding()),
    GetPage(
        name: AppRoutes.greenThank.toName,
        page: () => GreenThank(),
        binding: GreenThankBinding()),
    GetPage(
        name: AppRoutes.griVance.toName,
        page: () => GriVance(),
        binding: GriVanceBinding()),
    GetPage(
        name: AppRoutes.griVanceCreateScreen.toName,
        page: () => GriVanceCreateScreen(),
        binding: GriVanceCreateScreenBinding()),
    GetPage(
        name: AppRoutes.leaveStatusScreen.toName,
        page: () => LeaveStatusScreen(),
        binding: LeaveStatusScreenBinding()),
    GetPage(
        name: AppRoutes.addEvents.toName,
        page: () => AddEvents(),
        binding: AddEventsBinding()),
    GetPage(
        name: AppRoutes.addReminder.toName,
        page: () => AddReminder(),
        binding: AddReminderBinding()),
    GetPage(
        name: AppRoutes.reminder.toName,
        page: () => Reminder(),
        binding: ReminderBinding()),
    GetPage(
        name: AppRoutes.events.toName,
        page: () => Events(),
        binding: AddEventsBinding()),
    GetPage(
        name: AppRoutes.leaveApply.toName,
        page: () => LeaveApply(),
        binding: LeaveApplyBinding()),
    GetPage(
        name: AppRoutes.bottomNavBar.toName,
        page: () => BottomNavBar(),
        binding: BottomNavBarBinding()),
    GetPage(
        name: AppRoutes.getCommercialFromTechnical.toName,
        page: () => GetCommercialFromTechnical(),
        binding: GetCommercialFromTechnicalBinding()),
    GetPage(
        name: AppRoutes.paySlip.toName,
        page: () => PaySlip(),
        binding: PaySlipBinding()),
    GetPage(
        name: AppRoutes.financeHome.toName,
        page: () => FinanceHome(),
        binding: FinanceHomeBinding()),
    GetPage(
        name: AppRoutes.salaryScreen.toName,
        page: () => SalaryScreen(),
        binding: SalaryScreenBinding()),
    GetPage(
        name: AppRoutes.earningScreen.toName,
        page: () => EarningScreen(),
        binding: EarningScreenBinding()),
    GetPage(
        name: AppRoutes.hRMSHome.toName,
        page: () => HRMSHome(),
        binding: HRMSHomeBinding()),
    GetPage(
        name: AppRoutes.technicalScreen.toName,
        page: () => TechnicalPage(),
        binding: TechnicalPageBinding()),
    GetPage(
        name: AppRoutes.technicalUpdate.toName,
        page: () => TechnicalUpdate(),
        binding: TechnicalUpdateBinding()),
    GetPage(
        name: AppRoutes.assignProjectList.toName,
        page: () => AssignProjectList(),
        binding: AssignProjectListBinding()),
    GetPage(
        name: AppRoutes.assignMechanicalTeam.toName,
        page: () => AssignMechanicalTeam(),
        binding: AssignMechanicalTeamBinding()),
    GetPage(
        name: AppRoutes.employeeProjectDetails.toName,
        page: () => EmployeeProjectDetails(),
        binding: EmployeeProjectDetailsBinding()),
    GetPage(
        name: AppRoutes.employeeProjectList.toName,
        page: () => EmployeeProjectList(),
        binding: EmployeeProjectListBinding()),
    GetPage(
        name: AppRoutes.projectReview.toName,
        page: () => ProjectDetailsReview(),
        binding: ProjectReviewBinding()),
    GetPage(
        name: AppRoutes.maintenancePage.toName,
        page: () => Maintenance(),
        binding: MaintenanceBinding()),

    GetPage(
        name: AppRoutes.maintenanceSummary.toName,
        page: () => MaintenanceSummary(),
        binding: MaintenanceSummaryBinding()),
    GetPage(
        name: AppRoutes.maintenanceSummary.toName,
        page: () => MaintenanceSummary(),
        binding: MaintenanceSummaryBinding()),
    GetPage(
        name: AppRoutes.repairsPurchase.toName,
        page: () => RepairPurchaseEntryScreen(),
        binding: RepairsPurchaseBinding()),

    GetPage(
        name: AppRoutes.wagesEmployeeList.toName,
        page: () => WageEmployeeList(),
        binding: WageEmployeeListBinding()),

    GetPage(
        name: AppRoutes.wageEmployeeDetails.toName,
        page: () => WageEmployeeDetails(),
        binding: WageEmployeeDetailsBinding()),

    GetPage(
        name: AppRoutes.ideaLogyEntry.toName,
        page: () => IdeaLogyEntryScreen(),
        binding: IdeaLogyEntryBinding()),

    GetPage(
        name: AppRoutes.ideaLogySummary.toName,
        page: () => IdeaLogySummaryScreen(),
        binding: IdeaLogySummaryBinding()),

    GetPage(
        name: AppRoutes.onDutyEntry.toName,
        page: () => OnDutyEntryScreen(),
        binding: OnDutyEntryScreenBinding()),

    GetPage(
        name: AppRoutes.onDutySummary.toName,
        page: () => OnDutySummaryScreen(),
        binding: OnDutySummaryScreenBinding()),

    // GetPage(
    //     name: AppRoutes.getIdeaLogyEmployee.toName,
    //     page: () =>GetEmployeeIdeaLogy(),
    //     binding: GetIdeaLogyEmployeeBinding()),

    GetPage(
        name: AppRoutes.getOnDutyEmployee.toName,
        page: () => GetOnDutyEmployeeScreen(),
        binding: GetOnDutyEmployeeBinding()),

    GetPage(
        name: AppRoutes.getGreenThanks.toName,
        page: () => GetGreenThanks(),
        binding: GetGreenThanksBinding()),

    GetPage(
        name: AppRoutes.onDutyScreen.toName,
        page: () => OnDutyScreen(),
        binding: OnDutyScreenBinding()),

    GetPage(
        name: AppRoutes.escalationThree.toName,
        page: () => EscalationResponseList(),
        binding: EscalationResponseScreenBinding()),

    GetPage(
        name: AppRoutes.escalationPending.toName,
        page: () => EscalationPendingList(),
        binding: EscalationPendingScreenBinding()),

    GetPage(
        name: AppRoutes.onDutyPending.toName,
        page: () => OnDutyPendingScreen(),
        binding: OnDutyPendingScreenBinding()),

    GetPage(
        name: AppRoutes.onDutyApproval.toName,
        page: () => OnDutyApprovedScreen(),
        binding: OnDutyApprovalScreenBinding()),

    GetPage(
        name: AppRoutes.ideaAgree.toName,
        page: () => IdeasAgreeScreen(),
        binding: IdeasAgreeScreenBinding()),

    GetPage(
        name: AppRoutes.onDutyReject.toName,
        page: () => OnDutyRejectedScreen(),
        binding: OnDutyRejectScreenBinding()),

    GetPage(
        name: AppRoutes.taskView.toName,
        page: () => TaskView(),
        binding: TaskViewBinding()),

    GetPage(
        name: AppRoutes.officeAdd.toName,
        page: () => OfficeAddScreen(),
        binding: OfficeAddScreenBinding()),

    GetPage(
        name: AppRoutes.officeSummary.toName,
        page: () => OfficeSummaryScreen(),
        binding: OfficeSummaryScreenBinding()),

    GetPage(
        name: AppRoutes.changePassword.toName,
        page: () => ChangePasswordScreen(),
        binding: ChangePasswordScreenBinding()),

    GetPage(
        name: AppRoutes.forgotPassword.toName,
        page: () => ForgotPasswordScreen(),
        binding: ChangePasswordScreenBinding()),

    GetPage(
        name: AppRoutes.getSupport.toName,
        page: () => GetSupportScreen(),
        binding: GetSupportScreenBinding()),

    GetPage(
        name: AppRoutes.supportScreen.toName,
        page: () => SupportPage(),
        binding: SupportBinding()),

    GetPage(
        name: AppRoutes.projectListView.toName,
        page: () => ProjectListView(),
        binding: ProjectListViewBinding()),

    GetPage(
        name: AppRoutes.graphScreen.toName,
        page: () => ProjectListView(),
        binding: ProjectListViewBinding()),
  ];
}
