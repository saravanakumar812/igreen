import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/ProjectContoller/TechnicalPageController.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class TechnicalPage extends GetView<TechnicalPageController> {
  const TechnicalPage({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TechnicalPageController controller = Get.put(TechnicalPageController());
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
                        width: 60,
                      ),
                      Text(
                        "Technical Manager",
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
                  : controller.technicalData!.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 100,
                                child: ListView.builder(
                                  itemCount: controller.technicalData.length,
                                  itemBuilder: (context, index) {
                                    return technicalTeamList(context, index);
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      : Center(
                          child: Container(
                            child: Image.asset(
                              height: 250,
                              width: 250,
                              "assets/images/noData.png",
                            ),
                          ),
                        ),
            )));
  }
}

Widget technicalTeamList(BuildContext context, int index) {
  TechnicalPageController controller = Get.put(TechnicalPageController());
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  var model = controller.technicalData[index];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Container(
                  height: 22,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(18),
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
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Technical Team',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Customer Name :",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  model.customerName ?? "",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  'ProjectName:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.technicalData[index].projectName.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  'ProjectType',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.technicalData[index].projectType.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  'ProjectCode:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.technicalData[index].projectCode.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  'ProjectDocuments:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.technicalData[index].projectDocuments.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  'ProjectDescp:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.technicalData[index].projectDescp.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  'CustomerRequiredDate:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.technicalData[index].customerRequiredDate
                      .toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  'DispatchCommittedDate:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.technicalData[index].dispatchCommittedDate
                      .toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  'TechnicalUpload:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.technicalData[index].technicalUpload.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Process:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.technicalData[index].process.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.userDataProvider.setTechnicalData(controller.technicalData[index]);
                    Get.toNamed(AppRoutes.technicalUpdate.toName);
                  },
                  child: Container(
                    margin: EdgeInsets.all(15),
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
