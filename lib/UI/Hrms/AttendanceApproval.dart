import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/Controller/AttendanceApprovalController.dart';
import 'package:igreen_flutter/forms/theme.dart';

import '../../forms/forms.dart';

class AttendanceApproval extends GetView<AttendanceApprovalController> {
  const AttendanceApproval({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AttendanceApprovalController controller =
        Get.put(AttendanceApprovalController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.screenBackground,
        floatingActionButton: Obx(
          () => Visibility(
            visible: controller.pendingVisible.value,
            child: GestureDetector(
              onTap: () {
                controller.attendance(1);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Approve',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size(100, 70),
          child: AppBar(
            backgroundColor: AppTheme.screenBackground,
            automaticallyImplyLeading: false,
            bottomOpacity: 0.0,
            elevation: 0.0,
            flexibleSpace: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
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
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        'Attendance List',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.contain,
                          width: width * 0.2,
                          height: height * 0.05,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      controller.pendingVisible.value = false;
                      controller.completedVisible.value = true;
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: width * 0.4,
                      height: height * 0.15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Obx(
                              () => Text(
                                controller.attendanceCompleteData.length
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Text(
                            'Completed',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.completedVisible.value = false;
                      controller.pendingVisible.value = true;
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: width * 0.4,
                      height: height * 0.15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Obx(
                              () => Text(
                                controller.attendanceData.length.toString(),
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Text(
                            'Pending',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Obx(
                () => Visibility(
                  visible: controller.pendingVisible.value,
                  child: GestureDetector(
                    onTap: () {
                      controller
                          .onSelectAll(!controller.selectAllCheckValue.value);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Checkbox(
                          value: controller.selectAllCheckValue.value,
                          onChanged: (bool? value) {
                            if (value != null) {
                              controller.selectAllCheckValue.value = value;
                              controller.isLoading.value = true;

                              for (int i = 0;
                                  i < controller.onClickList.length;
                                  i++) {
                                controller.onClickList[i] = value;
                              }

                              controller.isLoading.value = false;
                              controller.update();
                              print('Select');
                            }
                          },
                          activeColor: AppTheme.secondaryColor,
                        ),
                        Text(
                          'Select All',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            letterSpacing: 0.1,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.attendanceData!.isNotEmpty
                        ? SingleChildScrollView(
                            child: RefreshIndicator(
                              onRefresh: controller.refreshData,
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: controller.pendingVisible.value,
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                10,
                                        child: Obx(
                                          () => ListView.builder(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            itemCount: controller
                                                .attendanceData.length,
                                            itemBuilder: (context, index) {
                                              return Obx(() =>
                                                  pendingApprovalList(
                                                      context, index));
                                            },
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 100),
                                  Image.asset(
                                    "assets/images/noData.png",
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
              ),
              Obx(
                () => controller.isLoading.value
                    ? Visibility(
                        visible: controller.completedVisible.value,
                        child: Center(child: CircularProgressIndicator()))
                    : controller.attendanceCompleteData!.isNotEmpty
                        ? SingleChildScrollView(
                            child: RefreshIndicator(
                              onRefresh: controller.refreshData,
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height - 10,
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(bottom: 10),
                                      itemCount: controller
                                          .attendanceCompleteData.length,
                                      itemBuilder: (context, index) {
                                        return completeApprovalList(
                                            context, index);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 100),
                                  Image.asset(
                                    "assets/images/noData.png",
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pendingApprovalList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.attendanceData[index];

    return Column(
      children: [
        Container(
          width: width,
          height: height * 0.26,
          margin: EdgeInsets.all(25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.liteWhite),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                        "assets/images/profile_dummy.jpg",
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: width * 0.6,
                margin: EdgeInsets.only(left: 10, bottom: 17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            children: <Widget>[
                              Obx(() => Checkbox(
                                    value: controller.onClickList[index],
                                    onChanged: (bool? value) {
                                      if (value != null) {
                                        controller.onClickList[index] =
                                            !controller.onClickList[index];
                                      }
                                    },
                                    activeColor: AppTheme.secondaryColor,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Name :',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 250,
                            child: Text(
                              model.profileName.toString() ?? "",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Date :',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            model.attendanceDate.toString() ?? "",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'StarTime :',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            model.startTime.toString() ?? "",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'EndTime :',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            model.endTime.toString() ?? "",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Button2(
                            widthFactor: 0.28,
                            heightFactor: 0.04,
                            onPressed: () {
                              controller.attendanceApprove.value = index;
                              controller.attendance(2);
                            },
                            child: Text(
                              "Reject",
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35,
        ),
      ],
    );
  }

  Widget completeApprovalList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.attendanceCompleteData[index];
    return Column(
      children: [
        Container(
          width: width,
          height: height * 0.23,
          margin: EdgeInsets.all(25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.liteWhite),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                        "assets/images/profile_dummy.jpg",
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: width * 0.6,
                margin: EdgeInsets.only(left: 10, bottom: 17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Name :',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            model.profileName.toString() ?? "",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Date :',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            model.attendanceDate.toString() ?? "",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'StarTime :',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            model.startTime.toString() ?? "",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'EndTime :',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            model.endTime.toString() ?? "",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            model.attendanceApproval.toString() == '1'
                                ? "Approve"
                                : "Reject",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
