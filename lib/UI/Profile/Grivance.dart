import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/GriVanceController.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class GriVance extends GetView<GriVanceController> {
  const GriVance({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    GriVanceController controller = Get.put(GriVanceController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.screenBackground,
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.offNamed(AppRoutes.griVanceCreateScreen.toName);
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
       // backgroundColor: AppTheme.profileColor,
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
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Text(
                    'Escalation List',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                      width: width * 0.3,
                      height: height * 0.1,
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
              : controller.getData!.isNotEmpty
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: controller.refreshData,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height - 100,
                              child: ListView.builder(
                                itemCount: controller.getData.length,
                                itemBuilder: (context, index) {
                                  return griVanceList(context, index);
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

  Widget griVanceList(BuildContext context, int index) {
    GriVanceController controller = Get.put(GriVanceController());
    var model = controller.getData[index];

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
          onTap: () {
            controller.userDataProvider.setEscalationListValues(model);
            controller.getData[index].escalationStatus.toString() == '0'
                ? Get.toNamed(AppRoutes.escalationPending.toName)
                : Get.toNamed(AppRoutes.escalationThree.toName);

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
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          title: Text(
            model.escalationDate.toString() ?? "",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          trailing: Container(
              child:
                  controller.getData[index].escalationStatus.toString() == '0'
                      ? Container(
                          child: Text("Pending",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.tabOrange)))
                      : Icon(Icons.remove_red_eye_outlined))),
    );
  }
}
