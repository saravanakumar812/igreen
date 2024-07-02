import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/ReminderAddController.dart';
import 'package:intl/intl.dart';
import '../../Components/AppTab.dart';
import '../../Components/HorizontalScrollView.dart';
import '../../Utils/AppPreference.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class AddReminder extends GetView<ReminderAddController> {
  const AddReminder({super.key});

  bool selectableDay(DateTime day) {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime dayBeforeYesterday = today.subtract(Duration(days: 2));

    return day.year == today.year &&
        day.month == today.month &&
        (day.day == today.day ||
            day.day == yesterday.day ||
            day.day == dayBeforeYesterday.day);
  }

  Future<void> startDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
        //selectableDayPredicate: selectableDay,
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
        selectableDayPredicate: selectableDay,
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ReminderAddController controller = Get.put(ReminderAddController());
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
                  "Add Reminder ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Spacer(),
                Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                  width: width * 0.3,
                  height: height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(





          child: Column(
        children: [

          Obx(
                () => HorizontalScrollView(
              children: List.generate(
                controller.listValues.length,
                    (index) {
                  var model = controller.listValues[index];
                  return AppTab(
                      title: model.value,
                      isSelected:
                      controller.selectedTabIndex.value == index,
                      onClick: () {
                        controller.updateCurrentTabIndex(index);
                        //controller.selectedTabIndex.value = index == 0 ? 0 : 1;
                        // controller
                        //         .listValues[
                        //             controller.selectedTabIndex.value]
                        //         .value ==
                        //     "User";
                      }

                    //
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Obx(() => controller.isLoading.value
              ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 10,
              child: Center(child: CircularProgressIndicator()))
              : Column(children: [
            if (controller.selectedTabIndex.value == 0)
              Column(
                children: [
                  Container(
                    height:
                    MediaQuery.of(context).size.height - 100,
                    child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        padding:
                        const EdgeInsets.only(bottom: 40),
                        itemBuilder:
                            (BuildContext context, int index) {
                          return employeeList(context, index);
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            controller.userDataProvider
                                .setCurrentStatus('');
                            controller.userDataProvider
                                .setCurrentStatus('Add');
                            print("AddCode :  " +
                                controller.userDataProvider
                                    .getCurrentStatus
                                    .toString());

                            Get.toNamed(
                                AppRoutes.onDutyEntry.toName);
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
                                borderRadius:
                                BorderRadius.circular(22.5)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            else if (controller.selectedTabIndex.value == 1)
              Column(
                children: [
                  Container(
                    height:
                    MediaQuery.of(context).size.height - 100,
                    child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        padding:
                        const EdgeInsets.only(bottom: 40),
                        itemBuilder:
                            (BuildContext context, int index) {
                          return summaryList(context, index);
                        }),
                  ),
                ],
              )
          ])),


        ],
      )),
    ));
  }
}
Widget summaryList(BuildContext context, int index) {
  ReminderAddController controller = Get.put(ReminderAddController());

  Future<void> reminderDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
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
      controller.reminderDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
 // var model = controller.ideologyUserData[index];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      TextInput(
        height: 100,
        label: "ProjectCode",
        onPressed: () {
          controller.selectProjectList.value =
          !controller.selectProjectList.value;
        },
        controller: controller.projectCodeController,
        textInputType: TextInputType.text,
        textColor: Color(0xCC252525),
        hintText: "Enter ProjectCode  ",
        isReadOnly: true,
        obscureText: true,
        onTextChange: (String) {},
      ),
      Obx(
            () => Visibility(
          visible: controller.selectProjectList.value,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: height * 0.2,
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              padding: EdgeInsets.fromLTRB(6, 4, 0, 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.inputBorderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white, // Set the desired background color
              ),
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    children: List.generate(
                      controller.projectData.length,
                          (index) {
                        var model = controller.projectData[index];
                        return Container(
                          child: Column(
                            children: [
                              TextInput(
                                onPressed: () {
                                  controller.projectCodeController.text =
                                      controller
                                          .projectData[index].projectCode
                                          .toString();

                                  controller.selectProjectList.value = false;
                                  controller.userDataProvider.setProjectCode(
                                      controller
                                          .projectData[index].projectCode
                                          .toString());

                                  print("Project Code: " +
                                      controller
                                          .projectData[index].projectCode
                                          .toString());

                                  controller.getProjectList();
                                },
                                margin: false,
                                isSelected: controller
                                    .projectCodeController.text ==
                                    controller.projectData[index].projectCode
                                        .toString(),
                                label: "",
                                isEntryField: false,
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC234345),
                                hintText: model.projectCode,
                                onTextChange: (String) {},
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Visibility(
                                visible: controller.projectData.length !=
                                    index + 1,
                                child: Container(
                                  height: 1,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
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
        hintText: "Select Staff Details",
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

      TextInput(
        onPressed: () {
          reminderDate(context);
        },
        controller: controller.reminderDateController,
        height: 100,
        isReadOnly: true,
        label: "Reminder Day",
        onTextChange: (text) {},
        textInputType: TextInputType.phone,
        textColor: Color(0xCC252525),
        hintText: "yyyy-mm-dd",
        sufficIcon: Icon(
          Icons.calendar_month,
        ),
        obscureText: true,
      ),

      TextInput(
        height: 100,
        label: "Comments",
        onPressed: () {},
        controller: controller.commentsController,
        textInputType: TextInputType.text,
        textColor: Color(0xCC252525),
        hintText: "Enter Comments",
        onTextChange: (String) {},
      ),
      Container(
        width: width,
        margin: EdgeInsets.all(10),
        child: Center(
          child: Button(
              widthFactor: 0.9,
              heightFactor: 0.06,
              onPressed: () {
                controller.insertReminder();
              },
              child: Text(
                  controller.userDataProvider.getCurrentStatus.toString() ==
                      'Update'
                      ? "Update"
                      : "Add",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'lato',
                      fontWeight: FontWeight.w600))),
        ),
      ),
      SizedBox(
        height: 50,
      )
    ],
  );
}

Widget employeeList(BuildContext context, int index) {
  ReminderAddController controller = Get.put(ReminderAddController());

  Future<void> reminderDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,

        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
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
      controller.reminderDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
 // var model = controller.ideologyUserData[index];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      TextInput(
        height: 100,
        label: "ProjectCode",
        onPressed: () {
          controller.selectProjectList.value =
          !controller.selectProjectList.value;
        },
        controller: controller.projectCodeController,
        textInputType: TextInputType.text,
        textColor: Color(0xCC252525),
        hintText: "Enter ProjectCode  ",
        isReadOnly: true,
        obscureText: true,
        onTextChange: (String) {},
      ),
      Obx(
            () => Visibility(
          visible: controller.selectProjectList.value,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: height * 0.2,
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              padding: EdgeInsets.fromLTRB(6, 4, 0, 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.inputBorderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white, // Set the desired background color
              ),
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    children: List.generate(
                      controller.projectData.length,
                          (index) {
                        var model = controller.projectData[index];
                        return Container(
                          child: Column(
                            children: [
                              TextInput(
                                onPressed: () {
                                  controller.projectCodeController.text =
                                      controller
                                          .projectData[index].projectCode
                                          .toString();

                                  controller.selectProjectList.value = false;
                                  controller.userDataProvider.setProjectCode(
                                      controller
                                          .projectData[index].projectCode
                                          .toString());

                                  print("Project Code: " +
                                      controller
                                          .projectData[index].projectCode
                                          .toString());

                                  controller.getProjectList();
                                },
                                margin: false,
                                isSelected: controller
                                    .projectCodeController.text ==
                                    controller.projectData[index].projectCode
                                        .toString(),
                                label: "",
                                isEntryField: false,
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC234345),
                                hintText: model.projectCode,
                                onTextChange: (String) {},
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Visibility(
                                visible: controller.projectData.length !=
                                    index + 1,
                                child: Container(
                                  height: 1,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      // TextInput(
      //   height: 100,
      //   label: "Department",
      //   onPressed: () {
      //     if (controller.departmentSelection.value) {
      //       controller.departmentSelection.value = false;
      //     } else {
      //       controller.departmentSelection.value = true;
      //     }
      //     controller.departmentDetails.clear();
      //     controller.departmentDetails.add('Super Admin');
      //     controller.departmentDetails.add('Admin');
      //     controller.departmentDetails.add(' Human Resource');
      //     controller.departmentDetails.add('Information Technology');
      //     controller.departmentDetails.add('Sales');
      //     controller.departmentDetails.add('Project Manager');
      //     controller.departmentDetails.add('Machine Design');
      //     controller.departmentDetails.add('Raw Material');
      //     controller.departmentDetails.add('Milling');
      //     controller.departmentDetails.add('Rough Turning');
      //     controller.departmentDetails.add('CNC Turning');
      //     controller.departmentDetails.add('VMC');
      //     controller.departmentDetails.add('welding');
      //     controller.departmentDetails.add('Inspection');
      //     controller.departmentDetails.add('Assembly ');
      //     controller.departmentDetails.add('Packing');
      //     controller.departmentDetails.add('Dispatch');
      //     controller.departmentDetails.add('Store');
      //     controller.departmentDetails.add('Shipment ');
      //     controller.departmentDetails.add('Finance');
      //     controller.departmentDetails.add('Site Supervisor');
      //     controller.departmentDetails.add('Site Manager');
      //     controller.departmentDetails.add('Site Employee ');
      //     controller.departmentDetails.add('Purchase');
      //     controller.departmentDetails.add('CNC');
      //     controller.departmentDetails.add('Lathe');
      //     controller.departmentDetails.add('Executive ');
      //     controller.departmentDetails.add('Production Manager');
      //     controller.departmentDetails.add('Factory Admin');
      //   },
      //   controller: controller.departmentController,
      //   textInputType: TextInputType.text,
      //   textColor: Color(0xCC252525),
      //   hintText: "Enter Department ",
      //   isReadOnly: true,
      //   obscureText: true,
      //   onTextChange: (String) {},
      // ),
      // Obx(() => Visibility(
      //   visible: controller.departmentSelection.value,
      //   child: Align(
      //     alignment: Alignment.centerLeft,
      //     child: Container(
      //       width: MediaQuery.of(context).size.width / 2 - 25,
      //       height: height * 0.2,
      //       margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
      //       padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
      //       decoration: BoxDecoration(
      //         border: Border.all(
      //           color: AppTheme.inputBorderColor,
      //           width: 1,
      //         ),
      //         borderRadius: BorderRadius.circular(8),
      //         color: Colors.white, // Set the desired background color
      //       ),
      //       child: SingleChildScrollView(
      //         child: IntrinsicHeight(
      //           child: Column(
      //             children: List.generate(
      //               controller.departmentDetails.length,
      //                   (index) {
      //                 return Container(
      //                   child: Container(
      //                     child: Column(
      //                       children: [
      //                         TextInput(
      //                           onPressed: () {
      //                             controller.departmentController.text =
      //                             controller.departmentDetails[index];
      //                             controller.departmentSelection.value =
      //                             false;
      //                             controller.departmentDetails.clear();
      //
      //                             controller.departmentDetails.add('Month');
      //
      //                             controller.departmentDetails.add('Day');
      //                             controller.departmentDetails.add('Lease');
      //                             controller.departmentDetails
      //                                 .add('One Time');
      //                           },
      //                           margin: false,
      //                           isSelected: controller
      //                               .departmentController.text ==
      //                               controller.departmentDetails[index]!,
      //                           label: "",
      //                           isEntryField: false,
      //                           textInputType: TextInputType.text,
      //                           textColor: Color(0xCC234345),
      //                           hintText:
      //                           controller.departmentDetails[index],
      //                           onTextChange: (String) {},
      //                         ),
      //                         SizedBox(
      //                           height: 2,
      //                         ),
      //                         Visibility(
      //                           visible:
      //                           controller.departmentDetails.length !=
      //                               index + 1,
      //                           child: Container(
      //                             height: 1,
      //                             color: AppTheme.primaryColor,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               },
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // )),
      // TextInput(
      //   height: 100,
      //   label: "Employee",
      //   onPressed: () {
      //     if (controller.resourceSelection.value) {
      //       controller.resourceSelection.value = false;
      //     } else {
      //       controller.resourceSelection.value = true;
      //     }
      //     controller.resourceDetails.clear();
      //     controller.resourceDetails.add('(83)');
      //     controller.resourceDetails.add('Ashok (20)');
      //     controller.resourceDetails.add(' Balaji (7)');
      //     controller.resourceDetails.add('balaji (75)');
      //     controller.resourceDetails.add('Chandran (25)');
      //     controller.resourceDetails.add('Devan (16)');
      //     controller.resourceDetails.add('Dhanalakshmi (75)');
      //     controller.resourceDetails.add('Divya (2)');
      //     controller.resourceDetails.add('java (82)');
      //     controller.resourceDetails.add('javafactory (78)');
      //     controller.resourceDetails.add('javanew (81)');
      //     controller.resourceDetails.add('mani (68)');
      //     controller.resourceDetails.add('ManiKandan (4)');
      //     controller.resourceDetails.add('ManMohan (29)');
      //     controller.resourceDetails.add('NaveenKumar (74) ');
      //     controller.resourceDetails.add('Nivetha (11)');
      //     controller.resourceDetails.add('Paramashivan(65)');
      //     controller.resourceDetails.add('Prasath (12)');
      //     controller.resourceDetails.add('priyaDharshini (73) ');
      //     controller.resourceDetails.add('pugal (3)');
      //     controller.resourceDetails.add('Raghav (40)');
      //     controller.resourceDetails.add('Rajaguru (70)');
      //     controller.resourceDetails.add('Rakesh (39)');
      //     controller.resourceDetails.add('Sanjay (14)');
      //     controller.resourceDetails.add('Sathiya (1)');
      //     controller.resourceDetails.add('Sankar (64)');
      //     controller.resourceDetails.add('shavin (34)');
      //     controller.resourceDetails.add('Shivaraman (71)');
      //     controller.resourceDetails.add('Sri Kaliyaraj (66) ');
      //     controller.resourceDetails.add('Sudhagar (69)');
      //     controller.resourceDetails.add('Sundhar Factory(77)');
      //     controller.resourceDetails.add('Sundhar (76)');
      //     controller.resourceDetails.add('SundharRaj (80) ');
      //     controller.resourceDetails.add('Vijay (68)');
      //   },
      //   controller: controller.resourcesController,
      //   textInputType: TextInputType.text,
      //   textColor: Color(0xCC252525),
      //   hintText: AppPreference().getEmpName.toString(),
      //   onTextChange: (String) {},
      //   isReadOnly: true,
      //   obscureText: true,
      // ),
      // Obx(() => Visibility(
      //   visible: controller.resourceSelection.value,
      //   child: Align(
      //     alignment: Alignment.centerLeft,
      //     child: Container(
      //       width: MediaQuery.of(context).size.width / 2 - 25,
      //       height: height * 0.2,
      //       margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
      //       padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
      //       decoration: BoxDecoration(
      //         border: Border.all(
      //           color: AppTheme.inputBorderColor,
      //           width: 1,
      //         ),
      //         borderRadius: BorderRadius.circular(8),
      //         color: Colors.white, // Set the desired background color
      //       ),
      //       child: SingleChildScrollView(
      //         child: IntrinsicHeight(
      //           child: Column(
      //             children: List.generate(
      //               controller.resourceDetails.length,
      //                   (index) {
      //                 return Container(
      //                   child: SingleChildScrollView(
      //                     child: Column(
      //                       children: [
      //                         TextInput(
      //                           onPressed: () {
      //                             controller.resourcesController.text =
      //                             controller.resourceDetails[index];
      //                             controller.resourceSelection.value =
      //                             false;
      //                             controller.resourceDetails.clear();
      //                           },
      //                           margin: false,
      //                           isSelected:
      //                           controller.resourcesController.text ==
      //                               controller.resourceDetails[index]!,
      //                           label: "",
      //                           isEntryField: false,
      //                           textInputType: TextInputType.text,
      //                           textColor: Color(0xCC234345),
      //                           hintText: controller.resourceDetails[index],
      //                           onTextChange: (String) {},
      //                         ),
      //                         SizedBox(
      //                           height: 2,
      //                         ),
      //                         Visibility(
      //                           visible:
      //                           controller.resourceDetails.length !=
      //                               index + 1,
      //                           child: Container(
      //                             height: 1,
      //                             color: AppTheme.primaryColor,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               },
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // )),

      TextInput(
        onPressed: () {
          reminderDate(context);
        },
        controller: controller.reminderDateController,
        height: 100,
        isReadOnly: true,
        label: "Reminder Day",
        onTextChange: (text) {},
        textInputType: TextInputType.phone,
        textColor: Color(0xCC252525),
        hintText: "yyyy-mm-dd",
        sufficIcon: Icon(
          Icons.calendar_month,
        ),
        obscureText: true,
      ),

      TextInput(
        height: 100,
        label: "Comments",
        onPressed: () {},
        controller: controller.commentsController,
        textInputType: TextInputType.text,
        textColor: Color(0xCC252525),
        hintText: "Enter Comments",
        onTextChange: (String) {},
      ),
      Container(
        width: width,
        margin: EdgeInsets.all(10),
        child: Center(
          child: Button(
              widthFactor: 0.9,
              heightFactor: 0.06,
              onPressed: () {
                controller.insertReminder();
              },
              child: Text(
                  controller.userDataProvider.getCurrentStatus.toString() ==
                      'Update'
                      ? "Update"
                      : "Add",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'lato',
                      fontWeight: FontWeight.w600))),
        ),
      ),
      SizedBox(
        height: 50,
      )
    ],
  );
}