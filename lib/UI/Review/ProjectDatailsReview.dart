import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/ProjectReviewController.dart';
import 'package:igreen_flutter/forms/forms.dart';
import '../../forms/theme.dart';

class ProjectDetailsReview extends GetView<ProjectReviewController> {
  const ProjectDetailsReview({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ProjectReviewController controller = Get.put(ProjectReviewController());

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
                        Get.back();
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
                  "Project Details ",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.grey)),
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
                      Text(
                        "Project Details ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        controller.factoryData.customerName.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Company Name ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        controller.factoryData.companyName.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Address ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        controller.factoryData.companyAddress.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mobile No :",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        controller.factoryData.mobileNum.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "GST ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        controller.factoryData.gST.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
            ),
            TextInput(
              // controller: controller.subCategory1Controller,
              height: 100,
              label: "",
              onPressed: () {
                if (controller.isSelected.value) {
                  controller.isSelected.value = false;
                } else {
                  controller.isSelected.value = true;
                }
              },
              textInputType: TextInputType.text,
              textColor: Color(0xCC252525),
              hintText: "Team Updates",
              obscureText: true,
              isReadOnly: true,
              onTextChange: (String) {},
            ),
            Obx(
              () => controller.isLoading.value
                  ? Visibility(
                      visible: controller.isSelected.value,
                      child: Center(child: CircularProgressIndicator()))
                  : controller.completedData!.isNotEmpty
                      ? SingleChildScrollView(
                          child: RefreshIndicator(
                            onRefresh: controller.refreshData,
                            child: Column(
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.22,
                                    child: Obx(
                                      () => ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 10),
                                        itemCount:
                                            controller.completedData.length,
                                        itemBuilder: (context, index) {
                                          return updates(context, index);
                                        },
                                      ),
                                    )),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Updates ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: TextField(
                    maxLines: 3,
                    controller: controller.messageController,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.grey),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: 'Enter Your Message',
                      labelText: 'Message',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: AppTheme.grey // Choose the desired alignment
                          ),
                      labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppTheme.grey // Choose the desired alignment
                          ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    controller.startRecord();
                    Fluttertoast.showToast(
                      msg: "Record Starting",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                  },
                  onTapUp: (TapUpDetails details) {
                    controller.stopRecord();
                    controller.isAudio.value = true;
                    Fluttertoast.showToast(
                      msg: "Record Stop",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppTheme.liteWhite),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          color: AppTheme.liteWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: AppTheme.liteWhite,
                                spreadRadius: 0,
                                blurRadius: 2)
                          ]),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mic,
                            size: 40,
                          ),
                          Text(
                            "Hold",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Button(
                  widthFactor: 0.9,
                  heightFactor: 0.06,
                  onPressed: () {
                    controller.managerApproval();
                  },
                  child: Text("SUBMIT",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w600))),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }

  Widget updates(BuildContext context, int index) {
    ProjectReviewController controller = Get.put(ProjectReviewController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.completedData[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.grey)),
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
                      Text(
                        "Task Details ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Employee Name ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.employeeName.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Updates ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.projectUpdate.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AssignedStartDate ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.assignedStartDate.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AssignedEndDate :",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.assignedEndDate.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Team CompleteDate ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.endDate.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1,
        )
      ],
    );
  }
}
