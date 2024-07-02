import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import '../../../Utils/image_picker.dart';
import '../../../forms/forms.dart';
import '../../../forms/theme.dart';
import 'package:intl/intl.dart';
import '../../Controller/WagesEntryController.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:just_audio/just_audio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/responseModel/WagesSummarylist.dart';
import '../../routes/app_routes.dart';

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class WagesEntryScreen extends GetView<WagesEntryController> {
  const WagesEntryScreen({super.key});

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          controller.audioPlayer.positionStream,
          controller.audioPlayer.bufferedPositionStream,
          controller.audioPlayer.durationStream,
          (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration!));

  bool selectableDay(DateTime day) {
    // Allow today, tomorrow, yesterday, and day before yesterday to be selectable
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime dayBeforeYesterday = today.subtract(Duration(days: 2));

    return day.year == today.year &&
        day.month == today.month &&
        (day.day == today.day ||
            day.day == yesterday.day ||
            day.day == dayBeforeYesterday.day);
  }

  Future<void> selectDate(BuildContext context) async {
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
      controller.currentDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void updateCombinedValue() {
    String noOfPeopleText = controller.noOfPeopleController.text;
    String rateText = controller.wagesController.text;
    double noOfPeople = double.tryParse(noOfPeopleText) ?? 0.0;
    double rate = double.tryParse(rateText) ?? 0.0;
    double result = noOfPeople * rate;
    controller.amountController.text = result.toString();

    String amountText = controller.amountController.text;
    String currentlyPaidText = controller.currentlyPaidAmountController.text;
    double amount = double.tryParse(amountText) ?? 0.0;
    double currentlyPaid = double.tryParse(currentlyPaidText) ?? 0.0;
    double result1 = amount - currentlyPaid;
    double balanceAmount = result1 < 0 ? 0.0 : result1;
    controller.balanceAmountController.text = balanceAmount.toString();
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WagesEntryController controller = Get.put(WagesEntryController());
    controller.subCategory1Call("");

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
                              Get.offNamed(AppRoutes.wagesSummaryScreen.toName);
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
                        width: 55,
                      ),
                      Text(
                        controller.userDataProvider.getCurrentStatus
                                    .toString() ==
                                'Edit'
                            ? "Update Wages Expense"
                            : "Add Wages Expense",
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
            body: KeyboardActions(
              config: _buildKeyboardActionsConfig(context),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: controller.subCategory1Controller,
                    height: 100,
                    label: "Type*",
                    onPressed: () {
                      if (controller.isSub1.value) {
                        //controller.subCategory2Controller.text == "";
                        controller.isSub1.value = false;
                      } else {
                        controller.isSub1.value = true;
                      }
                      controller.isSub2.value = false;
                      controller.rendList.value = false;
                    },
                    textInputType: TextInputType.text,
                    textColor: Color(0xCC252525),
                    hintText: "Select Type",
                    obscureText: true,
                    // isReadOnly: true,
                    onTextChange: (wages) {
                      if (wages.length >= 2) {
                        controller.subCategory1Call(wages);
                      } else {
                        return;
                      }
                      controller.popUpValue.value = true;
                    },
                  ),
                  Obx(() => Visibility(
                        visible: controller.isSub1.value,
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
                                controller.subCategory1.length,
                                (index) {
                                  var model = controller.subCategory1[index];
                                  return Container(
                                    child: Column(
                                      children: [
                                        TextInput(
                                          onPressed: () {
                                            controller.popUpValue.value = true;
                                            controller.subCategory1Controller
                                                    .text =
                                                controller.subCategory1[index]
                                                    .sub1CategoryName!;
                                            controller.selectedSub1Index.value =
                                                index;
                                            controller.isSub2Available.value =
                                                controller.subCategory1[index]
                                                            .isSubCategory ==
                                                        1
                                                    ? true
                                                    : false;
                                            // if (controller
                                            //     .subCategory1Controller.text ==
                                            //     'Betta') {
                                            //   controller.rendDetails
                                            //       .add('Day');
                                            //   controller.rendDetails
                                            //       .add('Month');
                                            //
                                            //
                                            //   controller.rendDetails
                                            //       .add('One Time');
                                            // }
                                            // if (controller
                                            //     .subCategory1Controller.text ==
                                            //     'Wages') {
                                            //
                                            //   controller.rendDetails
                                            //       .add('Day');
                                            //   controller.rendDetails
                                            //       .add('Month ');
                                            //   controller.rendDetails
                                            //       .add('One Time');
                                            //
                                            // }
                                            // if (controller
                                            //     .subCategory1Controller.text ==
                                            //     'Others') {
                                            //
                                            //   controller.rendDetails
                                            //       .add('Day');
                                            //   controller.rendDetails
                                            //       .add('Month ');
                                            //   controller.rendDetails
                                            //       .add('One Time');
                                            //
                                            // }
                                            controller.selectedSub2Index.value =
                                                index;

                                            controller.fetchSubCategoryTwo(
                                                controller.subCategory1[index]
                                                    .sub1CategoryId,
                                                "");

                                            controller.allVisible.value = true;

                                            if (controller.subCategory1[index]
                                                    .isSubCategory ==
                                                1) {
                                              controller.entries.value = false;
                                            } else {
                                              controller.entries.value = true;
                                              controller.fetchCategoryTwo
                                                  .clear();
                                            }
                                            controller.isSub1.value = false;
                                            controller.subCategory2Controller
                                                .text = "";
                                          },
                                          margin: false,
                                          withImage: true,
                                          imagePath: controller
                                              .subCategory1[index]
                                              .sub1CategoryImage,
                                          isSelected: controller
                                                  .subCategory1Controller
                                                  .text ==
                                              controller.subCategory1[index]
                                                  .sub1CategoryName,
                                          label: "",
                                          isEntryField: false,
                                          textInputType: TextInputType.text,
                                          textColor: Color(0xCC234345),
                                          hintText: model.sub1CategoryName,
                                          obscureText: true,
                                          onTextChange: (String) {},
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Visibility(
                                            visible: controller
                                                    .subCategory1.length !=
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
                  Obx(() => Visibility(
                        visible: controller.isSub2Available.value,
                        child: Column(children: [
                          TextInput(
                            controller: controller.subCategory2Controller,
                            height: 100,
                            label: "Type*",
                            onPressed: () {
                              if (controller.isSub2.value) {
                                controller.isSub2.value = false;
                              } else {
                                controller.isSub2.value = true;
                              }
                              controller.rendList.value = false;
                              controller.isSub1.value = false;
                              controller.subCategory1Controller.text == "";
                              if (controller.userDataProvider.getCurrentStatus == "Edit" ||
                                  controller.userDataProvider.getCurrentStatus == "Re-Use") {
                                for (int i = 0; i < controller.subCategory1.length; i++) {
                                  if (controller.subCategory1[i].sub1CategoryName ==
                                      controller.userDataProvider.getWagesData!.category2) {
                                    controller.fetchSubCategoryTwo(controller.subCategory1[i].sub1CategoryId,"");
                                  }
                                }
                              }
                            },
                            textInputType: TextInputType.text,
                            textColor: Color(0xCC252525),
                            hintText: "Select Type",
                            obscureText: true,
                            // isReadOnly: true,
                            onTextChange: (String) {
                              if (controller.subCategory2Controller.text ==
                                  "") {
                                controller.fetchSubCategoryTwo(
                                    controller
                                        .subCategory1[
                                            controller.selectedSub2Index.value]
                                        .sub1CategoryId,
                                    String);
                                controller.popUpValue.value = true;
                              }
                              controller.fetchSubCategoryTwo(
                                  controller
                                      .subCategory1[
                                          controller.selectedSub2Index.value]
                                      .sub1CategoryId,
                                  String);
                              controller.popUpValue.value = true;
                            },
                          ),
                          Obx(() => Visibility(
                                visible: controller.isSub2.value,
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
                                        controller.fetchCategoryTwo.length,
                                        (index) {
                                          var model = controller
                                              .fetchCategoryTwo[index];
                                          return Container(
                                            child: Column(
                                              children: [
                                                TextInput(
                                                  onPressed: () {
                                                    controller.popUpValue
                                                        .value = true;
                                                    controller
                                                            .subCategory2Controller
                                                            .text =
                                                        controller
                                                            .fetchCategoryTwo[
                                                                index]!
                                                            .sub2CategoryName!;
                                                    controller.selectedSub2Index
                                                        .value = index;
                                                    controller.isSub2.value =
                                                        false;
                                                    controller.entries.value =
                                                        true;
                                                  },
                                                  margin: false,
                                                  withImage: true,
                                                  imagePath: controller
                                                      .fetchCategoryTwo[index]
                                                      .sub2CategoryImage,
                                                  isSelected: controller
                                                          .subCategory2Controller
                                                          .text ==
                                                      controller
                                                          .fetchCategoryTwo[
                                                              index]
                                                          .sub2CategoryName,
                                                  label: "",
                                                  isEntryField: false,
                                                  textInputType:
                                                      TextInputType.text,
                                                  textColor: Color(0xCC234345),
                                                  hintText:
                                                      model.sub2CategoryName,
                                                  obscureText: true,
                                                  onTextChange: (String) {},
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Visibility(
                                                    visible: controller
                                                            .subCategory1
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
                              )),
                        ]),
                      )),
                  Obx(
                    () => Visibility(
                      visible: controller.allVisible.value,
                      child: Column(
                        children: [
                          Container(child: Row(children: [])),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: (width / 2) - 5,
                                child: TextInput(
                                  height: 100,
                                  label: "Type*",
                                  onPressed: () {
                                    if (controller.rendList.value) {
                                      controller.rendList.value = false;
                                    } else {
                                      controller.rendList.value = true;
                                    }

                                    controller.isSub2.value = false;
                                    controller.isSub1.value = false;
                                  },
                                  controller: controller.typeController,
                                  textInputType: TextInputType.number,
                                  textColor: Color(0xCC252525),
                                  obscureText: true,
                                  isReadOnly: true,
                                  hintText: "Select Type",
                                  onTextChange: (string) {},
                                ),
                              ),
                              Container(
                                width: (width / 2) - 5,
                                child: TextInput(
                                  height: 100,
                                  label: "No Of People*",
                                  onPressed: () {
                                    controller.rendList.value = false;
                                    controller.isSub2.value = false;
                                    controller.isSub1.value = false;
                                  },
                                  controller: controller.noOfPeopleController,
                                  textInputType: TextInputType.number,
                                  textColor: Color(0xCC252525),
                                  hintText: "No Of People",
                                  focusNode: controller.noOfPeopleFocusNode,
                                  onTextChange: (val) {
                                    controller.isOpened.value = false;
                                    controller.list.value = int.parse(val);
                                    print(controller.list.value);
                                    if (controller.list.value >= -1) {
                                      controller.isOpened.value = true;
                                    }
                                    updateCombinedValue();
                                    controller.popUpValue.value = true;

                                    controller.wagesEmployeesList.clear();
                                    for(int i=1; i<= controller.list.value;i++) {
                                      EMPWages items = EMPWages();
                                      items.employeeName = '';
                                      items.amount = '';
                                      items.photo = '';
                                      items.contactNumber = "";
                                      //items.fingerPrint = "";
                                      controller.wagesEmployeesList.add(items);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Obx(() => Visibility(
                                visible: controller.rendList.value,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            25,
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
                                                      controller.typeController
                                                              .text =
                                                          controller
                                                                  .rendDetails[
                                                              index];
                                                      controller.rendList
                                                          .value = false;

                                                      controller.popUpValue
                                                          .value = true;
                                                    },
                                                    margin: false,
                                                    isSelected: controller
                                                            .typeController
                                                            .text ==
                                                        controller.rendDetails[
                                                            index],
                                                    label: "",
                                                    isEntryField: false,
                                                    textInputType:
                                                        TextInputType.text,
                                                    textColor:
                                                        Color(0xCC234345),
                                                    hintText: controller
                                                        .rendDetails[index],
                                                    onTextChange: (String) {},
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Visibility(
                                                    visible: controller
                                                            .rendDetails
                                                            .length !=
                                                        index + 1,
                                                    child: Container(
                                                      height: 1,
                                                      color:
                                                          AppTheme.primaryColor,
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
                              )),
                          TextInput(
                            height: 100,
                            label: "Wages*",
                            onPressed: () {
                              controller.rendList.value = false;
                              controller.isSub2.value = false;
                              controller.isSub1.value = false;
                            },
                            focusNode: controller.wagesFocusNode,
                            controller: controller.wagesController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Wages",
                            onTextChange: (val) {
                              updateCombinedValue();
                             // controller.wagesEmployeesList[index].amount = int.parse(val);
                              controller.popUpValue.value = true;
                            },
                          ),
                          TextInput(
                            height: 100,
                            label: "Currently Paid Amount*",
                            onPressed: () {
                              controller.rendList.value = false;
                              controller.isSub2.value = false;
                              controller.isSub1.value = false;
                            },
                            controller:
                                controller.currentlyPaidAmountController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Currently Paid Amount",
                            focusNode:
                            controller.currentlyPaidAmountFocusNode,
                            onTextChange: (string) {
                              //   function1();
                              updateCombinedValue();
                              controller.popUpValue.value = true;
                            },
                          ),
                          TextInput(
                            height: 100,
                            label: "Balance*",
                            onPressed: () {
                              controller.rendList.value = false;
                              controller.isSub2.value = false;
                              controller.isSub1.value = false;
                            },
                            controller: controller.balanceAmountController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Balance Amount",
                            // focusNode: controller.balanceFocusNode,
                            isReadOnly: true,
                            onTextChange: (string) {
                              //function1();
                              updateCombinedValue();
                              controller.popUpValue.value = true;
                            },
                          ),

                          TextInput(
                            height: 100,
                            label: "Total Amount*",
                            onPressed: () {
                              controller.rendList.value = false;
                              controller.isSub2.value = false;
                              controller.isSub1.value = false;
                            },
                            controller: controller.amountController,
                            textInputType: TextInputType.number,
                            focusNode: controller.amountFocusNode,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Total Amount",
                            isReadOnly: true,
                            onTextChange: (String) {
                              controller.popUpValue.value = true;
                            },
                          ),

                          TextInput(
                            height: 100,
                            label: "Comments*",
                            onPressed: () {
                              controller.isSuggestionComments.value = ! controller.isSuggestionComments.value;
                              controller.rendList.value = false;
                              controller.isSub2.value = false;
                              controller.isSub1.value = false;
                            },
                            obscureText: true,
                            controller: controller.commentController,
                            textInputType: TextInputType.text,
                            textColor: Color(0xCC252525),
                            hintText: " Enter Your Comments ",
                            onTextChange: (String) {
                              controller.popUpValue.value = true;
                            },
                          ),

                          Obx(() => Visibility(
                            visible: controller.isSuggestionComments.value,
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
                                    controller.suggestionList.length,
                                        (index) {
                                      var model =
                                      controller.suggestionList[index];
                                      return Container(
                                        child: Column(
                                          children: [
                                            TextInput(
                                              onPressed: () {
                                                controller
                                                    .commentController.text =
                                                    controller
                                                        .suggestionList[index]!
                                                        .suggestion
                                                        .toString();

                                                controller.isSuggestionComments.value = false;
                                              },
                                              margin: false,
                                              withImage: false,
                                              isSelected: controller
                                                  .commentController.text ==
                                                  controller
                                                      .suggestionList[index]
                                                      .suggestion,
                                              label: "",
                                              isEntryField: false,
                                              textInputType: TextInputType.text,
                                              textColor: Color(0xCC234345),
                                              hintText: model.suggestion,
                                              obscureText: true,
                                              onTextChange: (String) {},
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Visibility(
                                                visible: controller
                                                    .suggestionList
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
                          )),







                          TextInput(
                            height: 100,
                            label: "WagesEmployee*",
                            onPressed: () {
                              controller.rendList.value = false;
                              controller.isSub2.value = false;
                              controller.isSub1.value = false;
                            },
                            controller: controller.noOfPeopleController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            hintText: "Enter WagesEmployee",
                            focusNode: controller.wagesEmployeeFocusNode,
                            onTextChange: (val) {
                              controller.popUpValue.value = true;
                            },
                          ),
                          Obx(() => Visibility(
                                visible: controller.isOpened.value,
                                child: Container(
                                  height: height*0.9,
                                  margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                                  padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppTheme.inputBorderColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppTheme
                                        .screenBackground, // Set the desired background color
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: controller.list.value,
                                            itemBuilder: (context, index) {
                                              return empList(context, index);
                                            }),
                                        SizedBox(
                                          height: 20,
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Obx(
                                    () => Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: AppTheme.liteWhite),
                                  ),
                                  child: Container(
                                    height:
                                    MediaQuery.of(context).size.height * 0.12,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: controller.pickImageSelected.value
                                          ? null
                                          : Border.all(
                                          color: AppTheme.liteWhite, width: 3),
                                    ),
                                    child: Material(
                                      color: AppTheme.liteWhite,
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            ImagePick(
                                              isMultiple: true,
                                              title: " Bill Image ",
                                              onClose: () => Get.back(),
                                              onSave: (List<PickedImage> images) {
                                                if (images.isNotEmpty) {
                                                  controller.itemImagePick.value =
                                                  images[0];
                                                  controller.pickImageSelected
                                                      .value = true;
                                                }
                                                Get.back();
                                              },
                                            ),
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            controller.itemImagePick.value !=
                                                null &&
                                                controller.itemImagePick.value
                                                    .imagePath !=
                                                    null?
                                            Image.file(
                                              controller.itemImagePick!.value!
                                                  .imagePath,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ):

                                            controller.imagePathFromData.value.isNotEmpty &&
                                                controller.isUpdateImageAvailable.value ?
                                            Image.network(
                                              controller.imagePathFromData.value,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ):
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.image,
                                                    size: 50,
                                                  ),
                                                  Text(
                                                    "Bill",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => Visibility(
                      visible: controller.isAudio.value,
                      child: Column(
                        children: [
                          controller.userDataProvider.getCurrentStatus == "Edit" ||
                              controller.userDataProvider.getCurrentStatus == "Re-Use" ? Container() :
                          Container(
                            child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.deleteOldData();
                                          },
                                          child: Image.asset(
                                            "assets/images/closed.png",
                                            fit: BoxFit.contain,
                                            width: width * 0.3,
                                            height: height * 0.1,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                             //   SizedBox(width: 20),
                                StreamBuilder<PlayerState>(
                                    stream:
                                        controller.audioPlayer.playerStateStream,
                                    builder: (context, snapshot) {
                                      final playerState = snapshot.data;
                                      final processingState =
                                          playerState?.processingState;
                                      final playing = playerState?.playing;
                                      if (!(playing ?? false)) {
                                        return IconButton(
                                            onPressed: () {
                                              controller.play();
                                            },
                                            icon: Icon(
                                              Icons.play_arrow_rounded,
                                              size: 30,
                                              color: Colors.black,
                                            ));
                                      } else if (processingState !=
                                          ProcessingState.completed) {
                                        return IconButton(
                                            onPressed: controller.audioPlayer.pause,
                                            icon: Icon(Icons.pause_rounded,
                                                size: 30, color: Colors.black));
                                      }
                                      return Icon(Icons.play_arrow_rounded);
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  width: 180,
                                  child: StreamBuilder(
                                      stream: _positionDataStream,
                                      builder: (context, snapshot) {
                                        final positionData = snapshot.data;
                                        return ProgressBar(
                                          progress: positionData?.position ??
                                              Duration.zero,
                                          buffered:
                                              positionData?.bufferedPosition ??
                                                  Duration.zero,
                                          total: positionData?.duration ??
                                              Duration.zero,
                                          onSeek: controller.audioPlayer.seek,
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextInput(
                      onPressed: () {
                        selectDate(context);
                      },
                      controller: controller.currentDateController,
                      height: 100,
                      isReadOnly: true,
                      label: "Date*",
                      onTextChange: (text) {
                        controller.popUpValue.value = true;
                      },
                      textInputType: TextInputType.phone,
                      textColor: Color(0xCC252525),
                      hintText: "Select Date",
                      sufficIcon: Icon(
                        Icons.calendar_month,
                      ),
                      obscureText: true),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Center(
                      child:   Obx(() =>     Button(
                          widthFactor: 0.9,
                          heightFactor: 0.06,
                          onPressed: () {


                            if(controller.uploadLoading.isTrue){
                              Fluttertoast.showToast(
                                msg: "Uploading... Please wait",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                              return;
                            }

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
                                              MainAxisAlignment.spaceBetween,
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
                                                controller.updateWages();
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
                                controller.updateWages();
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
                                              MainAxisAlignment.spaceBetween,
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
                                                controller.insertWages();
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
                                controller.insertWages();
                              }
                            } else {
                              controller.insertWages();
                            }
                          },
                          child:   controller.uploadLoading.isTrue ?  CircularProgressIndicator() :   Text(
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
                              ))),
                    ),
                    ),
                  ),
                ]),
              ),
            )));
  }



  Widget wagesList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        TextInput(
          height: 100,
          label: "VendorName*",
          onPressed: () {},
          controller: controller.employeeNameController,
          textInputType: TextInputType.text,
          textColor: Color(0xCC252525),
          hintText: "Enter VendorName",
          onTextChange: (string) {
            controller.popUpValue.value = true;
          },
        ),
        TextInput(
          height: 100,
          label: "VendorCompany*",
          onPressed: () {},
          controller: controller.amountController,
          textInputType: TextInputType.number,
          textColor: Color(0xCC252525),
          hintText: "Enter VendorCompany",
          onTextChange: (string) {
            controller.popUpValue.value = true;
          },
        ),
        TextInput(
          height: 100,
          label: "VendorAddress*",
          onPressed: () {},
          controller: controller.contactNumberController,
          textInputType: TextInputType.text,
          textColor: Color(0xCC252525),
          hintText: "Enter VendorAddress",
          onTextChange: (string) {
            controller.popUpValue.value = true;
          },
        ),
      ],
    );

  }
}
KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
  WagesEntryController controller = Get.put(WagesEntryController());
  return KeyboardActionsConfig(
    keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
    keyboardBarColor: Colors.grey,
    actions: [
      KeyboardActionsItem(
        focusNode: controller.amountFocusNode,
      ),
      KeyboardActionsItem(
        focusNode: controller.noOfPeopleFocusNode,
      ),
      KeyboardActionsItem(
        focusNode: controller.wagesFocusNode,
      ), KeyboardActionsItem(
        focusNode: controller.currentlyPaidAmountFocusNode,
      ),
      KeyboardActionsItem(
        focusNode: controller.wagesEmployeeFocusNode,
      ),KeyboardActionsItem(
        focusNode: controller.contactNumberFocusNode,
      ),
    ],
  );
}
Widget empList(BuildContext context, int index) {
  WagesEntryController controller = Get.put(WagesEntryController());

  return Column(
    children: [
      Container(
        color: AppTheme.screenBackground,
        child: Column(
          children: [
            TextInput(
              height: 100,
              label: "Employee Name*",
              onPressed: () {

              },
              // controller: controller.employeeNameController,
              textInputType: TextInputType.text,
              textColor: Color(0xCC252525),
              hintText: "Enter Employee Name",
              onTextChange: (val) {
                if (val.isEmpty) { // Check if the value is not empty
                  controller.popUpValue.value = true;
                  controller.wagesEmployeesList[index].employeeName = val;
                }
              },
            ),
            TextInput(
              height: 100,
              label: "amount*",
              onPressed: () {},
              //controller: controller.amountControllerOne,
              textInputType: TextInputType.number,
              //focusNode: controller.amountFocusNode,
              textColor: Color(0xCC252525),
              hintText: "Enter amount",
              onTextChange: (val) {
                controller.popUpValue.value = true;
                controller.wagesEmployeesList[index].amount = val;
              },
            ),
            TextInput(
              height: 100,
              label: "Contact Number*",
              onPressed: () {},
              // controller: controller.contactNumberController,
              textInputType: TextInputType.number,
              //focusNode:controller.contactNumberFocusNode,
              textColor: Color(0xCC252525),
              hintText: "Enter Contact Number",
              onTextChange: (val) {
                controller.popUpValue.value = true;
                controller.wagesEmployeesList[index].contactNumber =
                    val;
              },
            ),

        Obx(
              () => Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: AppTheme.liteWhite),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: controller.pickImageSelectedEmp.value
                        ? null
                        : Border.all(color: AppTheme.liteWhite, width: 3),
                  ),
                  child: Material(
                    color: AppTheme.liteWhite,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          ImagePick(
                            isMultiple: true,
                            title: "Profile ",
                            onClose: () => Get.back(),
                            onSave: (List<PickedImage> images) {
                              if (images.isNotEmpty) {
                                controller.wagesEmployeesList.value[index].photo = images[0].base64;

                                if(controller.itemImagePickEmp !=null && controller.itemImagePickEmp.length> index ) {
                                    controller.itemImagePickEmp[index] = images[0];
                                }else{
                                  controller.itemImagePickEmp.add(images[0]);
                                }
                                controller.pickImageSelectedEmp.value = true;
                              }

                              Get.back();
                            },
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          if (controller.itemImagePickEmp != null && controller.itemImagePickEmp.length > index && controller.itemImagePickEmp[index] != null)
                            Image.file(
                              controller.itemImagePickEmp[index]!.imagePath,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          if (controller.itemImagePickEmp  != null || controller.itemImagePickEmp[index]!.imagePath ==
                          null)
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 50,
                                  ),
                                  Text(
                                    "Bill",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          // Positioned(
                          //   bottom: 0,
                          //   right: 0,
                          //   child: Container(
                          //     padding: EdgeInsets.all(8),
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: Colors.blue,
                          //     ),
                          //     child: Icon(
                          //       Icons.add,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
