import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/Controller/HomeScreenController.dart';
import 'package:igreen_flutter/UI/Maintanance/MaiintanancePage.dart';
import 'package:igreen_flutter/UI/Maintanance/MaintenanSummaryPage.dart';
import 'package:igreen_flutter/UI/Profile/ProfileScreen.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:igreen_flutter/forms/theme.dart';
import '../../forms/forms.dart';
import '../../routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../Announcement/AnnouncementPage.dart';

import '../Fund/CreateFundRequest.dart';
import '../OnDuty/OndutyScreen.dart';
import '../Project/ProjectPage.dart';
import '../ProjectCreation/project_creation.dart';
import '../Review/ReviewPage.dart';
import '../SiteProjectCreation/SiteProjectCreationScreen.dart';
import 'AttendenceScreen.dart';
import 'SupportScreen.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    HomeScreenController controller = Get.put(HomeScreenController());
    int currentPage = 0;

    void onTap(int index) {
      currentPage = index;
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

    Future<void> selectDate(BuildContext context) async {

      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          selectableDayPredicate: selectableDay,
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
        controller.currentDate.value = DateFormat('yyyy-MM-dd').format(picked);
      }

    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: AppTheme.screenBackground,
      appBar: PreferredSize(
        preferredSize: Size(100, 70),
        child: AppBar(
          backgroundColor: AppTheme.screenBackground,
          automaticallyImplyLeading: false,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.contain,
            width: width * 0.3,
            height: height * 0.1,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.notifications, color: Colors.white),
              ),
            ),
          ],
          // flexibleSpace: Container(
          //   height: 80,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(0.0),
          //       bottomRight: Radius.circular(0.0),
          //     ),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Container(
          //         child: InkWell(
          //             onTap: () {
          //               Get.back();
          //             },
          //             child: Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 15),
          //               child: Column(
          //                 children: [
          //                   SizedBox(
          //                     height: 23,
          //                   ),
          //                   Icon(
          //                     Icons.arrow_back,
          //                     color: Colors.black,
          //                   ),
          //                 ],
          //               ),
          //             )),
          //       ),
          //       SizedBox(
          //         width: 70,
          //       ),
          //       // Image.asset(
          //       //   "assets/images/logo.png",
          //       //   fit: BoxFit.contain,
          //       //   width: width * 0.3,
          //       //   height: height * 0.1,
          //       // ),
          //       Spacer(),
          //       Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: Container(
          //           height: 25,
          //           width: 25,
          //           decoration: BoxDecoration(
          //             color: Colors.green,
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //           child: Icon(Icons.notifications, color: Colors.white),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

          Row(
            children: [
              SizedBox(
                width: 45,
              ),
              Text("Welcome , ${AppPreference().getEmpName}",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ],
          ),

          const SizedBox(
            height: 15,
          ),

          SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              child: GridView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1.25,
                  // childAspectRatio: 0.85,
                ),
                itemCount: controller.homeScreenData.length,
                itemBuilder: (BuildContext context, int index) {

                  return Column(
                    children: [

                      GestureDetector(
                        onTap: () {

                          if (controller.homeScreenData[index].title ==
                              'Attendance') {
                            Get.to(AttendanceScreen());
                          } else if (controller.homeScreenData[index].title ==
                              'Site Project Creation') {
                            Get.to(SiteProjectCreationScreen());
                          } else if (controller.homeScreenData[index].title ==
                              'DashBoard') {
                            Get.toNamed(AppRoutes.projectListView.toName);
                          } else if (controller.homeScreenData[index].title ==
                              'Factory') {
                            Get.to(ProjectPage());
                          } else if (controller.homeScreenData[index].title ==
                              'Fund Request') {
                            Get.to(CreateFundRequest());
                          } else if (controller.homeScreenData[index].title ==
                              'Task') {
                            Get.toNamed(AppRoutes.nonProjectListScreen.toName);
                          } else if (controller.homeScreenData[index].title ==
                              'Expense') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DefaultTabController(
                                  length: 2,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 30),
                                          Obx(
                                            () => InkWell(
                                              onTap: () {
                                                selectDate(context);
                                              },
                                              child: Container(
                                                height: 50,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      AppTheme.secondaryColor,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.55,
                                                      child: Text(
                                                        controller
                                                            .currentDate.value,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          Obx(
                                            () => InkWell(
                                              onTap: () {
                                                controller.selectProjectList
                                                        .value =
                                                    !controller
                                                        .selectProjectList
                                                        .value;
                                              },
                                              child: Container(
                                                height: 70,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      AppTheme.secondaryColor,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller
                                                            .selectItems.value,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    // Icon(
                                                    //   Icons.calendar_today,
                                                    //   color: Colors.black,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Obx(
                                            () => Visibility(
                                              visible: controller
                                                  .selectProjectList.value,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  height: height * 0.3,
                                                  margin: EdgeInsets.fromLTRB(
                                                      12, 0, 12, 0),
                                                  padding: EdgeInsets.fromLTRB(
                                                      6, 4, 0, 6),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppTheme
                                                          .inputBorderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors
                                                        .white, // Set the desired background color
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: IntrinsicHeight(
                                                      child: Column(
                                                        children: List.generate(
                                                          controller.projectData
                                                              .length,
                                                          (index) {
                                                            var model = controller
                                                                    .projectData[
                                                                index];
                                                            return Container(
                                                              child: Column(
                                                                children: [
                                                                  TextInput(
                                                                    onPressed:
                                                                        () {
                                                                      controller.selectItems.value = controller
                                                                          .projectData[
                                                                              index]
                                                                          .projectCode
                                                                          .toString();

                                                                      controller
                                                                          .selectProjectList
                                                                          .value = false;
                                                                      controller.userDataProvider.setProjectCode(controller
                                                                          .projectData[
                                                                              index]
                                                                          .projectCode
                                                                          .toString());

                                                                      print("Project Code: " +
                                                                          controller
                                                                              .projectData[index]
                                                                              .projectCode
                                                                              .toString());

                                                                      controller
                                                                          .getProjectList();
                                                                    },
                                                                    margin:
                                                                        false,
                                                                    isSelected: controller
                                                                            .selectItems
                                                                            .value ==
                                                                        controller
                                                                            .projectData[index]
                                                                            .projectCode
                                                                            .toString(),
                                                                    label: "",
                                                                    isEntryField:
                                                                        false,
                                                                    textInputType:
                                                                        TextInputType
                                                                            .text,
                                                                    textColor:
                                                                        Color(
                                                                            0xCC234345),
                                                                    hintText: model
                                                                        .projectCode,
                                                                    onTextChange:
                                                                        (String) {},
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  Visibility(
                                                                    visible: controller
                                                                            .projectData
                                                                            .length !=
                                                                        index +
                                                                            1,
                                                                    child:
                                                                        Container(
                                                                      height: 1,
                                                                      color: AppTheme
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          Center(
                                            child: Button(
                                                widthFactor: 0.9,
                                                heightFactor: 0.06,
                                                onPressed: () {
                                                  controller.userDataProvider
                                                      .setDate(controller
                                                          .currentDate.value);
                                                  print("Currentdat1264234: " +
                                                      controller
                                                          .currentDate.value);

                                                  var result = controller
                                                      .firstValidation();
                                                  if (result) {
                                                    controller
                                                            .selectItems.value =
                                                        "Select Project";
                                                    controller.currentDate
                                                        .value = "Start Date";
                                                    Get.back();
                                                    Get.toNamed(AppRoutes
                                                        .expenseScreen.toName);
                                                  }
                                                },
                                                child: Text("Continue",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontFamily: 'lato',
                                                        fontWeight:
                                                            FontWeight.w600))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (controller.homeScreenData[index].title ==
                              'HRMS') {
                            Get.toNamed(AppRoutes.hRMSHome.toName);
                          } else if (controller.homeScreenData[index].title ==
                              'Support') {
                            if (AppPreference().getEmpId.toString() == "1") {
                              Get.offNamed(AppRoutes.getSupport.toName);
                            } else {
                              Get.offNamed(AppRoutes.supportScreen.toName);
                            }
                          } else if (controller.homeScreenData[index].title ==
                              'Announcement') {
                            Get.to(const AnnouncementPage());
                          } else if (controller.homeScreenData[index].title ==
                              'Office') {
                            Get.toNamed(AppRoutes.officeSummary.toName);
                          } else if (controller.homeScreenData[index].title ==
                              'Maintenance') {
                            Get.to(MaintenanceSummary());
                          } else if (controller.homeScreenData[index].title ==
                              'Ideology') {
                            if (AppPreference().getDepId == 0) {
                              Get.toNamed(AppRoutes.getIdeaLogyEmployee.toName);
                            } else {
                              Get.toNamed(AppRoutes.ideaLogySummary.toName);
                            }
                          } else if (controller.homeScreenData[index].title ==
                              'On Duty') {
                            Get.to(OnDutyScreen());
                          }else if (controller.homeScreenData[index].title ==
                              'Project \n Creation') {
                            Get.to(ProjectCreation());
                          }
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            // side: BorderSide(color: controller.homeScreenData[index].color),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.13,
                            width: MediaQuery.of(context).size.width * 0.32,
                            decoration: BoxDecoration(
                              color: controller.homeScreenData[index].color,
                              borderRadius: BorderRadius.circular(10),
                              // boxShadow: [
                              //   BoxShadow(
                              //       spreadRadius: 0,
                              //       blurRadius: 2)
                              // ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  controller.homeScreenData[index].images
                                      .toString(),
                                  fit: BoxFit.contain,
                                  width: width * 0.2,
                                  height: height * 0.05,
                                ),
                                Text(
                                  controller.homeScreenData[index].title
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      letterSpacing: 0.1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          SizedBox(
            height: 15,
          ),

          // SizedBox(
          //   height: 15,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(AttendanceScreen());
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.liteWhite),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.liteWhite,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.liteWhite,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/Attendance.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "Attendance",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         Get.toNamed(AppRoutes.projectListView.toName);
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.litePink),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.litePink,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.litePink,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/project.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "ProjectList",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(ProjectPage());
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.litePink),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.litePink,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.litePink,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/project.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "Factory",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(CreateFundRequest());
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.liteBlue97),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.liteBlue97,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.liteBlue97,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/fund.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "Fund Request",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         Get.toNamed(AppRoutes.nonProjectListScreen.toName);
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.liteWhite),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.liteWhite,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.liteWhite,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/nonProject.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Center(
          //                 child: Text(
          //                   "Task",
          //                   style: GoogleFonts.poppins(
          //                       color: Colors.black,
          //                       letterSpacing: 0.1,
          //                       fontSize: 15,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return DefaultTabController(
          //               length: 2,
          //               child: AlertDialog(
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(15),
          //                 ),
          //                 content: SingleChildScrollView(
          //                   child: Column(
          //                     children: [
          //                       SizedBox(height: 30),
          //                       Obx(
          //                             () => InkWell(
          //                           onTap: () {
          //                             selectDate(context);
          //                           },
          //                           child: Container(
          //                             height: 50,
          //                             width: double.infinity,
          //                             decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(5),
          //                               color: AppTheme.secondaryColor,
          //                             ),
          //                             child: Row(
          //                               children: [
          //                                 Container(
          //                                   width: MediaQuery.of(context)
          //                                       .size
          //                                       .width *
          //                                       0.55,
          //                                   child: Text(
          //                                     controller.currentDate.value,
          //                                     textAlign: TextAlign.center,
          //                                     style: TextStyle(
          //                                         color: Colors.white),
          //                                   ),
          //                                 ),
          //                                 Icon(
          //                                   Icons.calendar_month,
          //                                   color: Colors.white,
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       SizedBox(height: 30),
          //                       Obx(
          //                             () => InkWell(
          //                           onTap: () {
          //                             controller.selectProjectList.value =
          //                             !controller.selectProjectList.value;
          //                           },
          //                           child: Container(
          //                             height: 70,
          //                             width: double.infinity,
          //                             decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(5),
          //                               color: AppTheme.secondaryColor,
          //                             ),
          //                             child: Row(
          //                               mainAxisAlignment:
          //                               MainAxisAlignment.center,
          //                               children: [
          //                                 Container(
          //                                   width: MediaQuery.of(context)
          //                                       .size
          //                                       .width *
          //                                       0.5,
          //                                   child: Text(
          //                                     textAlign: TextAlign.center,
          //                                     controller.selectItems.value,
          //                                     style: TextStyle(
          //                                         color: Colors.white),
          //                                   ),
          //                                 ),
          //                                 // Icon(
          //                                 //   Icons.calendar_today,
          //                                 //   color: Colors.black,
          //                                 // ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       SizedBox(height: 20),
          //                       Obx(
          //                             () => Visibility(
          //                           visible: controller.selectProjectList.value,
          //                           child: Align(
          //                             alignment: Alignment.centerLeft,
          //                             child: Container(
          //                               width:
          //                               MediaQuery.of(context).size.width *
          //                                   0.6,
          //                               height:  height * 0.3,
          //                               margin:
          //                               EdgeInsets.fromLTRB(12, 0, 12, 0),
          //                               padding:
          //                               EdgeInsets.fromLTRB(6, 4, 0, 6),
          //                               decoration: BoxDecoration(
          //                                 border: Border.all(
          //                                   color: AppTheme.inputBorderColor,
          //                                   width: 1,
          //                                 ),
          //                                 borderRadius:
          //                                 BorderRadius.circular(8),
          //                                 color: Colors
          //                                     .white, // Set the desired background color
          //                               ),
          //                               child: SingleChildScrollView(
          //                                 child: IntrinsicHeight(
          //                                   child: Column(
          //                                     children: List.generate(
          //                                       controller.projectData.length,
          //                                           (index) {
          //                                         var model = controller
          //                                             .projectData[index];
          //                                         return Container(
          //                                           child: Column(
          //                                             children: [
          //                                               TextInput(
          //                                                 onPressed: () {
          //                                                   controller.selectItems
          //                                                       .value =
          //                                                       controller
          //                                                           .projectData[
          //                                                       index]
          //                                                           .projectCode
          //                                                           .toString();
          //
          //                                                   controller
          //                                                       .selectProjectList
          //                                                       .value = false;
          //                                                   controller
          //                                                       .userDataProvider
          //                                                       .setProjectCode(controller
          //                                                       .projectData[
          //                                                   index]
          //                                                       .projectCode
          //                                                       .toString());
          //
          //                                                   print("Project Code: " +
          //                                                       controller
          //                                                           .projectData[
          //                                                       index]
          //                                                           .projectCode
          //                                                           .toString());
          //
          //                                                   controller
          //                                                       .getProjectList();
          //                                                 },
          //                                                 margin: false,
          //                                                 isSelected: controller
          //                                                     .selectItems
          //                                                     .value ==
          //                                                     controller
          //                                                         .projectData[
          //                                                     index]
          //                                                         .projectCode
          //                                                         .toString(),
          //                                                 label: "",
          //                                                 isEntryField: false,
          //                                                 textInputType:
          //                                                 TextInputType.text,
          //                                                 textColor:
          //                                                 Color(0xCC234345),
          //                                                 hintText:
          //                                                 model.projectCode,
          //                                                 onTextChange:
          //                                                     (String) {},
          //                                               ),
          //                                               SizedBox(
          //                                                 height: 2,
          //                                               ),
          //                                               Visibility(
          //                                                 visible: controller
          //                                                     .projectData
          //                                                     .length !=
          //                                                     index + 1,
          //                                                 child: Container(
          //                                                   height: 1,
          //                                                   color: AppTheme
          //                                                       .primaryColor,
          //                                                 ),
          //                                               ),
          //                                             ],
          //                                           ),
          //                                         );
          //                                       },
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       SizedBox(height: 30),
          //                       Center(
          //                         child: Button(
          //                             widthFactor: 0.9,
          //                             heightFactor: 0.06,
          //                             onPressed: () {
          //                               controller.userDataProvider.setDate(
          //                                   controller.currentDate.value);
          //                               print("Currentdat1264234: " +
          //                                   controller.currentDate.value);
          //
          //                               var result =
          //                               controller.firstValidation();
          //                               if (result) {
          //                                 controller.selectItems.value =
          //                                 "Select Project";
          //                                 controller.currentDate.value =
          //                                 "Start Date";
          //                                 Get.back();
          //                                 Get.toNamed(
          //                                     AppRoutes.expenseScreen.toName);
          //                               }
          //                             },
          //                             child: Text("Continue",
          //                                 style: TextStyle(
          //                                     fontSize: 18,
          //                                     color: Colors.white,
          //                                     fontFamily: 'lato',
          //                                     fontWeight: FontWeight.w600))),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             );
          //           },
          //         );
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.subTitleOrange),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.subTitleOrange,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.subTitleOrange,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/expense.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "Expense",
          //                 style: TextStyle(
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w600,
          //                     color: Colors.black),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //
          //     GestureDetector(
          //       onTap: () {
          //         Get.toNamed(AppRoutes.hRMSHome.toName);
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(
          //               color: AppTheme.bottomTabsLabelInActiveColor),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.bottomTabsLabelInActiveColor,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.bottomTabsLabelInActiveColor,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/hrms.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "HRMS",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Card(
          //       elevation: 2,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //         side: BorderSide(color: AppTheme.grey),
          //       ),
          //       child: GestureDetector(
          //         onTap: () {
          //           if(AppPreference().getEmpId.toString() == "1"){
          //             Get.offNamed(AppRoutes.getSupport.toName);
          //           }else{
          //             Get.offNamed(AppRoutes.supportScreen.toName);
          //           }
          //
          //         },
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.grey,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: AppTheme.grey,
          //                   spreadRadius: 0,
          //                   blurRadius: 2,
          //                 )
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/support.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "Support",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(const AnnouncementPage());
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.lite),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.lite,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.lite,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/Announcement.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "Announcement",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         Get.toNamed(AppRoutes.officeSummary.toName);
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.litePink),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.litePink,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.litePink,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/feedback.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "Office",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(MaintenanceSummary());
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.bgGreen),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.bgGreen,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.bgGreen,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/review.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "Maintenance",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         //Get.to(IdeaLogySummaryScreen());
          //         if(AppPreference().getDepId == 0){
          //           Get.toNamed(AppRoutes.getIdeaLogyEmployee.toName);
          //         }else{
          //           Get.toNamed(AppRoutes.ideaLogySummary.toName);
          //         }
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.secondaryColor),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.secondaryColor,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.secondaryColor,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/feedback.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "IdeaLogy",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Row(  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(OnDutyScreen());
          //       },
          //       child: Card(
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: AppTheme.yellow),
          //         ),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height * 0.12,
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           decoration: BoxDecoration(
          //               color: AppTheme.yellow,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: AppTheme.yellow,
          //                     spreadRadius: 0,
          //                     blurRadius: 2)
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset(
          //                 "assets/images/feedback.png",
          //                 fit: BoxFit.contain,
          //                 width: width * 0.2,
          //                 height: height * 0.05,
          //               ),
          //               Text(
          //                 "On Duty",
          //                 style: GoogleFonts.poppins(
          //                     color: Colors.black,
          //                     letterSpacing: 0.1,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Container(
          //       height: MediaQuery.of(context).size.height * 0.12,
          //       width: MediaQuery.of(context).size.width * 0.3,
          //       decoration: BoxDecoration(
          //         color: AppTheme.screenBackground,
          //         // borderRadius: BorderRadius.circular(10),
          //         // boxShadow: [
          //         //   BoxShadow(
          //         //       color: AppTheme.yellow,
          //         //       spreadRadius: 0,
          //         //       blurRadius: 2)
          //         // ]
          //       ),
          //     )
          //   ],),
          // SizedBox(
          //   height: 20,
          // ),

          SizedBox(
            height: 20,
          ),

        ]),
      ),
    ));


  }

}
