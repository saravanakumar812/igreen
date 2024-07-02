import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../forms/theme.dart';
import '../model/HomeScreenResponseModel.dart';
import '../model/responseModel/ProjectCodeListResponse.dart';
import '../provider/menuProvider.dart';

class HomeScreenController extends GetxController {
  RxBool selectProjectList = false.obs;
  RxString selectItems = RxString("Select Project");
  RxInt selectedValueCustomer = RxInt(0);
  RxBool isLoading = RxBool(false);
  RxList<ProjectListData> projectData = RxList();
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxString currentDate = RxString("Start Date");
  TextEditingController projectCodeController = TextEditingController();
  bool isCall = false;
  RxList<HomeScreenResponseModel> homeScreenData = RxList();

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);

    if (!isCall) {
      isCall = true;
      getProjectList();
    }

    homeScreenView();
  }

  homeScreenView(){
    HomeScreenResponseModel title1 = HomeScreenResponseModel();
    HomeScreenResponseModel title2 = HomeScreenResponseModel();
    HomeScreenResponseModel title3 = HomeScreenResponseModel();
    HomeScreenResponseModel title4 = HomeScreenResponseModel();
    HomeScreenResponseModel title5 = HomeScreenResponseModel();
    HomeScreenResponseModel title6 = HomeScreenResponseModel();
    HomeScreenResponseModel title7 = HomeScreenResponseModel();
    HomeScreenResponseModel title8 = HomeScreenResponseModel();
    HomeScreenResponseModel title9 = HomeScreenResponseModel();
    HomeScreenResponseModel title10 = HomeScreenResponseModel();
    HomeScreenResponseModel title11 = HomeScreenResponseModel();
    HomeScreenResponseModel title12 = HomeScreenResponseModel();
    HomeScreenResponseModel title13 = HomeScreenResponseModel();
    HomeScreenResponseModel title14 = HomeScreenResponseModel();


    title1.title = "Attendance";
    title1.images = "assets/images/Attendance.png";
    title1.color = AppTheme.liteWhite;
    homeScreenData.add(title1);

    // title14.title = "Site Project Creation";
    // title14.images = "assets/images/dashboard.png";
    // title14.color = AppTheme.grey;
    // homeScreenData.add(title14);

    title2.title = "DashBoard";
    title2.images = "assets/images/dashboard.png";
    title2.color = AppTheme.grey;
    homeScreenData.add(title2);

    title3.title = "Factory";
    title3.images = "assets/images/project.png";
    title3.color = AppTheme.litePink;
    homeScreenData.add(title3);

    title4.title = "Fund Request";
    title4.images = "assets/images/fund.png";
    title4.color = AppTheme.liteBlue97;

    homeScreenData.add(title4);

    title5.title = "Task";
    title5.images = "assets/images/nonProject.png";
    title5.color = AppTheme.liteWhite;

    homeScreenData.add(title5);

    title6.title = "Expense";
    title6.images = "assets/images/expense.png";
    title6.color = AppTheme.subTitleOrange;

    homeScreenData.add(title6);

    title7.title = "HRMS";
    title7.images = "assets/images/hrms.png";
    title7.color = AppTheme.bottomTabsLabelInActiveColor;

    homeScreenData.add(title7);

    title8.title = "Support";
    title8.images = "assets/images/support.png";
    title8.color = AppTheme.grey;

    homeScreenData.add(title8);

    title9.title = "Announcement";
    title9.images = "assets/images/Announcement.png";
    title9.color = AppTheme.lite;

    homeScreenData.add(title9);

    title10.title = "Office";
    title10.images = "assets/images/feedback.png";
    title10.color = AppTheme.litePink;

    homeScreenData.add(title10);

    title11.title = "Maintenance";
    title11.images = "assets/images/review.png";
    title11.color = AppTheme.bgBlue;

    homeScreenData.add(title11);

    title12.title = "Ideology";
    title12.images = "assets/images/feedback.png";
    title12.color = AppTheme.secondaryColor;

    homeScreenData.add(title12);

    title13.title = "On Duty";
    title13.images = "assets/images/feedback.png";
    title13.color = AppTheme.yellow;

    homeScreenData.add(title13);

    title14.title = "Project \n Creation";
    title14.images = "assets/images/project.png";
    title14.color = AppTheme.liteBlue3;

    homeScreenData.add(title14);
  }

  bool firstValidation() {
    if (currentDate.value == "Start Date") {
      Fluttertoast.showToast(
        msg: "Please Select Date!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false; // Return with no value, since this function is void
    }
    if (selectItems.value == "Select Project") {
      Fluttertoast.showToast(
        msg: "Please Select Project!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  getProjectList() async {
    isLoading.value = true;
    var response = await _connect.getProjectListCall();
    isLoading.value = false;
    if (response.data != null) {
      projectData.value = response.data!;
      debugPrint("getProjectList: ${response.toJson()}");
    } else {}
  }

}
