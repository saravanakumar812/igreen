import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/MaintenanceController.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';
import 'package:intl/intl.dart';

class Maintenance extends GetView<MaintenanceController> {
  const Maintenance({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    MaintenanceController controller = Get.put(MaintenanceController());
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
                              Get.offNamed(AppRoutes.maintenanceSummary.toName);
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
                        width: 30,
                      ),
                      Text(
                        'Maintenance',
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
            body: RefreshIndicator(
              onRefresh: controller.refreshData,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextInput(
                      height: 100,
                      label: "Type",
                      onPressed: () {
                        if (controller.rendList.value) {
                          controller.rendList.value = false;
                        } else {
                          controller.rendList.value = true;
                        }
                        controller.typeControllerTwo.text = "";
                      },
                      controller: controller.typeControllerOne,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Select Type ",
                      obscureText: true,
                      onTextChange: (text) {},
                    ),
                    Obx(() => Visibility(
                          visible: controller.rendList.value,
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
                                  controller.rendDetails.length,
                                  (index) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller
                                                      .typeControllerOne.text =
                                                  controller.rendDetails[index];
                                              controller.rendList.value = false;

                                              controller.popUpValue.value =
                                                  true;
                                              controller.hrVisible.value =
                                                  false;
                                              controller.kmVisible.value =
                                                  false;
                                              if(controller
                                                  .typeControllerOne.text == "Machines"){
                                                controller.hrVisible.value =
                                                true;
                                              } else{
                                                controller.kmVisible.value =
                                                true;
                                              }
                                              controller.typeID.value =
                                                  index + 1;
                                            },
                                            margin: false,
                                            isSelected: controller
                                                    .typeControllerOne.text ==
                                                controller.rendDetails[index]!,
                                            label: "",
                                            isEntryField: false,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC234345),
                                            hintText:
                                                controller.rendDetails[index],
                                            onTextChange: (String) {},
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Visibility(
                                            visible:
                                                controller.rendDetails.length !=
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
                        )),
                    TextInput(
                      height: 100,
                      label: "Type",
                      onPressed: () {
                        controller.fetchSubCategoryTwo();
                        controller.sub2.value = !controller.sub2.value;
                      },
                      controller: controller.typeControllerTwo,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Select Type ",
                      obscureText: true,
                      onTextChange: (text) {},
                    ),
                    Obx(() => Visibility(
                          visible: controller.sub2.value,
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
                                  controller.getCategoryTwo.length,
                                  (index) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller
                                                      .typeControllerTwo.text =
                                                  controller
                                                      .getCategoryTwo[index]
                                                      .subCategoryName
                                                      .toString();

                                              controller.sub2.value = false;

                                              controller.popUpValue.value =
                                                  true;
                                            },
                                            margin: false,
                                            isSelected: controller
                                                    .typeControllerTwo.text ==
                                                controller
                                                    .getCategoryTwo[index]!
                                                    .subCategoryName,
                                            label: "",
                                            isEntryField: false,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC234345),
                                            hintText: controller
                                                .getCategoryTwo[index]
                                                .subCategoryName,
                                            onTextChange: (String) {},
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Visibility(
                                            visible:
                                                controller.rendDetails.length !=
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
                        )),
                    Obx(() => Visibility(
                          visible: controller.hrVisible.value,
                          child: Column(children: [
                            TextInput(
                              onPressed: () {
                                controller.subCategoryDropDownOne.value = false;

                                controller.rendList.value = false;
                                _selectStartDate(context);
                              },
                              controller: controller.startDateAndTimeController,
                              height: 100,
                              isReadOnly: true,
                              label: "Starting hr",
                              onTextChange: (text) {
                                controller.startDateAndTimeController.text =
                                    text;
                                controller.popUpValue.value = true;
                              },
                              textInputType: TextInputType.phone,
                              textColor: Color(0xCC252525),
                              hintText: "Select Starting hr",
                              sufficIcon: Icon(
                                Icons.calendar_month,
                              ),
                              obscureText: true,
                            ),
                            TextInput(
                                onPressed: () {
                                  controller.subCategoryDropDownOne.value =
                                      false;
                                  controller.rendList.value = false;
                                  //
                                  _selectEndDate(context);
                                },
                                controller:
                                    controller.closeDateAndTimeController,
                                height: 100,
                                isReadOnly: true,
                                label: "Closing hr",
                                onTextChange: (text) {
                                  controller.closeDateAndTimeController.text =
                                      text;
                                  controller.popUpValue.value = true;
                                },
                                textInputType: TextInputType.phone,
                                textColor: Color(0xCC252525),
                                hintText: "Select Closing hr",
                                sufficIcon: Icon(
                                  Icons.calendar_month,
                                ),
                                obscureText: true),
                          ]),
                        )),
                    Obx(() => Visibility(
                          visible: controller.kmVisible.value,
                          child: Row(children: [
                            Container(
                              width: (width / 2) - 10,
                              child: TextInput(
                                onPressed: () {
                                  controller.subCategoryDropDownOne.value =
                                      false;

                                  controller.rendList.value = false;
                                },
                                controller: controller.staringKmController,
                                height: 100,
                                label: "Starting km",
                                textInputType: TextInputType.number,
                                textColor: Color(0xCC252525),
                                hintText: "Enter Starting km",
                                // focusNode:
                                // controller.startingKmFocusNode,
                                onTextChange: (text) {
                                  controller.popUpValue.value = true;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 0,
                            ),
                            Container(
                              width: (width / 2) - 10,
                              child: TextInput(
                                onPressed: () {
                                  controller.subCategoryDropDownOne.value =
                                      false;

                                  controller.rendList.value = false;
                                },
                                controller: controller.closingKmController,
                                height: 100,
                                label: " Closing km",
                                textInputType: TextInputType.number,
                                textColor: Color(0xCC252525),
                                hintText: "Enter Closing km",
                                // focusNode:
                                // controller.closingKmFocusNode,
                                onTextChange: (text) {
                                  controller.popUpValue.value = true;
                                },
                              ),
                            ),
                          ]),
                        )),
                    TextInput(
                      height: 100,
                      label: "Days",
                      onPressed: () {
                        controller.checklist.value =
                            !controller.checklist.value;
                      },
                      controller: controller.typeControllerThree,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Select Days ",
                      obscureText: true,
                      onTextChange: (text) {
                        if (controller.typeControllerThree.text == "") {
                          controller.isOpened.value = false;
                        }
                        if (controller.typeControllerThree.text == "30days") {
                          controller.isOpened.value = true;
                        }
                        controller.typeControllerThree.text = text.toString();
                      },
                    ),
                    Obx(() => Visibility(
                          visible: controller.checklist.value,
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
                                  controller.checkList.length,
                                  (index) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller.typeControllerThree
                                                      .text =
                                                  controller.checkList[index];

                                              controller.checklist.value =
                                                  false;
                                              controller.popUpValue.value =
                                                  true;
                                              controller.checkListDates.value =
                                                  !controller
                                                      .checkListDates.value;

                                              controller.checkListDays();
                                            },
                                            margin: false,
                                            isSelected: controller
                                                    .typeControllerThree.text ==
                                                controller.checkList[index]!,
                                            label: "",
                                            isEntryField: false,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC234345),
                                            hintText:
                                                controller.checkList[index],
                                            onTextChange: (String) {},
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Visibility(
                                            visible:
                                                controller.checkList.length !=
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
                        )),
                    Obx(() => Visibility(
                          // visible: controller.checkListDay.length >= 1
                          //     ? true
                          //     : false,

                          visible: controller.checkListDates.value,
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
                                  controller.checkListDay.length,
                                  (index) {
                                    return Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Obx(
                                              //   () => Checkbox(
                                              //     value: controller
                                              //         .onClickList[index]
                                              //         .main
                                              //         .value,
                                              //     onChanged: (bool? value) {
                                              //       if (value != null) {
                                              //         controller
                                              //                 .onClickList[index]
                                              //                 .main
                                              //                 .value =
                                              //             !controller
                                              //                 .onClickList[
                                              //                     index]
                                              //                 .main
                                              //                 .value;
                                              //
                                              //         if (controller
                                              //             .checkingData
                                              //             .isNotEmpty) {
                                              //           bool isAvailable =
                                              //               false;
                                              //           int count = 0;
                                              //           for (int i = 0;
                                              //               i <
                                              //                   controller
                                              //                       .checkingData
                                              //                       .length;
                                              //               i++) {
                                              //             if (controller
                                              //                     .checkingData[
                                              //                         i]
                                              //                     .checklistName ==
                                              //                 controller
                                              //                     .checkListDay[
                                              //                         index]
                                              //                     .names) {
                                              //               isAvailable = true;
                                              //               count = i;
                                              //               break;
                                              //             }
                                              //           }
                                              //           if (isAvailable) {
                                              //             controller
                                              //                 .checkingData
                                              //                 .removeAt(count);
                                              //           } else {
                                              //             MaintenanceResponseList
                                              //                 list =
                                              //                 MaintenanceResponseList();
                                              //             list.checklistName =
                                              //                 controller
                                              //                     .checkListDay[
                                              //                         index]
                                              //                     .names;
                                              //             list.checklistStatus =
                                              //                 "";
                                              //             controller
                                              //                 .checkingData
                                              //                 .add(list);
                                              //           }
                                              //         }
                                              //         else {
                                              //           MaintenanceResponseList
                                              //               list =
                                              //               MaintenanceResponseList();
                                              //           list.checklistName =
                                              //               controller
                                              //                   .checkListDay[
                                              //                       index]
                                              //                   .names;
                                              //           list.checklistStatus =
                                              //               "";
                                              //           controller.checkingData
                                              //               .add(list);
                                              //         }
                                              //
                                              //         List<
                                              //                 MapEntry<String,
                                              //                     dynamic>>
                                              //             entryList = controller
                                              //                 .checkDataMap
                                              //                 .entries
                                              //                 .toList();
                                              //         print(
                                              //             entryList[index].key);
                                              //
                                              //         // Update the value of the entry
                                              //         entryList[index] =
                                              //             MapEntry(
                                              //                 entryList[index]
                                              //                     .key,
                                              //                 value
                                              //                     ? "1"
                                              //                     : "0");
                                              //
                                              //         // Convert the updated list back to a map
                                              //         var resultMap =
                                              //             Map.fromEntries(
                                              //                 entryList);
                                              //         controller.checkDataMap =
                                              //             resultMap;
                                              //       }
                                              //     },
                                              //     activeColor:
                                              //         AppTheme.secondaryColor,
                                              //   ),
                                              // ),
                                              Container(
                                                width: width * 0.7,
                                                child: TextInput(
                                                  onPressed: () {
                                                    controller
                                                        .checkListDay[index]!
                                                        .names
                                                        .toString();
                                                    controller.popUpValue
                                                        .value = true;
                                                  },
                                                  margin: false,
                                                  label: "",
                                                  isEntryField: false,
                                                  textInputType:
                                                      TextInputType.text,
                                                  textColor: Colors.black,
                                                  hintText: controller
                                                      .checkListDay[index]
                                                      .names,
                                                  onTextChange: (String) {},
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 15),
                                            child: Row(
                                              children: [
                                                Obx(
                                                  () => Checkbox(
                                                    value: controller
                                                        .onClickList[index]
                                                        .good
                                                        .value,
                                                    onChanged: (bool? value) {
                                                      controller
                                                          .onClickList[index]
                                                          .newReplacement
                                                          .value = false;
                                                      controller
                                                          .onClickList[index]
                                                          .bad
                                                          .value = false;

                                                      if (controller
                                                              .userDataProvider
                                                              .getCurrentStatus ==
                                                          "Edit") {
                                                        controller
                                                                .onClickList[index]
                                                                .good
                                                                .value =
                                                            !controller
                                                                .onClickList[
                                                                    index]
                                                                .good
                                                                .value;

                                                        controller.selected
                                                            .value = index;

                                                        controller
                                                            .updateMaintenanceCall(
                                                                "Good");

                                                        return;
                                                      }

                                                      if (value != null) {
                                                        controller
                                                                .onClickList[index]
                                                                .good
                                                                .value =
                                                            !controller
                                                                .onClickList[
                                                                    index]
                                                                .good
                                                                .value;

                                                        List<
                                                                MapEntry<String,
                                                                    dynamic>>
                                                            entryList =
                                                            controller
                                                                .checkDataMap
                                                                .entries
                                                                .toList();
                                                        print(entryList[index]
                                                            .key);

                                                        // Update the value of the entry
                                                        entryList[index] =
                                                            MapEntry(
                                                                entryList[index]
                                                                    .key,
                                                                value
                                                                    ? "1"
                                                                    : "0");

                                                        // Convert the updated list back to a map
                                                        if (controller
                                                            .checkingData
                                                            .isNotEmpty) {
                                                          bool isAvailable =
                                                              false;
                                                          int count = 0;
                                                          for (int i = 0;
                                                              i <
                                                                  controller
                                                                      .checkingData
                                                                      .length;
                                                              i++) {
                                                            if (controller
                                                                    .checkingData[
                                                                        i]
                                                                    .checklistName ==
                                                                controller
                                                                    .checkListDay[
                                                                        index]
                                                                    .names) {
                                                              isAvailable =
                                                                  true;
                                                              count = i;
                                                              break;
                                                            }
                                                          }
                                                          if (isAvailable) {
                                                          } else {
                                                            MaintenanceResponseList
                                                                list =
                                                                MaintenanceResponseList();
                                                            list.checklistName =
                                                                controller
                                                                    .checkListDay[
                                                                        index]
                                                                    .names;
                                                            list.checklistStatus =
                                                                "Good";
                                                            controller
                                                                .checkingData
                                                                .add(list);
                                                          }
                                                        } else {
                                                          MaintenanceResponseList
                                                              list =
                                                              MaintenanceResponseList();
                                                          list.checklistName =
                                                              controller
                                                                  .checkListDay[
                                                                      index]
                                                                  .names;
                                                          list.checklistStatus =
                                                              "Good";
                                                          controller
                                                              .checkingData
                                                              .add(list);
                                                        }
                                                      }
                                                    },
                                                    activeColor:
                                                        AppTheme.secondaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  'Good',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: Row(
                                                    children: [
                                                      Obx(
                                                        () => Checkbox(
                                                          value: controller
                                                              .onClickList[
                                                                  index]
                                                              .bad
                                                              .value,
                                                          onChanged:
                                                              (bool? value) {
                                                            controller
                                                                .onClickList[
                                                                    index]
                                                                .good
                                                                .value = false;
                                                            controller
                                                                .onClickList[
                                                                    index]
                                                                .newReplacement
                                                                .value = false;
                                                            if (controller
                                                                    .userDataProvider
                                                                    .getCurrentStatus ==
                                                                "Edit") {
                                                              controller
                                                                      .onClickList[
                                                                          index]
                                                                      .bad
                                                                      .value =
                                                                  !controller
                                                                      .onClickList[
                                                                          index]
                                                                      .bad
                                                                      .value;

                                                              controller
                                                                      .selected
                                                                      .value =
                                                                  index;
                                                              controller
                                                                  .updateMaintenanceCall(
                                                                      "Fair");

                                                              return;
                                                            }

                                                            if (value != null) {
                                                              controller
                                                                      .onClickList[
                                                                          index]
                                                                      .bad
                                                                      .value =
                                                                  !controller
                                                                      .onClickList[
                                                                          index]
                                                                      .bad
                                                                      .value;

                                                              List<
                                                                      MapEntry<
                                                                          String,
                                                                          dynamic>>
                                                                  entryList =
                                                                  controller
                                                                      .checkDataMap
                                                                      .entries
                                                                      .toList();
                                                              print(entryList[
                                                                      index]
                                                                  .key);

                                                              // Update the value of the entry
                                                              entryList[index] =
                                                                  MapEntry(
                                                                      entryList[
                                                                              index]
                                                                          .key,
                                                                      value
                                                                          ? "1"
                                                                          : "0");

                                                              // Convert the updated list back to a map
                                                              var resultMap = Map
                                                                  .fromEntries(
                                                                      entryList);
                                                              controller
                                                                      .checkDataMap =
                                                                  resultMap;
                                                            }

                                                            if (controller
                                                                .checkingData
                                                                .isNotEmpty) {
                                                              bool isAvailable =
                                                                  false;
                                                              int count = 0;
                                                              for (int i = 0;
                                                                  i <
                                                                      controller
                                                                          .checkingData
                                                                          .length;
                                                                  i++) {
                                                                if (controller
                                                                        .checkingData[
                                                                            i]
                                                                        .checklistName ==
                                                                    controller
                                                                        .checkListDay[
                                                                            index]
                                                                        .names) {
                                                                  isAvailable =
                                                                      true;
                                                                  count = i;
                                                                  break;
                                                                }
                                                              }
                                                              if (isAvailable) {
                                                              } else {
                                                                MaintenanceResponseList
                                                                    list =
                                                                    MaintenanceResponseList();
                                                                list.checklistName =
                                                                    controller
                                                                        .checkListDay[
                                                                            index]
                                                                        .names;
                                                                list.checklistStatus =
                                                                    "Fair";
                                                                controller
                                                                    .checkingData
                                                                    .add(list);
                                                              }
                                                            } else {
                                                              MaintenanceResponseList
                                                                  list =
                                                                  MaintenanceResponseList();
                                                              list.checklistName =
                                                                  controller
                                                                      .checkListDay[
                                                                          index]
                                                                      .names;
                                                              list.checklistStatus =
                                                                  "Fair";
                                                              controller
                                                                  .checkingData
                                                                  .add(list);
                                                            }
                                                          },
                                                          activeColor: AppTheme
                                                              .secondaryColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Fair',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: Row(
                                                    children: [
                                                      Obx(() => Checkbox(
                                                            value: controller
                                                                .onClickList[
                                                                    index]
                                                                .newReplacement
                                                                .value,
                                                            onChanged:
                                                                (bool? value) {
                                                              controller
                                                                  .onClickList[
                                                                      index]
                                                                  .good
                                                                  .value = false;
                                                              controller
                                                                  .onClickList[
                                                                      index]
                                                                  .bad
                                                                  .value = false;
                                                              if (controller
                                                                      .userDataProvider
                                                                      .getCurrentStatus ==
                                                                  "Edit") {
                                                                controller
                                                                        .onClickList[
                                                                            index]
                                                                        .newReplacement
                                                                        .value =
                                                                    !controller
                                                                        .onClickList[
                                                                            index]
                                                                        .newReplacement
                                                                        .value;

                                                                controller
                                                                        .selected
                                                                        .value =
                                                                    index;
                                                                controller
                                                                    .updateMaintenanceCall(
                                                                        "Replacement");

                                                                return;
                                                              }

                                                              if (value !=
                                                                  null) {
                                                                controller
                                                                        .onClickList[
                                                                            index]
                                                                        .newReplacement
                                                                        .value =
                                                                    !controller
                                                                        .onClickList[
                                                                            index]
                                                                        .newReplacement
                                                                        .value;

                                                                List<
                                                                        MapEntry<
                                                                            String,
                                                                            dynamic>>
                                                                    entryList =
                                                                    controller
                                                                        .checkDataMap
                                                                        .entries
                                                                        .toList();
                                                                print(entryList[
                                                                        index]
                                                                    .key);

                                                                // Update the value of the entry
                                                                entryList[
                                                                        index] =
                                                                    MapEntry(
                                                                        entryList[index]
                                                                            .key,
                                                                        value
                                                                            ? "1"
                                                                            : "0");

                                                                // Convert the updated list back to a map
                                                                var resultMap =
                                                                    Map.fromEntries(
                                                                        entryList);
                                                                controller
                                                                        .checkDataMap =
                                                                    resultMap;
                                                              }

                                                              if (controller
                                                                  .checkingData
                                                                  .isNotEmpty) {
                                                                bool
                                                                    isAvailable =
                                                                    false;
                                                                int count = 0;
                                                                for (int i = 0;
                                                                    i <
                                                                        controller
                                                                            .checkingData
                                                                            .length;
                                                                    i++) {
                                                                  if (controller
                                                                          .checkingData[
                                                                              i]
                                                                          .checklistName ==
                                                                      controller
                                                                          .checkListDay[
                                                                              index]
                                                                          .names) {
                                                                    isAvailable =
                                                                        true;
                                                                    count = i;
                                                                    break;
                                                                  }
                                                                }
                                                                if (isAvailable) {
                                                                } else {
                                                                  MaintenanceResponseList
                                                                      list =
                                                                      MaintenanceResponseList();
                                                                  list.checklistName =
                                                                      controller
                                                                          .checkListDay[
                                                                              index]
                                                                          .names;
                                                                  list.checklistStatus =
                                                                      "Replacement";
                                                                  controller
                                                                      .checkingData
                                                                      .add(
                                                                          list);
                                                                }
                                                              } else {
                                                                MaintenanceResponseList
                                                                    list =
                                                                    MaintenanceResponseList();
                                                                list.checklistName =
                                                                    controller
                                                                        .checkListDay[
                                                                            index]
                                                                        .names;
                                                                list.checklistStatus =
                                                                    "Replacement";
                                                                controller
                                                                    .checkingData
                                                                    .add(list);
                                                              }
                                                            },
                                                            activeColor: AppTheme
                                                                .secondaryColor,
                                                          )),
                                                      Text(
                                                        'Replacement',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Visibility(
                                            visible:
                                                controller.rendDetails.length !=
                                                    index + 1,
                                            child: Container(
                                              height: 2,
                                              color: AppTheme.appBlack,
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
                        )),
                    TextInput(
                      height: 100,
                      label: "Remarks",
                      onPressed: () {},
                      controller: controller.remarksController,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Enter Remarks ",
                      onTextChange: (text) {},
                    ),
                    TextInput(
                      height: 100,
                      label: "Checker Name",
                      onPressed: () {},
                      controller: controller.checkerNameController,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: " Enter Checker Name ",
                      onTextChange: (text) {},
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Center(
                          child: Button(
                              widthFactor: 0.9,
                              heightFactor: 0.06,
                              onPressed: () {
                                if (controller.userDataProvider.getCurrentStatus
                                        .toString() ==
                                    'Edit') {
                                  if (controller.popUpValue.value == true) {
                                    print('popUpValueFalse');
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Do you want to Update?',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Button2(
                                                  widthFactor: 0.28,
                                                  heightFactor: 0.04,
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Button(
                                                  widthFactor: 0.28,
                                                  heightFactor: 0.04,
                                                  onPressed: () {
                                                    controller
                                                        .updateMaintenance();
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    print('popUpValueTrue');
                                    controller.updateMaintenance();
                                  }
                                } else if (controller
                                        .userDataProvider.getCurrentStatus
                                        .toString() ==
                                    'Re-Use') {
                                  if (controller.popUpValue.value == false) {
                                    print('popUpValueFalse');
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Do you want to add same expense ?',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Button2(
                                                  widthFactor: 0.28,
                                                  heightFactor: 0.04,
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Button(
                                                  widthFactor: 0.28,
                                                  heightFactor: 0.04,
                                                  onPressed: () {
                                                    controller
                                                        .insertMaintenanceExpenseCall();
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    print('popUpValueTrue');
                                    controller.insertMaintenanceExpenseCall();
                                  }
                                } else {
                                  controller.insertMaintenanceExpenseCall();
                                }
                              },
                              child: Text(
                                  controller.userDataProvider.getCurrentStatus
                                              .toString() ==
                                          'Edit'
                                      ? "Update"
                                      : "Add",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600,
                                  )))),
                    ),
                  ],
                ),
              ),
            )));
  }

  Future<void> _selectStartDate(BuildContext context) async {
    MaintenanceController controller = Get.put(MaintenanceController());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // controller.selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF455636),
            hintColor: Color(0xFF455636),
            colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        },
      );
      if (selectedTime != null) {
        controller.selectedStartDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        controller.startDateAndTimeController.text =
            DateFormat('yyyy-MM-dd HH:mm:ss')
                .format(controller.selectedStartDate!);
      }
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    MaintenanceController controller = Get.put(MaintenanceController());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(1900),
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
      },
    );
    if (picked != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        },
      );
      if (selectedTime != null) {
        controller.selectedEndDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        controller.closeDateAndTimeController.text =
            DateFormat('yyyy-MM-dd HH:mm:ss')
                .format(controller.selectedEndDate!);
      }
    }
  }
}
