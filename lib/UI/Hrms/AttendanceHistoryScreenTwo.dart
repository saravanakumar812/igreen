import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../forms/theme.dart';
import '../../Controller/AttendanceHistoryScreenTwoController.dart';
import '../../forms/forms.dart';

class AttendanceHistoryScreenTwo
    extends GetView<AttendanceHistoryScreenTwoController> {
  const AttendanceHistoryScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AttendanceHistoryScreenTwoController controller =
        Get.put(AttendanceHistoryScreenTwoController());
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
                                    height: 6,
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
                        'Attendance History',
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: width * 0.32,
                    height: height * 0.09,
                    margin: EdgeInsets.only(top: 0, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Select year",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                letterSpacing: 0.1,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Select year",
                                style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(
                                        255, 155, 152, 152),
                                    letterSpacing: 0.1,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Icon(Icons.calendar_month))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.userLeaveData!.isNotEmpty
                        ? SingleChildScrollView(
                            child: RefreshIndicator(
                              onRefresh: controller.refreshData,
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height -
                                        100,
                                    child: ListView.builder(
                                      itemCount:
                                          controller.userLeaveData.length,
                                      itemBuilder: (context, index) {
                                        return userList(context, index);
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

  Widget userList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.userLeaveData[index];

    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Card(
              color: AppTheme.selectedOrange,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage("assets/images/profile_dummy.jpg"),
                ),
                title: Text(
                  model.fromDate.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                subtitle: Text(
                    model.approved.toString() == '1'
                        ? "Present"
                        : model.approved.toString() == '2'
                            ? "Leave"
                            : "Progress",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black)),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
