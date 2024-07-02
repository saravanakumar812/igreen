import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/AssignMechanicalTeamController.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import 'package:intl/intl.dart';

class AssignMechanicalTeam extends GetView<AssignMechanicalTeamController> {
  const AssignMechanicalTeam({super.key});

  Future<void> startDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.startDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> endDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.endDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    AssignMechanicalTeamController controller =
        Get.put(AssignMechanicalTeamController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.appColor,
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
                    "Assign ",
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                          controller.userDataProvider.getCommercialFromTechnicalResponseData!
                              .customerName
                              .toString(),
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
                          controller.userDataProvider.getCommercialFromTechnicalResponseData!
                              .companyName
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
                          controller.userDataProvider.getCommercialFromTechnicalResponseData!
                              .companyAddress
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
                          controller
                              .userDataProvider.getCommercialFromTechnicalResponseData!.mobileNum
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
                          controller.userDataProvider.getCommercialFromTechnicalResponseData!.gST
                              .toString(),
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
                controller: controller.teamSelection,
                height: 100,
                label: "Type",
                onPressed: () {
                  if (controller.factoryDepartment.value) {
                    controller.factoryDepartment.value = false;
                  } else {
                    controller.factoryDepartment.value = true;
                  }
                },
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Select Type",
                obscureText: true,
                isReadOnly: true,
                onTextChange: (String) {},
              ),
              Obx(() => Visibility(
                    visible: controller.factoryDepartment.value,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                      padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.inputBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white, // Set the desired background color
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: List.generate(
                            controller.factoryDepartmentData.length,
                            (index) {
                              var model =
                                  controller.factoryDepartmentData[index];
                              return Container(
                                child: Column(
                                  children: [
                                    TextInput(
                                      onPressed: () {
                                        controller.teamSelection.text =
                                            controller
                                                .factoryDepartmentData[index]
                                                .department!;
                                        controller.factoryDepartment.value =
                                            false;
                                        controller.getFactoryDepartmentTeam();
                                        controller.depId.value = controller
                                            .factoryDepartmentData[index]
                                            .departmentId
                                            .toString();
                                        controller.getFactoryEmployee(controller
                                            .factoryDepartmentData[index]
                                            .departmentId);
                                        controller.staffDetails.text = '';
                                      },
                                      margin: false,
                                      isSelected:
                                          controller.teamSelection.text ==
                                              controller
                                                  .factoryDepartmentData[index]
                                                  .department,
                                      label: "",
                                      isEntryField: false,
                                      textInputType: TextInputType.text,
                                      textColor: Color(0xCC234345),
                                      hintText: model.department,
                                      obscureText: true,
                                      onTextChange: (String) {},
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Visibility(
                                        visible: controller
                                                .factoryDepartmentData.length !=
                                            index + 1,
                                        child: Container(
                                          height: 1,
                                          color: AppTheme.appBlack,
                                        ))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  )),
              TextInput(
                controller: controller.staffDetails,
                height: 100,
                label: "Staff Details",
                onPressed: () {
                  if (controller.factoryEmployee.value) {
                    controller.factoryEmployee.value = false;
                  } else {
                    controller.factoryEmployee.value = true;
                  }
                },
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: " Select Staff Details",
                obscureText: true,
                isReadOnly: true,
                onTextChange: (String) {},
              ),
              Column(
                children: [
                  Obx(
                    () => controller.factoryEmployeeData.isNotEmpty
                        ? Visibility(
                            visible: controller.factoryEmployee.value,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                              padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppTheme.inputBorderColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors
                                    .white, // Set the desired background color
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  children: List.generate(
                                    controller.factoryEmployeeData.length,
                                    (index) {
                                      var model =
                                          controller.factoryEmployeeData[index];
                                      return Container(
                                        child: Column(
                                          children: [
                                            TextInput(
                                              onPressed: () {
                                                controller.staffDetails.text =
                                                    controller
                                                        .factoryEmployeeData[
                                                            index]
                                                        .employeeName!;
                                                controller.factoryEmployee
                                                    .value = false;
                                              },
                                              margin: false,
                                              isSelected: controller
                                                      .staffDetails.text ==
                                                  controller
                                                      .factoryEmployeeData[
                                                          index]
                                                      .employeeName,
                                              label: "",
                                              isEntryField: false,
                                              textInputType: TextInputType.text,
                                              textColor: Color(0xCC234345),
                                              hintText: model.employeeName,
                                              obscureText: true,
                                              onTextChange: (String) {},
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Visibility(
                                                visible: controller
                                                        .factoryEmployeeData
                                                        .length !=
                                                    index + 1,
                                                child: Container(
                                                  height: 1,
                                                  color: AppTheme.appBlack,
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Text(
                            'NO DATA',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w600),
                          ),
                  )
                ],
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
              Row(children: [
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: (width / 2) - 10,
                  child: TextInput(
                    onPressed: () {
                      startDate(context);
                    },
                    controller: controller.startDateController,
                    height: 100,
                    isReadOnly: true,
                    label: "Start Date",
                    onTextChange: (text) {},
                    textInputType: TextInputType.phone,
                    textColor: Color(0xCC252525),
                    hintText: "Select Start Date",
                    sufficIcon: Icon(
                      Icons.calendar_month,
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Container(
                  width: (width / 2) - 10,
                  child: TextInput(
                      onPressed: () {
                        endDate(context);
                      },
                      controller: controller.endDateController,
                      height: 100,
                      isReadOnly: true,
                      label: "End Date",
                      onTextChange: (text) {},
                      textInputType: TextInputType.phone,
                      textColor: Color(0xCC252525),
                      hintText: "Select End Date",
                      sufficIcon: Icon(
                        Icons.calendar_month,
                      ),
                      obscureText: true),
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
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
                      controller.updateAssignProjectTeam();
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
      ),
    );
  }
}
