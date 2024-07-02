import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/GetOnDutyEmployeeListController.dart';
import '../../forms/theme.dart';
import 'OndutyScreen.dart';

class GetOnDutyEmployeeScreen extends GetView<GetOnDutyEmployeeListController> {
  const GetOnDutyEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    GetOnDutyEmployeeListController controller =
        Get.put(GetOnDutyEmployeeListController());

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
                          // Get.offNamed(AppRoutes.bottomNavBar.toName);
                          Get.to(OnDutyScreen());
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
                    width: 50,
                  ),
                  const Text(
                    "OnDuty Employee Summary",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Spacer(),
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                    width: width * 0.2,
                    height: height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.onDutyEmployeeData!.isNotEmpty
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: controller.refreshData,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height - 100,
                              child: ListView.builder(
                                itemCount: controller.onDutyEmployeeData.length,
                                itemBuilder: (context, index) {
                                  return summaryList(context, index);
                                },
                              ),
                            )
                          ],
                        ),
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
        ),
      ),
    );
  }

  Widget summaryList(BuildContext context, int index) {
    GetOnDutyEmployeeListController controller =
        Get.put(GetOnDutyEmployeeListController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //var model = controller.onDutyData[index];
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
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              controller.onDutyEmployeeData[index].startingDate.toString() !=
                      "null"
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
              controller.onDutyEmployeeData[index].endingDate.toString() !=
                      "null"
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
                              controller.onDutyEmployeeData[index].endingDate
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
                              controller.onDutyEmployeeData[index].remarks
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
                      controller.userDataProvider.setOnDutyEmployee(
                          controller.onDutyEmployeeData[index]);
                      controller.userDataProvider.setCurrentStatus('');
                      controller.userDataProvider
                          .setCurrentStatus(controller.editButtonText.value);
                      //Get.offNamed(AppRoutes.onDutyEntry.toName);
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
                        "Approve ",
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
                      controller.userDataProvider.setOnDutyEmployee(
                          controller.onDutyEmployeeData[index]);
                      controller.userDataProvider.setCurrentStatus('');
                      controller.userDataProvider
                          .setCurrentStatus(controller.reuseButtonText.value);
                      //Get.offNamed(AppRoutes.onDutyEntry.toName);
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
                        "Reject",
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
}
