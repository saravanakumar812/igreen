import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/UI/OnDuty/OndutyEntryScreen.dart';

import '../../Components/AppTab.dart';
import '../../Components/HorizontalScrollView.dart';
import '../../Controller/GetOnDutyEmployeeListController.dart';
import '../../Controller/OndutyScreenController.dart';
import '../../Controller/OndutySummaryScreenController.dart';
import '../../Utils/AppPreference.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class OnDutyScreen extends GetView<OnDutyScreenController> {
  const OnDutyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnDutyScreenController controller = Get.put(OnDutyScreenController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            flexibleSpace: Container(
              height: 80,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.bottomNavBar.toName);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 23,
                              ),
                              Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  Text(
                    "On Duty Screen",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Spacer(),
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                    width: width * 0.3,
                    height: height * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            controller.userDataProvider.setCurrentStatus('');
            controller.userDataProvider.setCurrentStatus('Add');
            print("AddCode :  " +
                controller.userDataProvider.getCurrentStatus.toString());

            Get.toNamed(AppRoutes.onDutyEntry.toName);
          },
          child: Container(
            width: 45,
            height: 45,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                color: AppTheme.secondaryColor,
                borderRadius: BorderRadius.circular(22.5)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => HorizontalScrollView(
                      children: List.generate(
                        controller.listValues.length,
                        (index) {
                          var model = controller.listValues[index];
                          return AppTab(
                            title: model.value,
                            isSelected:
                                controller.selectedTabIndex.value == index,
                            onClick: () =>
                                controller.updateCurrentTabIndex(index),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () =>  controller.selectedTabIndex.value == 1 ? HorizontalScrollView(
                      children: List.generate(
                        controller.listValuesOne.length,
                        (index) {
                          var model = controller.listValuesOne[index];
                          return AppTab(
                            title: model.value,
                            isSelected:
                                controller.selectedTabIndexOne.value == index,
                            onClick: () =>
                                controller.updateCurrentTabIndexOne(index),
                          );
                        },
                      ),
                    ): Container(),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Obx(() => controller.isLoading.value
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 10,
                      child: Center(child: CircularProgressIndicator()))
                  : Column(
                  children: [
                      if (controller.selectedTabIndex.value == 0)
                        RefreshIndicator(
                          onRefresh: controller.refreshData,
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 100,
                                child: ListView.builder(
                                    itemCount: controller.onDutyEmployeeData.length,

                                    padding: const EdgeInsets.only(bottom: 40),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return summaryList(context, index);
                                    }),
                              ),

                            ],
                          ),
                        )
                      else if (controller.selectedTabIndex.value == 1)
                        RefreshIndicator(
                          onRefresh: controller.refreshData,
                          child: Column(
                            children: [

                              Obx(() =>
                          controller.selectedTabIndex.value == 1 && controller.selectedTabIndexOne.value == 0 ?
                        RefreshIndicator(
                        onRefresh: controller.refreshData,
                          child: Column(
                            children: [
                              Container(
                                height:
                                MediaQuery.of(context).size.height - 200,
                                child: ListView.builder(
                                    itemCount: controller.onDutyPendingData.length,
                                    padding: const EdgeInsets.only(bottom: 40),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return pendingList(context, index);
                                    }),
                              ),

                            ],
                          ),
                        )
                            : controller.selectedTabIndex.value == 1 && controller.selectedTabIndexOne.value == 1 ?
                        RefreshIndicator(
                          onRefresh: controller.refreshData,
                          child: Column(
                            children: [
                              Container(
                                height:
                                MediaQuery.of(context).size.height - 250,
                                child: ListView.builder(
                                    itemCount:
                                    controller.onDutyApprovedData.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: 40),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return approveList(context, index);
                                    }),
                              ),
                            ],
                          ),
                        ) :
                        controller.selectedTabIndex.value == 1 && controller.selectedTabIndexOne.value == 2  ?
                        RefreshIndicator(
                          onRefresh: controller.refreshData,
                          child: Column(
                            children: [
                              Container(
                                height:
                                MediaQuery.of(context).size.height - 250,
                                child: ListView.builder(
                                    itemCount:
                                    controller.onDutyRejectedData.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: 40),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return rejectList(context, index);
                                    }),
                              ),
                            ],
                          ),
                        ) : Container()








                              )
                            ],
                          ),
                        )

                    ])),

            ],
          ),
        ),
      ),
    );
  }
}

Widget summaryList(BuildContext context, int index) {
  OnDutyScreenController controller = Get.put(OnDutyScreenController());

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  var model = controller.onDutyEmployeeData[index];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 22,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'OnDuty',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Spacer(),
                    // InkWell(
                    //   onTap: () {
                    //     controller.selectedValues.value = index;
                    //     controller.statusUpdate();
                    //   },
                    //   child: Icon(
                    //     Icons.delete,
                    //     color: Colors.black,
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            controller.onDutyEmployeeData[index].startingDate.toString() != "null"
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Starting Date:',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            controller.onDutyEmployeeData[index].startingDate
                                .toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                : Container(),
            controller.onDutyEmployeeData[index].endingDate.toString() != "null"
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'End Date:',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            controller.onDutyEmployeeData[index].endingDate.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                : Container(),
            controller.onDutyEmployeeData[index].remarks.toString() != "null"
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Remarks:',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            controller.onDutyEmployeeData[index].remarks.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                : Container(),
            controller.onDutyEmployeeData[index].ondutyStatus.toString() != "null"
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'OnDuty Status:',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            controller.onDutyEmployeeData[index].ondutyStatus
                                .toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.userDataProvider
                        .setOnDutyEmployee(controller.onDutyEmployeeData[index]);
                    controller.userDataProvider.setCurrentStatus('');
                    controller.userDataProvider
                        .setCurrentStatus(controller.editButtonText.value);

                    Get.offNamed(AppRoutes.onDutyEntry.toName);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    width: width * 0.18,
                    height: height * 0.045,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromARGB(255, 179, 176, 176),
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      controller.editButtonText.value,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          letterSpacing: 0.1,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.userDataProvider
                        .setOnDutyEmployee(controller.onDutyEmployeeData[index]);
                    controller.userDataProvider.setCurrentStatus('');
                    controller.userDataProvider
                        .setCurrentStatus(controller.reuseButtonText.value);
                    Get.offNamed(AppRoutes.onDutyEntry.toName);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                    width: width * 0.2,
                    height: height * 0.045,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromARGB(255, 179, 176, 176),
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      controller.reuseButtonText.value,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          letterSpacing: 0.1,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      SizedBox(
        height: 50,
      )
    ],
  );
}

Widget pendingList(BuildContext context, int index) {
  OnDutyScreenController controller = Get.put(OnDutyScreenController());
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
var model = controller.onDutyPendingData[index] ;
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: ListTile(
      onTap: () {
        controller.userDataProvider.setOnDutyPending(model);
        Get.toNamed(AppRoutes.onDutyPending.toName);
      },
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.green,
        child: Container(
          height: 22,
          width: 25,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            (index + 1).toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "OnDuty Pending",
            style: GoogleFonts.poppins(
                color: Colors.black,
                letterSpacing: 0.1,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Starting Date :",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                controller.onDutyPendingData[index].startingDate.toString(),
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Closing Date :",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                controller.onDutyPendingData[index].endingDate.toString(),
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Remarks :",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                controller.onDutyPendingData[index].remarks.toString(),
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    ),
  );
}


Widget approveList(BuildContext context, int index) {
  OnDutyScreenController controller = Get.put(OnDutyScreenController());

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  var model = controller.onDutyApprovedData[index];
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: ListTile(
      onTap: () {
        controller.userDataProvider.setOnDutyApproved(model);
        Get.toNamed(AppRoutes.onDutyApproval.toName);
      },
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.green,
        child: Container(
          height: 22,
          width: 25,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            (index + 1).toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "OnDuty Approved",
            style: GoogleFonts.poppins(
                color: Colors.black,
                letterSpacing: 0.1,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Starting Date :",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                controller.onDutyApprovedData[index].startingDate.toString(),
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Closing Date :",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                controller.onDutyApprovedData[index].endingDate.toString(),
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Remarks :",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                controller.onDutyApprovedData[index].remarks.toString(),
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          // Row(
          //   children: [
          //     Text(
          //       "OnDuty Status :",
          //       style: GoogleFonts.poppins(
          //           color: Colors.black,
          //           letterSpacing: 0.1,
          //           fontSize: 13,
          //           fontWeight: FontWeight.w600),
          //     ),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     Text(
          //       controller.onDutyApprovedData[index].ondutyStatus.toString(),
          //       style: GoogleFonts.poppins(
          //           color: Colors.black,
          //           letterSpacing: 0.1,
          //           fontSize: 12,
          //           fontWeight: FontWeight.w600),
          //     )
          //   ],
          // )
        ],
      ),
    ),
  );
}

Widget rejectList(BuildContext context, int index) {
  OnDutyScreenController controller = Get.put(OnDutyScreenController());

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  var model = controller.onDutyRejectedData[index];
  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        onTap: () {
         controller.userDataProvider.setOnDutyRejected(model);
          Get.toNamed(AppRoutes.onDutyReject.toName);
        },
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.green,
          child: Container(
            height: 22,
            width: 25,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              (index + 1).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "OnDuty Rejected",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  letterSpacing: 0.1,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "Starting Date :",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      letterSpacing: 0.1,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  controller.onDutyRejectedData[index].startingDate.toString(),
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      letterSpacing: 0.1,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "Closing Date :",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      letterSpacing: 0.1,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  controller.onDutyRejectedData[index].endingDate.toString(),
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      letterSpacing: 0.1,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "Remarks :",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      letterSpacing: 0.1,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  controller.onDutyRejectedData[index].remarks.toString(),
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      letterSpacing: 0.1,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            // Row(
            //   children: [
            //     Text(
            //       "OnDuty Status :",
            //       style: GoogleFonts.poppins(
            //           color: Colors.black,
            //           letterSpacing: 0.1,
            //           fontSize: 13,
            //           fontWeight: FontWeight.w600),
            //     ),
            //     const SizedBox(
            //       width: 8,
            //     ),
            //     Text(
            //       controller.onDutyRejectedData[index].ondutyStatus.toString(),
            //       style: GoogleFonts.poppins(
            //           color: Colors.black,
            //           letterSpacing: 0.1,
            //           fontSize: 12,
            //           fontWeight: FontWeight.w600),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    ),
  );
}