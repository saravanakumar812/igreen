import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/Controller/LeaveApprovalController.dart';

import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class LeaveApproval extends GetView<LeaveApprovalController> {
  const LeaveApproval({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveApprovalController controller = Get.put(LeaveApprovalController());
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
              decoration: BoxDecoration(
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
                    'Leave List',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => LeaveApplyScreen()),
                      // );
                    },
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                      width: width * 0.2,
                      height: height * 0.05,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.leaveListData!.isNotEmpty
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: controller.refreshData,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height - 100,
                              child: ListView.builder(
                                itemCount: controller.leaveListData.length,
                                itemBuilder: (context, index) {
                                  return LeaveList(context, index);
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
      ),
    );
  }

  Widget LeaveList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.leaveListData[index];
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 10,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                controller.userDataProvider.setLeaveDataValues(model);
                Get.toNamed(AppRoutes.leaveApplyScreen.toName);
              },
              minVerticalPadding: 20,
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/profile_dummy.jpg"),
              ),
              title: Text(model.profileName.toString()),
              subtitle: Text("Reason:${model.reason}"),
            ),
          ],
        ),
      ),
    );
  }
}
