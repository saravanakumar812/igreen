import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/AppTab.dart';
import '../../Components/HorizontalScrollView.dart';
import '../../Controller/GetSupportScreenController.dart';
import '../../Controller/IdeaLogySummaryController.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class GetSupportScreen extends GetView<GetSupportScreenController> {
  const GetSupportScreen({super.key});



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    GetSupportScreenController controller = Get.put(GetSupportScreenController());

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
                            Get.offNamed(AppRoutes.bottomNavBar.toName);
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
                    const Text(
                      "Get Support Screen",
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
                : controller.getSupportData!.isNotEmpty
                ? SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: controller.refreshData,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      child: ListView.builder(
                        itemCount: controller.getSupportData.length,
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
    GetSupportScreenController controller = Get.put(GetSupportScreenController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.getSupportData[index];
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
                        "Get Support",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Spacer(),
                      // RefreshIndicator(
                      //   onRefresh: controller.refreshDeleteData,
                      //   child: InkWell(
                      //     onTap: () {
                      //       controller.deleteIdeas.value = index;
                      //       controller.deleteIdea();
                      //     },
                      //     child: Icon(
                      //       Icons.delete,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              controller.getSupportData[index].employeeName.toString() != "null"
                  ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Employee Name :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.employeeName ?? "",
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
              controller.getSupportData[index].mobile.toString() != "null"
                  ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Mobile Number:',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.mobile ?? "",
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
              controller.getSupportData[index].messages.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Messages:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              model.messages ?? "",
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         controller.userDataProvider
              //             .setUserIdeaLogy(controller.ideologyUserData[index]);
              //         controller.userDataProvider.setCurrentStatus('');
              //         controller.userDataProvider
              //             .setCurrentStatus(controller.editButtonText.value);
              //         Get.offNamed(AppRoutes.ideaLogyEntry.toName);
              //       },
              //       child: Container(
              //         margin: EdgeInsets.only(top: 5),
              //         width: width * 0.18,
              //         height: height * 0.045,
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             border: Border.all(
              //                 color: Color.fromARGB(255, 179, 176, 176),
              //                 width: 1),
              //             borderRadius: BorderRadius.circular(10)),
              //         child: Center(
              //             child: Text(
              //               "Edit",
              //               style: GoogleFonts.poppins(
              //                   color: Colors.black,
              //                   letterSpacing: 0.1,
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w600),
              //             )),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }

  Widget employeeList(BuildContext context, int index) {
    IdeaLogySummaryController controller = Get.put(IdeaLogySummaryController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.ideologyEmployeeData[index];
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListTile(
                onTap: () {
                  controller.userDataProvider
                      .setEmployeeIdeaLogy(controller.ideologyEmployeeData[index]);
                  Get.toNamed(AppRoutes.ideaAgree.toName);
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
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Ideas :',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          model.ideas ?? "",
                          style: const TextStyle(
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
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Employee Name:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          model.employeeName ?? "",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
