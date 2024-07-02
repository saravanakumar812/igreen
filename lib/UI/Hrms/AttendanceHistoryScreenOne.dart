import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/forms/theme.dart';
import 'package:igreen_flutter/routes/app_routes.dart';
import '../../Controller/AttendanceHistoryScreenOneController.dart';

class AttendanceHistoryScreenOne
    extends GetView<AttendanceHistoryScreenOneController> {
  const AttendanceHistoryScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AttendanceHistoryScreenOneController controller =
        Get.put(AttendanceHistoryScreenOneController());
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
        body: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.userData!.isNotEmpty
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: controller.refreshData,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height - 10,
                              child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 10),
                                itemCount: controller.userData.length,
                                itemBuilder: (context, index) {
                                  return userList(context, index);
                                },
                              ),
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
      ),
    );
  }

  Widget userList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AttendanceHistoryScreenOneController controller =
        Get.put(AttendanceHistoryScreenOneController());
    var model = controller.userData[index];
    return Column(
      children: [
        InkWell(
          onTap: () {
            controller.userDataProvider
                .setAttendanceEmpIdData(controller.userData[index].employeeId);

            print(
                "5434862847:${controller.userDataProvider.getAttendanceEmpId}");
            Get.toNamed(AppRoutes.attendanceHistoryScreenTwo.toName);
          },
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/profile_dummy.jpg"),
              ),
              title: Text(model.employeeName.toString()),
              subtitle: Text(""),
            ),
          ),
        ),
      ],
    );
  }
}
