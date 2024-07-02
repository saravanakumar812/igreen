import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../../Utils/image_picker.dart';
import '../../../forms/forms.dart';
import '../../../forms/theme.dart';
import '../../Controller/TravelEntryController.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:just_audio/just_audio.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class TravelEntryScreen extends GetView<TravelEntryController> {
  const TravelEntryScreen({super.key});

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

  void updateCombinedValueFour() {
    String noOfPeopleText = controller.noOfPeopleController.text;
    String ticketText = controller.ticketController.text;

    double noOfPeople = double.tryParse(noOfPeopleText) ?? 0.0;
    double ticket = double.tryParse(ticketText) ?? 0.0;
    double result = noOfPeople * ticket;
    controller.amountController.text = result.toString();
  }

  void updateCombinedValue() {
    // Get the values from the text fields
    String noOfPeopleText = controller.noOfPeopleController.text;
    String ticketText = controller.ticketController.text;
    String driverTips = controller.driveTipsController.text;
    String toll = controller.tollChargesController.text;

    String duration = controller.durationController.text;
    String rate = controller.rateController.text;
    double noOfPeople = double.tryParse(noOfPeopleText) ?? 0.0;
    double durationText = double.tryParse(duration) ?? 0;
    double rateText = double.tryParse(rate) ?? 0;
    double result = durationText * rateText;
    double ticket = double.tryParse(ticketText) ?? 0.0;
    double driver = double.tryParse(driverTips) ?? 0.0;
    double tollCharges = double.tryParse(toll) ?? 0.0;
    double result1 = (driver + tollCharges);
    double result2 = result + result1;
    controller.amountController.text = result2.toString();

// Calculate ticket per person
    if (noOfPeople != 0) {
      double ticketPerPerson = result2 / noOfPeople;
      // Update the ticketController with ticket per person
      controller.ticketController.text = ticketPerPerson.toString();
    }
  }

  void updateCombinedSubValue() {
    String noOfPeopleText = controller.amountController.text;
    String rateText = controller.currentlyPaidAmountController.text;
    double noOfPeople = double.tryParse(noOfPeopleText) ?? 0.0;
    double rate = double.tryParse(rateText) ?? 0.0;
    double result = (noOfPeople - rate);
    double balanceAmount = result < 0 ? 0.0 : result;
    controller.balanceAmountController.text = balanceAmount.toString();
  }

  void updateCombinedSubOneValue() {
    String noOfPeopleText = controller.ticketController.text;
    String driverTips = controller.driveTipsController.text;
    String toll = controller.tollChargesController.text;
    double ticket = double.tryParse(noOfPeopleText) ?? 0.0;
    double driver = double.tryParse(driverTips) ?? 0.0;
    double tollCharges = double.tryParse(toll) ?? 0.0;
    double result1 = (ticket + driver + tollCharges);
    controller.amountController.text = result1.toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TravelEntryController controller = Get.put(TravelEntryController());

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
                              Get.offNamed(
                                  AppRoutes.travelSummaryScreen.toName);
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
                        width: 60,
                      ),
                      Text(
                        controller.userDataProvider.getCurrentStatus
                                    .toString() ==
                                'Edit'
                            ? "Update Travel Expense"
                            : "Add Travel Expense",
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
                    label: "Select Type",
                    onPressed: () {
                      if (controller.isSub1.value) {
                        controller.isSub1.value = false;
                      } else {
                        controller.isSub1.value = true;
                      }
                      controller.isSub2.value = false;
                      controller.toLocationVisibleDropdown.value = false;
                      controller.fromLocationVisibleDropdown.value = false;
                      controller.ownerOnClick.value = false;
                      controller.rendList.value = false;
                      controller.toLocationVisibleDropdown.value = false;
                      controller.fromLocationVisibleDropdown.value = false;
                      controller.vendorOnClick.value = false;
                    },
                    textInputType: TextInputType.text,
                    textColor: Color(0xCC252525),
                    hintText: "Select Type",
                    obscureText: true,
                    onTextChange: (text) {
                      if (controller.subCategory1Controller.text == "") {
                        controller.subCategory1Call(text);
                      }
                      if (text.length >= 2) {
                        controller.subCategory1Call(text);
                      } else {
                        return;
                      }
                      controller.subcategoryName = text;
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
                                            controller.subCategory1Controller
                                                    .text =
                                                controller.subCategory1[index]
                                                    .sub1CategoryName!;
                                            controller.selectedSub1Index.value =
                                                index;

                                            controller.isSub2Available.value =
                                                true;
                                            controller.commonVisible.value =
                                                true;
                                            controller.popUpValue.value = true;
                                            if (controller.subCategory1[index]
                                                    .isSubCategory ==
                                                1) {
                                              controller.fetchSubCategoryTwo(
                                                  controller.subCategory1[index]
                                                      .sub1CategoryId,
                                                  "");
                                              controller.entries.value = false;
                                            } else {
                                              controller.entries.value = true;
                                              controller.fetchCategoryTwo
                                                  .clear();
                                            }
                                            controller.buttonAndImageHoldVisible
                                                .value = false;

                                            if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Car') {
                                              controller
                                                  .buttonAndImageHoldVisible
                                                  .value = true;
                                            }
                                            if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Van') {
                                              controller
                                                  .buttonAndImageHoldVisible
                                                  .value = true;
                                            }
                                            if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Two Wheeler') {
                                              controller
                                                  .buttonAndImageHoldVisible
                                                  .value = true;
                                            }
                                            if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Three Wheeler') {
                                              controller
                                                  .buttonAndImageHoldVisible
                                                  .value = true;
                                            }

                                            // if (controller
                                            //         .subCategory1Controller
                                            //         .text ==
                                            //     'Bus') {
                                            //   controller.rendDetails
                                            //       .add('Month');
                                            //
                                            //   controller.rendDetails.add('Day');
                                            //   controller.rendDetails
                                            //       .add('Per Hour');
                                            // }
                                            // if (controller
                                            //         .subCategory1Controller
                                            //         .text ==
                                            //     'Rail') {
                                            //   controller.rendDetails
                                            //       .add('Per Hour');
                                            //   controller.rendDetails.add('Day');
                                            //
                                            //   controller.rendDetails
                                            //       .add('Month Basis');
                                            // }
                                            // if (controller
                                            //         .subCategory1Controller
                                            //         .text ==
                                            //     'Air-way ') {
                                            //   controller.rendDetails
                                            //       .add('Per Hour');
                                            //   controller.rendDetails.add('Day');
                                            //   controller.rendDetails
                                            //       .add('Month Basis');
                                            // }
                                            //
                                            // if (controller
                                            //         .subCategory1Controller
                                            //         .text ==
                                            //     'Sea-way') {
                                            //   controller.rendDetails
                                            //       .add('Per Hour');
                                            //   controller.rendDetails.add('Day');
                                            //   controller.rendDetails
                                            //       .add('Month Basis');
                                            // }
                                            //
                                            // if (controller
                                            //         .subCategory1Controller
                                            //         .text ==
                                            //     'Passenger Vehicle') {
                                            //   controller.rendDetails
                                            //       .add('Per Hour');
                                            //   controller.rendDetails.add('Day');
                                            //   controller.rendDetails
                                            //       .add('Month Basis');
                                            // }
                                            if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Car') {
                                              controller.rendDetails
                                                  .add('Per Hour');
                                              controller.rendDetails.add('Day');
                                              controller.rendDetails
                                                  .add('Month Basis');
                                            }
                                            if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Van') {
                                              controller.rendDetails
                                                  .add('Per Hour');
                                              controller.rendDetails.add('Day');
                                              controller.rendDetails
                                                  .add('Month Basis');
                                            }
                                            if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Two Wheeler') {
                                              controller.rendDetails
                                                  .add('Per Hour');
                                              controller.rendDetails.add('Day');
                                              controller.rendDetails
                                                  .add('Month Basis');
                                            }
                                            if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Three Wheeler ') {
                                              controller.rendDetails
                                                  .add('Per Hour');
                                              controller.rendDetails.add('Day');
                                              controller.rendDetails
                                                  .add('Month Basis');
                                            }
                                            controller.publicTravels.value =
                                                false;
                                            controller.locationsVisible.value =
                                                false;
                                            controller.driverTips.value = false;
                                            controller.ticketCharges1.value =
                                                false;
                                            controller.amount.value = false;
                                            controller.kiloVisible.value =
                                                false;
                                            controller.tollCharges.value =
                                                false;
                                            controller.travelCharges.value =
                                                false;
                                            controller.isSub2Available.value =
                                                false;
                                            controller.others.value = false;
                                            if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Bus') {
                                              controller.publicTravels.value =
                                                  true;
                                              controller.isSub2Available.value =
                                                  true;
                                              controller.others.value = false;
                                              controller.locationsVisible
                                                  .value = true;
                                              controller.driverTips.value =
                                                  false;
                                              controller.ticketCharges1.value =
                                                  true;
                                            } else if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Rail') {
                                              controller.isSub2Available.value =
                                                  true;
                                              controller.others.value = false;
                                              controller.publicTravels.value =
                                                  true;
                                              controller.subCategory2Controller
                                                  .text = "";

                                              controller.locationsVisible
                                                  .value = true;
                                              controller.ticketCharges1.value =
                                                  true;
                                              controller.tollCharges.value =
                                                  false;
                                            } else if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Air-way') {
                                              controller.others.value = false;
                                              controller.isSub2Available.value =
                                                  true;
                                              controller.publicTravels.value =
                                                  true;

                                              controller.locationsVisible
                                                  .value = true;

                                              controller.ticketCharges1.value =
                                                  true;
                                              controller.tollCharges.value =
                                                  false;
                                            } else if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Sea-way') {
                                              controller.others.value = false;
                                              controller.publicTravels.value =
                                                  true;
                                              controller.isSub2Available.value =
                                                  true;
                                              controller.locationsVisible
                                                  .value = true;
                                              controller.ticketCharges1.value =
                                                  true;
                                              controller.subCategory2Controller
                                                  .text = "";
                                              controller.tollCharges.value =
                                                  false;
                                            } else if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Passenger Vehicle') {
                                              controller.others.value = false;
                                              controller.isSub2Available.value =
                                                  true;
                                              controller.publicTravels.value =
                                                  true;
                                              controller.isSub2Available.value =
                                                  false;
                                              controller.amount.value = true;
                                            } else if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Car') {
                                              controller.others.value = false;
                                              controller.isSub2Available.value =
                                                  true;
                                              controller.driverTips.value =
                                                  true;
                                              controller.locationsVisible
                                                  .value = true;
                                              controller.publicTravels.value =
                                                  true;
                                              controller.ticketCharges1.value =
                                                  false;
                                              controller.tollCharges.value =
                                                  true;
                                              controller.kiloVisible.value =
                                                  true;
                                              controller.travelCharges.value =
                                                  true;
                                            } else if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Van') {
                                              controller.others.value = false;
                                              controller.driverTips.value =
                                                  true;
                                              controller.isSub2Available.value =
                                                  true;
                                              controller.locationsVisible
                                                  .value = true;
                                              controller.publicTravels.value =
                                                  true;
                                              controller.ticketCharges1.value =
                                                  false;
                                              controller.tollCharges.value =
                                                  true;
                                              controller.kiloVisible.value =
                                                  true;
                                              controller.travelCharges.value =
                                                  true;
                                            } else if (controller
                                                        .subCategory1Controller
                                                        .text ==
                                                    'Two Wheeler' ||
                                                controller
                                                        .subCategory1Controller
                                                        .text ==
                                                    'Three Wheeler') {
                                              controller.others.value = false;
                                              controller.publicTravels.value =
                                                  true;
                                              controller.subCategory2Controller
                                                  .text = "";
                                              controller.locationsVisible
                                                  .value = true;
                                              controller.kiloVisible.value =
                                                  true;
                                              controller.isSub2Available.value =
                                                  true;
                                              controller.ticketCharges1.value =
                                                  false;
                                              controller.isSub2Available.value =
                                                  false;

                                              controller.tollCharges.value =
                                                  false;
                                              controller.driverTips.value =
                                                  true;
                                              controller.travelCharges.value =
                                                  true;
                                            } else if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Truck') {
                                              controller.driverTips.value =
                                                  true;
                                              controller.locationsVisible
                                                  .value = true;
                                              controller.publicTravels.value =
                                                  true;
                                              controller.ticketCharges1.value =
                                                  false;
                                              controller.tollCharges.value =
                                                  true;
                                              controller.kiloVisible.value =
                                                  true;
                                            } else if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Others') {
                                              controller.isSub2Available.value =
                                                  false;
                                              controller.others.value = true;
                                              controller.driverTips.value =
                                                  true;
                                              controller.locationsVisible
                                                  .value = true;
                                              controller.publicTravels.value =
                                                  true;
                                              controller.ticketCharges1.value =
                                                  false;
                                              controller.tollCharges.value =
                                                  true;
                                              controller.kiloVisible.value =
                                                  true;
                                              controller.travelCharges.value =
                                                  true;
                                              controller
                                                  .buttonAndImageHoldVisible
                                                  .value = true;
                                            }

                                            controller.isSub1.value = false;
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
                            label: "Select Type",
                            onPressed: () {
                              if (controller.isSub2.value) {
                                controller.isSub2.value = false;
                              } else {
                                controller.isSub2.value = true;
                              }
                              controller.isSub1.value = false;
                              controller.toLocationVisibleDropdown.value =
                                  false;
                              controller.fromLocationVisibleDropdown.value =
                                  false;
                              controller.ownerOnClick.value = false;
                              controller.rendList.value = false;
                              controller.toLocationVisibleDropdown.value =
                                  false;
                              controller.fromLocationVisibleDropdown.value =
                                  false;
                              controller.vendorOnClick.value = false;

                              if (controller
                                          .userDataProvider.getCurrentStatus ==
                                      "Edit" ||
                                  controller
                                          .userDataProvider.getCurrentStatus ==
                                      "Re-Use") {
                                for (int i = 0;
                                    i < controller.subCategory1.length;
                                    i++) {
                                  if (controller
                                          .subCategory1[i].sub1CategoryName ==
                                      controller.userDataProvider.getTravelData!
                                          .category2) {
                                    controller.fetchSubCategoryTwo(
                                        controller
                                            .subCategory1[i].sub1CategoryId,
                                        "");
                                  }
                                }
                              }
                            },
                            textInputType: TextInputType.text,
                            textColor: Color(0xCC252525),
                            hintText: "Select Type",
                            obscureText: true,
                            //isReadOnly: true,
                            onTextChange: (String) {
                              if (controller.subCategory2Controller.text ==
                                  "") {
                                controller.fetchSubCategoryTwo(
                                    controller
                                        .subCategory1[
                                            controller.selectedSub1Index.value]
                                        .sub1CategoryId,
                                    String);
                              }
                              controller.fetchSubCategoryTwo(
                                  controller
                                      .subCategory1[
                                          controller.selectedSub1Index.value]
                                      .sub1CategoryId,
                                  String);
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

                                                    controller.popUpValue
                                                        .value = true;
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
                      visible: controller.others.value,
                      child: TextInput(
                        height: 100,
                        label: "Other Travel",
                        onPressed: () {
                          controller.toLocationVisibleDropdown.value = false;
                          controller.fromLocationVisibleDropdown.value = false;
                          controller.vendorOnClick.value = false;
                          controller.isSub1.value = false;
                          controller.isSub2.value = false;
                          controller.ownerOnClick.value = false;
                          controller.rendList.value = false;
                        },
                        controller: controller.othersController,
                        textInputType: TextInputType.text,
                        textColor: Color(0xCC252525),
                        //focusNode: controller.tollChargesFocusNode,
                        hintText: "Enter Other Travel",
                        onTextChange: (String) {
                          controller.popUpValue.value = true;
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.publicTravels.value,
                      child: Column(
                        children: [
                          Visibility(
                            visible: controller.locationsVisible.value,
                            child: Container(
                                child: Column(
                              children: [
                                Row(children: [
                                  Container(
                                    width: (width / 2) - 10,
                                    child: TextInput(
                                      height: 100,
                                      label: "From location*",
                                      onPressed: () {
                                        controller.fromLocationVisibleDropdown
                                                .value =
                                            !controller
                                                .fromLocationVisibleDropdown
                                                .value;
                                        controller.toLocationVisibleDropdown
                                            .value = false;
                                        controller.vendorOnClick.value = false;
                                        controller.isSub1.value = false;
                                        controller.isSub2.value = false;
                                        controller.ownerOnClick.value = false;
                                        controller.rendList.value = false;
                                      },
                                      controller: controller.fromController,
                                      textInputType: TextInputType.text,
                                      textColor: Color(0xCC252525),
                                      obscureText: true,
                                      //isReadOnly: true,
                                      hintText: "Enter From location",
                                      onTextChange: (loc) {
                                        if (controller.fromController.text ==
                                            "") {
                                          controller.getFromCityTransport(loc);
                                        }
                                        if (loc.length >= 3) {
                                          controller.getFromCityTransport(loc);
                                        } else {
                                          return;
                                        }
                                        controller.startingLocation = loc;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: (width / 2) - 10,
                                    child: TextInput(
                                      height: 100,
                                      label: "To location*",
                                      onPressed: () {
                                        if (controller
                                            .toLocationVisibleDropdown.value) {
                                          controller.toLocationVisibleDropdown
                                              .value = false;
                                        } else {
                                          controller.toLocationVisibleDropdown
                                              .value = true;
                                        }

                                        controller.fromLocationVisibleDropdown
                                            .value = false;
                                        controller.vendorOnClick.value = false;
                                        controller.isSub1.value = false;
                                        controller.isSub2.value = false;
                                        controller.ownerOnClick.value = false;
                                        controller.rendList.value = false;
                                      },
                                      controller: controller.toController,
                                      textInputType: TextInputType.text,
                                      textColor: Color(0xCC252525),
                                      hintText: "Enter To location",
                                      obscureText: true,
                                      //isReadOnly: true,
                                      onTextChange: (loc) {
                                        if (controller.toController.text ==
                                            "") {
                                          controller.getToCityTransport(loc);
                                        }
                                        if (loc.length >= 3) {
                                          controller.getToCityTransport(loc);
                                        } else {
                                          return;
                                        }
                                        controller.endingLocation = loc;
                                      },
                                    ),
                                  ),
                                ]),
                                Obx(
                                  () => Visibility(
                                    visible: controller
                                        .fromLocationVisibleDropdown.value,
                                    child: Container(
                                      height: height * 0.5,
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
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: List.generate(
                                              controller.fromCityValues.length,
                                              (index) {
                                                var model = controller
                                                    .fromCityValues[index];
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      TextInput(
                                                        onPressed: () {
                                                          controller
                                                                  .fromController
                                                                  .text =
                                                              controller
                                                                  .fromCityValues[
                                                                      index]
                                                                  .cityName!;

                                                          controller
                                                              .fromLocationVisibleDropdown
                                                              .value = false;
                                                          controller.popUpValue
                                                              .value = true;
                                                        },
                                                        margin: false,
                                                        withImage: false,
                                                        isSelected: controller
                                                                .fromController
                                                                .text ==
                                                            controller
                                                                .fromCityValues[
                                                                    index]
                                                                .cityName,
                                                        label: "",
                                                        isEntryField: false,
                                                        textInputType:
                                                            TextInputType.text,
                                                        textColor:
                                                            Color(0xCC234345),
                                                        hintText:
                                                            model.cityName,
                                                        obscureText: true,
                                                        onTextChange:
                                                            (String) {},
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Visibility(
                                                          visible: controller
                                                                  .fromCityValues
                                                                  .length !=
                                                              index + 1,
                                                          child: Container(
                                                            height: 1,
                                                            color: AppTheme
                                                                .appBlack,
                                                          ))
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
                                Obx(() => Visibility(
                                      visible: controller
                                          .toLocationVisibleDropdown.value,
                                      child: Container(
                                        height: height * 0.5,
                                        margin:
                                            EdgeInsets.fromLTRB(12, 4, 12, 0),
                                        padding:
                                            EdgeInsets.fromLTRB(6, 4, 6, 6),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppTheme.inputBorderColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors
                                              .white, // Set the desired background color
                                        ),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: List.generate(
                                                controller.toCityValues.length,
                                                (index) {
                                                  var model = controller
                                                      .toCityValues[index];
                                                  return Container(
                                                    child: Column(
                                                      children: [
                                                        TextInput(
                                                          onPressed: () {
                                                            controller
                                                                    .toController
                                                                    .text =
                                                                controller
                                                                    .toCityValues[
                                                                        index]
                                                                    .cityName!;

                                                            controller
                                                                .toLocationVisibleDropdown
                                                                .value = false;
                                                            controller
                                                                .popUpValue
                                                                .value = true;
                                                          },
                                                          margin: false,
                                                          withImage: false,
                                                          isSelected: controller
                                                                  .toController
                                                                  .text ==
                                                              controller
                                                                  .toCityValues[
                                                                      index]
                                                                  .cityName,
                                                          label: "",
                                                          isEntryField: false,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          textColor:
                                                              Color(0xCC234345),
                                                          hintText:
                                                              model.cityName,
                                                          obscureText: true,
                                                          onTextChange:
                                                              (String) {},
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        Visibility(
                                                            visible: controller
                                                                    .toCityValues
                                                                    .length !=
                                                                index + 1,
                                                            child: Container(
                                                              height: 1,
                                                              color: AppTheme
                                                                  .appBlack,
                                                            ))
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
                              ],
                            )),
                          ),
                          Visibility(
                            visible: controller.kiloVisible.value,
                            child: Container(
                                child: Row(children: [
                              Container(
                                width: (width / 2) - 10,
                                child: TextInput(
                                  height: 100,
                                  label: "Starting Km*",
                                  onPressed: () {
                                    controller.toLocationVisibleDropdown.value =
                                        false;
                                    controller.fromLocationVisibleDropdown
                                        .value = false;
                                    controller.vendorOnClick.value = false;
                                    controller.isSub1.value = false;
                                    controller.isSub2.value = false;
                                    controller.ownerOnClick.value = false;
                                    controller.rendList.value = false;
                                  },
                                  controller: controller.startingKmController,
                                  textInputType: TextInputType.number,
                                  textColor: Color(0xCC252525),
                                  hintText: "Enter Starting Km",
                                  focusNode: controller.startingKmFocusNode,
                                  onTextChange: (String) {
                                    controller.popUpValue.value = true;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: (width / 2) - 10,
                                child: TextInput(
                                  height: 100,
                                  label: "Closing Km*",
                                  onPressed: () {
                                    controller.toLocationVisibleDropdown.value =
                                        false;
                                    controller.fromLocationVisibleDropdown
                                        .value = false;
                                    controller.vendorOnClick.value = false;
                                    controller.isSub1.value = false;
                                    controller.isSub2.value = false;
                                    controller.ownerOnClick.value = false;
                                    controller.rendList.value = false;
                                  },
                                  controller: controller.closingKmController,
                                  textInputType: TextInputType.number,
                                  textColor: Color(0xCC252525),
                                  focusNode: controller.closingKmFocusNode,
                                  hintText: "Enter Closing Km",
                                  onTextChange: (value) {
                                    controller.popUpValue.value = true;
                                  },
                                ),
                              ),
                            ])),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.amount.value,
                              child: TextInput(
                                height: 100,
                                label: "Amount",
                                onPressed: () {
                                  controller.toLocationVisibleDropdown.value =
                                      false;
                                  controller.fromLocationVisibleDropdown.value =
                                      false;
                                  controller.vendorOnClick.value = false;
                                  controller.isSub1.value = false;
                                  controller.isSub2.value = false;
                                  controller.ownerOnClick.value = false;
                                  controller.rendList.value = false;
                                },
                                controller: controller.amountController,
                                textInputType: TextInputType.number,
                                textColor: Color(0xCC252525),
                                focusNode: controller.amountFocusNode,
                                hintText: "Enter Amount",
                                onTextChange: (String) {
                                  controller.popUpValue.value = true;
                                },
                              ),
                            ),
                          ),
                          TextInput(
                            height: 100,
                            label: "Comments*",
                            onPressed: () {
                              controller.isSuggestionComments.value =
                                  !controller.isSuggestionComments.value;

                              controller.toLocationVisibleDropdown.value =
                                  false;
                              controller.fromLocationVisibleDropdown.value =
                                  false;
                              controller.vendorOnClick.value = false;
                              controller.isSub1.value = false;
                              controller.isSub2.value = false;
                              controller.ownerOnClick.value = false;
                              controller.rendList.value = false;
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
                                                    controller.commentController
                                                            .text =
                                                        controller
                                                            .suggestionList[
                                                                index]!
                                                            .suggestion
                                                            .toString();

                                                    controller
                                                        .isSuggestionComments
                                                        .value = false;
                                                  },
                                                  margin: false,
                                                  withImage: false,
                                                  isSelected: controller
                                                          .commentController
                                                          .text ==
                                                      controller
                                                          .suggestionList[index]
                                                          .suggestion,
                                                  label: "",
                                                  isEntryField: false,
                                                  textInputType:
                                                      TextInputType.text,
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
                                                            .fetchCategoryTwo
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
                            label: "No of People*",
                            onPressed: () {
                              controller.toLocationVisibleDropdown.value =
                                  false;
                              controller.fromLocationVisibleDropdown.value =
                                  false;
                              controller.vendorOnClick.value = false;
                              controller.isSub1.value = false;
                              controller.isSub2.value = false;
                              controller.ownerOnClick.value = false;
                              controller.rendList.value = false;
                            },
                            controller: controller.noOfPeopleController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            hintText: "Enter No of People",
                            onTextChange: (String) {
                              updateCombinedValueFour();
                              controller.popUpValue.value = true;
                            },
                          ),
                          Visibility(
                            visible: controller.buttonAndImageHoldVisible.value,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        width: (width / 2) - 25,
                                        height: 50,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            Radio<bool>(
                                              value: true,
                                              groupValue: controller
                                                  .selectedRadioRented.value,
                                              onChanged: (bool? value) {
                                                if (value != null) {
                                                  controller
                                                      .onRadioValueChangedRented(
                                                          value);
                                                  controller.rentOwnedOnClick
                                                          .value =
                                                      !controller
                                                          .rentOwnedOnClick
                                                          .value;
                                                  controller.selectedRadioOwned
                                                      .value = false;
                                                  controller.ownedOnClick
                                                      .value = false;
                                                  controller.driverTips.value =
                                                      true;
                                                  controller
                                                      .toLocationVisibleDropdown
                                                      .value = false;
                                                  controller
                                                      .fromLocationVisibleDropdown
                                                      .value = false;
                                                  controller.vendorOnClick
                                                      .value = false;
                                                  controller.isSub1.value =
                                                      false;
                                                  controller.isSub2.value =
                                                      false;
                                                  controller.ownerOnClick
                                                      .value = false;
                                                  controller.rendList.value =
                                                      false;
                                                  updateCombinedValue();
                                                  controller
                                                      .refreshDataRented();
                                                }
                                              },
                                              activeColor:
                                                  AppTheme.radioButtonColor,
                                            ),
                                            // Add spacing between the radio button and text
                                            Text(
                                              controller.machineRented.value,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        width: (width / 2) - 25,
                                        height: 50,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            Radio<bool>(
                                              value: true,
                                              groupValue: controller
                                                  .selectedRadioOwned.value,
                                              onChanged: (bool? value) {
                                                if (value != null) {
                                                  controller
                                                      .onRadioValueChangedOwned(
                                                          value);

                                                  controller
                                                          .ownedOnClick.value =
                                                      !controller
                                                          .ownedOnClick.value;
                                                  controller.driverTips.value =
                                                      false;
                                                  controller.selectedRadioRented
                                                      .value = false;
                                                  controller.rentOwnedOnClick
                                                      .value = false;
                                                  controller
                                                      .toLocationVisibleDropdown
                                                      .value = false;
                                                  controller
                                                      .fromLocationVisibleDropdown
                                                      .value = false;
                                                  controller.vendorOnClick
                                                      .value = false;
                                                  controller.isSub1.value =
                                                      false;
                                                  controller.isSub2.value =
                                                      false;
                                                  controller.ownerOnClick
                                                      .value = false;
                                                  controller.rendList.value =
                                                      false;
                                                  updateCombinedSubOneValue();
                                                  controller.refreshDataOwned();
                                                }
                                              },
                                              activeColor:
                                                  AppTheme.radioButtonColor,
                                            ),
                                            // Add spacing between the radio button and text
                                            Text(
                                              controller.machineOwned.value,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                    visible: controller.rentOwnedOnClick.value,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: (width / 2) - 5,
                                              child: TextInput(
                                                height: 100,
                                                label: "Duration Type",
                                                onPressed: () {
                                                  controller.vendorOnClick
                                                      .value = false;
                                                  if (controller
                                                      .rendList.value) {
                                                    controller.rendList.value =
                                                        false;
                                                  } else {
                                                    controller.rendList.value =
                                                        true;
                                                  }
                                                  controller
                                                      .toLocationVisibleDropdown
                                                      .value = false;
                                                  controller
                                                      .fromLocationVisibleDropdown
                                                      .value = false;
                                                  controller.vendorOnClick
                                                      .value = false;
                                                  controller.isSub1.value =
                                                      false;
                                                  controller.isSub2.value =
                                                      false;
                                                  controller.ownerOnClick
                                                      .value = false;
                                                  //controller.rendList.value = false;
                                                },
                                                controller:
                                                    controller.typeController,
                                                textInputType:
                                                    TextInputType.number,
                                                textColor: Color(0xCC252525),
                                                obscureText: true,
                                                isReadOnly: true,
                                                hintText:
                                                    "Select  Duration Type",
                                                onTextChange: (string) {},
                                              ),
                                            ),
                                            Container(
                                              width: (width / 2) - 5,
                                              child: TextInput(
                                                height: 100,
                                                label: "Duration",
                                                onPressed: () {
                                                  controller
                                                      .toLocationVisibleDropdown
                                                      .value = false;
                                                  controller
                                                      .fromLocationVisibleDropdown
                                                      .value = false;
                                                  controller.vendorOnClick
                                                      .value = false;
                                                  controller.isSub1.value =
                                                      false;
                                                  controller.isSub2.value =
                                                      false;
                                                  controller.ownerOnClick
                                                      .value = false;
                                                  controller.rendList.value =
                                                      false;
                                                },
                                                controller: controller
                                                    .durationController,
                                                focusNode: controller
                                                    .durationFocusNode,
                                                textInputType:
                                                    TextInputType.number,
                                                textColor: Color(0xCC252525),
                                                hintText: "Enter Duration",
                                                onTextChange: (string) {
                                                  updateCombinedValue();

                                                  controller.popUpValue.value =
                                                      true;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Obx(() => Visibility(
                                              visible:
                                                  controller.rendList.value,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      25,
                                                  margin: EdgeInsets.fromLTRB(
                                                      12, 4, 12, 0),
                                                  padding: EdgeInsets.fromLTRB(
                                                      6, 4, 6, 6),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppTheme
                                                          .inputBorderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors
                                                        .white, // Set the desired background color
                                                  ),
                                                  child: IntrinsicHeight(
                                                    child: Column(
                                                      children: List.generate(
                                                        controller
                                                            .rendDetails.length,
                                                        (index) {
                                                          return Container(
                                                            child: Column(
                                                              children: [
                                                                TextInput(
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .typeController
                                                                        .text = controller
                                                                            .rendDetails[
                                                                        index];
                                                                    controller
                                                                        .rendList
                                                                        .value = false;
                                                                    controller
                                                                        .rendDetails
                                                                        .clear();
                                                                    controller
                                                                        .popUpValue
                                                                        .value = true;
                                                                  },
                                                                  margin: false,
                                                                  isSelected: controller
                                                                          .typeController
                                                                          .text ==
                                                                      controller
                                                                              .rendDetails[
                                                                          index]!,
                                                                  label: "",
                                                                  isEntryField:
                                                                      false,
                                                                  textInputType:
                                                                      TextInputType
                                                                          .text,
                                                                  textColor: Color(
                                                                      0xCC234345),
                                                                  hintText:
                                                                      controller
                                                                              .rendDetails[
                                                                          index],
                                                                  onTextChange:
                                                                      (String) {},
                                                                ),
                                                                SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Visibility(
                                                                  visible: controller
                                                                          .rendDetails
                                                                          .length !=
                                                                      index + 1,
                                                                  child:
                                                                      Container(
                                                                    height: 1,
                                                                    color: AppTheme
                                                                        .primaryColor,
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
                                          label: "Rate",
                                          onPressed: () {
                                            controller.toLocationVisibleDropdown
                                                .value = false;
                                            controller
                                                .fromLocationVisibleDropdown
                                                .value = false;
                                            controller.vendorOnClick.value =
                                                false;
                                            controller.isSub1.value = false;
                                            controller.isSub2.value = false;
                                            controller.ownerOnClick.value =
                                                false;
                                            controller.rendList.value = false;
                                          },
                                          controller: controller.rateController,
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          focusNode: controller.rateFocusNode,
                                          hintText: "Enter Rate Per",
                                          onTextChange: (string) {
                                            updateCombinedValue();
                                            controller.popUpValue.value = true;
                                          },
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: TextInput(
                                                controller: controller
                                                    .vendorNameController,
                                                height: 100,
                                                label: "Vendor Name",
                                                onPressed: () {
                                                  controller
                                                      .toLocationVisibleDropdown
                                                      .value = false;
                                                  controller
                                                      .fromLocationVisibleDropdown
                                                      .value = false;

                                                  controller.isSub1.value =
                                                      false;
                                                  controller.isSub2.value =
                                                      false;
                                                  controller.ownerOnClick
                                                      .value = false;
                                                  controller.rendList.value =
                                                      false;
                                                  if (controller
                                                      .vendorOnClick.value) {
                                                    controller.vendorOnClick
                                                        .value = false;
                                                  } else {
                                                    controller.vendorOnClick
                                                        .value = true;
                                                  }
                                                  controller
                                                      .vendorRefreshData();
                                                },
                                                obscureText: true,
                                                textInputType:
                                                    TextInputType.text,
                                                textColor: Color(0xCC252525),
                                                hintText: "Enter Vendor Name",
                                                onTextChange: (text) {
                                                  if (controller
                                                          .vendorNameController
                                                          .text ==
                                                      "") {
                                                    controller.getVendor(text);
                                                  }
                                                  if (text.length >= 2) {
                                                    controller.getVendor(text);
                                                  } else {
                                                    return;
                                                  }
                                                  controller.vendorName = text;
                                                },
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      content: Container(
                                                        child:
                                                            SingleChildScrollView(
                                                                child: Column(
                                                          children: [
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "VendorName",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .vendorNameAddController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter VendorName",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "VendorCompany",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .vendorCompanyController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter VendorCompany",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "VendorAddress",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .vendorAddressAddController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter VendorAddress",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "VendorGST",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .vendorGstController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter VendorGST",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "VendorMobile",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .vendorMobileController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .number,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter VendorMobile",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "VendorEmail",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .vendorEmailController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter VendorEmail",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "VendorService",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .vendorServiceController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter VendorService",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Center(
                                                              child: Button(
                                                                  widthFactor:
                                                                      0.8,
                                                                  heightFactor:
                                                                      0.06,
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .addVendor();
                                                                  },
                                                                  child: const Text(
                                                                      "Add",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.w600))),
                                                            ),
                                                          ],
                                                        )),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 45,
                                                margin: EdgeInsets.only(
                                                    top: 5, right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                ),
                                                child: Icon(Icons.add),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Obx(
                                          () => Visibility(
                                            visible:
                                                controller.vendorOnClick.value,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    12, 4, 12, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    6, 4, 6, 6),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppTheme
                                                        .inputBorderColor,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors
                                                      .white, // Set the desired background color
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      25,
                                                  child: Column(
                                                    children: List.generate(
                                                      controller
                                                          .vendorData.length,
                                                      (index) {
                                                        var model = controller
                                                            .vendorData[index];
                                                        return Container(
                                                          child: Column(
                                                            children: [
                                                              TextInput(
                                                                onPressed: () {
                                                                  if (model
                                                                          .vendorName !=
                                                                      null) {
                                                                    controller
                                                                            .vendorNameController
                                                                            .text =
                                                                        model
                                                                            .vendorName!;

                                                                    controller
                                                                        .vendorOnClick
                                                                        .value = false;
                                                                    controller
                                                                        .popUpValue
                                                                        .value = true;
                                                                  }
                                                                },
                                                                margin: false,
                                                                withImage:
                                                                    false,
                                                                isSelected: controller
                                                                        .vendorNameController
                                                                        .text ==
                                                                    model
                                                                        .vendorName,
                                                                label: "",
                                                                isEntryField:
                                                                    false,
                                                                textInputType:
                                                                    TextInputType
                                                                        .text,
                                                                textColor: Color(
                                                                    0xCC234345),
                                                                hintText: model
                                                                        .vendorName ??
                                                                    '',
                                                                obscureText:
                                                                    true,
                                                                onTextChange:
                                                                    (String) {},
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Visibility(
                                                                  visible: controller
                                                                          .vendorData
                                                                          .length !=
                                                                      index + 1,
                                                                  child:
                                                                      Container(
                                                                    height: 1,
                                                                    color: AppTheme
                                                                        .appBlack,
                                                                  ))
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
                                      ],
                                    )),
                                Visibility(
                                    visible: controller.ownedOnClick.value,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: TextInput(
                                                controller: controller
                                                    .registrationNumberController,
                                                height: 100,
                                                label: "Registration Number",
                                                onPressed: () {
                                                  controller.vendorOnClick
                                                      .value = false;
                                                  controller.rendList.value =
                                                      false;
                                                  controller
                                                      .toLocationVisibleDropdown
                                                      .value = false;
                                                  controller
                                                      .fromLocationVisibleDropdown
                                                      .value = false;
                                                  if (controller
                                                      .ownerOnClick.value) {
                                                    controller.ownerOnClick
                                                        .value = false;
                                                  } else {
                                                    controller.ownerOnClick
                                                        .value = true;
                                                  }
                                                  controller.ownerRefreshData();
                                                },
                                                //isReadOnly: true,
                                                obscureText: true,
                                                textInputType:
                                                    TextInputType.text,
                                                textColor: Color(0xCC252525),
                                                hintText:
                                                    "Enter Registration Number",
                                                onTextChange: (text) {
                                                  if (controller
                                                          .registrationNumberController
                                                          .text ==
                                                      "") {
                                                    controller.getOwner(text);
                                                  }
                                                  if (text.length >= 2) {
                                                    controller.getOwner(text);
                                                  } else {
                                                    return;
                                                  }
                                                  controller
                                                          .registrationNumber =
                                                      text;
                                                },
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  // Ensure that context is valid
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      content: Container(
                                                        child:
                                                            SingleChildScrollView(
                                                                child: Column(
                                                          children: [
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "Owner Name",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .ownerNameController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter Owner Name",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "Owner Contact",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .ownerContactController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .number,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter Owner Contact",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "Registration Number",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .registrationNumberAddController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter Registration Number",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            TextInput(
                                                              height: 100,
                                                              label:
                                                                  "Vehicle Details",
                                                              onPressed: () {},
                                                              controller: controller
                                                                  .vehiclesDetailsController,
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                              textColor: Color(
                                                                  0xCC252525),
                                                              hintText:
                                                                  "Enter Vehicle Details",
                                                              onTextChange:
                                                                  (string) {},
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Center(
                                                              child: Button(
                                                                  widthFactor:
                                                                      0.8,
                                                                  heightFactor:
                                                                      0.06,
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .ownerButtonClick
                                                                        .value = true;

                                                                    controller
                                                                        .addOwner();
                                                                    // Get.back();
                                                                  },
                                                                  child: const Text(
                                                                      "Add",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.w600))),
                                                            ),
                                                          ],
                                                        )),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 45,
                                                margin: EdgeInsets.only(
                                                    top: 5, right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                ),
                                                child: Icon(Icons.add),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Obx(
                                          () => Visibility(
                                            visible:
                                                controller.ownerOnClick.value,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    12, 4, 12, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    6, 4, 6, 6),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppTheme
                                                        .inputBorderColor,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors
                                                      .white, // Set the desired background color
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      25,
                                                  child: Column(
                                                    children: List.generate(
                                                      controller
                                                          .ownerData.length,
                                                      (index) {
                                                        var model = controller
                                                            .ownerData[index];
                                                        return Container(
                                                          child: Column(
                                                            children: [
                                                              TextInput(
                                                                onPressed: () {
                                                                  controller
                                                                          .registrationNumberController
                                                                          .text =
                                                                      controller
                                                                          .ownerData[
                                                                              index]
                                                                          .registerationNumber!;

                                                                  controller
                                                                      .ownerOnClick
                                                                      .value = false;
                                                                  controller
                                                                      .popUpValue
                                                                      .value = true;
                                                                },
                                                                margin: false,
                                                                withImage:
                                                                    false,
                                                                isSelected: controller
                                                                        .registrationNumberController
                                                                        .text ==
                                                                    controller
                                                                        .ownerData[
                                                                            index]
                                                                        .registerationNumber,
                                                                label: "",
                                                                isEntryField:
                                                                    false,
                                                                textInputType:
                                                                    TextInputType
                                                                        .text,
                                                                textColor: Color(
                                                                    0xCC234345),
                                                                hintText: model
                                                                    .registerationNumber,
                                                                obscureText:
                                                                    true,
                                                                onTextChange:
                                                                    (String) {},
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Visibility(
                                                                  visible: controller
                                                                          .ownerData
                                                                          .length !=
                                                                      index + 1,
                                                                  child:
                                                                      Container(
                                                                    height: 1,
                                                                    color: AppTheme
                                                                        .appBlack,
                                                                  ))
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
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.tollCharges.value,
                              child: TextInput(
                                height: 100,
                                label: "Toll Charges",
                                onPressed: () {
                                  controller.toLocationVisibleDropdown.value =
                                      false;
                                  controller.fromLocationVisibleDropdown.value =
                                      false;
                                  controller.vendorOnClick.value = false;
                                  controller.isSub1.value = false;
                                  controller.isSub2.value = false;
                                  controller.ownerOnClick.value = false;
                                  controller.rendList.value = false;
                                },
                                controller: controller.tollChargesController,
                                textInputType: TextInputType.number,
                                textColor: Color(0xCC252525),
                                focusNode: controller.tollChargesFocusNode,
                                hintText: "Enter Toll Charges",
                                onTextChange: (String) {
                                  updateCombinedValue();
                                  controller.popUpValue.value = true;
                                },
                              ),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.ticketCharges1.value,
                              child: TextInput(
                                height: 100,
                                label: "Ticket Charges*",
                                onPressed: () {
                                  controller.toLocationVisibleDropdown.value =
                                      false;
                                  controller.fromLocationVisibleDropdown.value =
                                      false;
                                  controller.vendorOnClick.value = false;
                                  controller.isSub1.value = false;
                                  controller.isSub2.value = false;
                                  controller.ownerOnClick.value = false;
                                  controller.rendList.value = false;
                                },
                                controller: controller.ticketController,
                                textInputType: TextInputType.number,
                                textColor: Color(0xCC252525),
                                hintText: " Enter Ticket Charges",
                                focusNode: controller.ticketChargesFocusNode,
                                onTextChange: (text) {
                                  updateCombinedValueFour();
                                  controller.popUpValue.value = true;
                                },
                              ),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.travelCharges.value,
                              child: TextInput(
                                height: 100,
                                label: "Travel Charges",
                                onPressed: () {
                                  controller.toLocationVisibleDropdown.value =
                                      false;
                                  controller.fromLocationVisibleDropdown.value =
                                      false;
                                  controller.vendorOnClick.value = false;
                                  controller.isSub1.value = false;
                                  controller.isSub2.value = false;
                                  controller.ownerOnClick.value = false;
                                  controller.rendList.value = false;
                                },
                                controller: controller.ticketController,
                                textInputType: TextInputType.number,
                                textColor: Color(0xCC252525),
                                hintText: "Travel Charges",
                                focusNode: controller.ticketChargesFocusNode,
                                onTextChange: (String) {
                                  updateCombinedValue();
                                  controller.popUpValue.value = true;
                                },
                              ),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.driverTips.value,
                              child: TextInput(
                                height: 100,
                                label: "Driver Tips",
                                onPressed: () {
                                  controller.toLocationVisibleDropdown.value =
                                      false;
                                  controller.fromLocationVisibleDropdown.value =
                                      false;
                                  controller.vendorOnClick.value = false;
                                  controller.isSub1.value = false;
                                  controller.isSub2.value = false;
                                  controller.ownerOnClick.value = false;
                                  controller.rendList.value = false;
                                },
                                controller: controller.driveTipsController,
                                textInputType: TextInputType.number,
                                focusNode: controller.driverTipsFocusNode,
                                textColor: Color(0xCC252525),
                                hintText: "Enter Driver Tips",
                                onTextChange: (String) {
                                  updateCombinedValue();
                                  controller.popUpValue.value = true;
                                },
                              ),
                            ),
                          ),
                          TextInput(
                            height: 100,
                            label: "Total Amount*",
                            onPressed: () {
                              controller.toLocationVisibleDropdown.value =
                                  false;
                              controller.fromLocationVisibleDropdown.value =
                                  false;
                              controller.vendorOnClick.value = false;
                              controller.isSub1.value = false;
                              controller.isSub2.value = false;
                              controller.ownerOnClick.value = false;
                              controller.rendList.value = false;
                            },
                            isReadOnly: true,
                            controller: controller.amountController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            focusNode: controller.amountFocusNode,
                            hintText: "Enter Total Amount",
                            onTextChange: (text) {
                              controller.popUpValue.value = true;
                              controller.ticketController.text = text;

                              updateCombinedSubValue();
                            },
                          ),
                          Obx(
                            () => Visibility(
                                visible: controller.rentOwnedOnClick.value,
                                child: Column(
                                  children: [
                                    TextInput(
                                      height: 100,
                                      label: "Currently Paid Amount",
                                      onPressed: () {
                                        controller.toLocationVisibleDropdown
                                            .value = false;
                                        controller.fromLocationVisibleDropdown
                                            .value = false;
                                        controller.vendorOnClick.value = false;
                                        controller.isSub1.value = false;
                                        controller.isSub2.value = false;
                                        controller.ownerOnClick.value = false;
                                        controller.rendList.value = false;
                                      },
                                      controller: controller
                                          .currentlyPaidAmountController,
                                      textInputType: TextInputType.number,
                                      textColor: Color(0xCC252525),
                                      hintText: "Enter Currently Paid Amount",
                                      focusNode: controller
                                          .currentlyPaidAmountFocusNode,
                                      onTextChange: (string) {
                                        updateCombinedSubValue();
                                        controller.popUpValue.value = true;
                                      },
                                    ),
                                    TextInput(
                                      height: 100,
                                      label: "Balance Amount",
                                      onPressed: () {
                                        controller.toLocationVisibleDropdown
                                            .value = false;
                                        controller.fromLocationVisibleDropdown
                                            .value = false;
                                        controller.vendorOnClick.value = false;
                                        controller.isSub1.value = false;
                                        controller.isSub2.value = false;
                                        controller.ownerOnClick.value = false;
                                        controller.rendList.value = false;
                                      },
                                      controller:
                                          controller.balanceAmountController,
                                      textInputType: TextInputType.number,
                                      textColor: Color(0xCC252525),
                                      hintText: "Enter Balance Amount",
                                      focusNode: controller.balanceFocusNode,
                                      isReadOnly: true,
                                      onTextChange: (string) {
                                        updateCombinedSubValue();
                                        controller.popUpValue.value = true;
                                      },
                                    ),
                                  ],
                                )),
                          ),
                          Obx(
                            () => Visibility(
                                visible: controller.ownedOnClick.value,
                                child: Column(
                                  children: [
                                    TextInput(
                                      height: 100,
                                      label: "Currently Paid Amount",
                                      onPressed: () {
                                        controller.toLocationVisibleDropdown
                                            .value = false;
                                        controller.fromLocationVisibleDropdown
                                            .value = false;
                                        controller.vendorOnClick.value = false;
                                        controller.isSub1.value = false;
                                        controller.isSub2.value = false;
                                        controller.ownerOnClick.value = false;
                                        controller.rendList.value = false;
                                      },
                                      controller: controller
                                          .currentlyPaidAmountController,
                                      textInputType: TextInputType.number,
                                      textColor: Color(0xCC252525),
                                      hintText: "Enter Currently Paid Amount",
                                      focusNode: controller
                                          .currentlyPaidAmountFocusNode,
                                      onTextChange: (string) {
                                        updateCombinedSubValue();
                                        controller.popUpValue.value = true;
                                      },
                                    ),
                                    TextInput(
                                      height: 100,
                                      label: "Balance Amount",
                                      onPressed: () {
                                        controller.toLocationVisibleDropdown
                                            .value = false;
                                        controller.fromLocationVisibleDropdown
                                            .value = false;
                                        controller.vendorOnClick.value = false;
                                        controller.isSub1.value = false;
                                        controller.isSub2.value = false;
                                        controller.ownerOnClick.value = false;
                                        controller.rendList.value = false;
                                      },
                                      controller:
                                          controller.balanceAmountController,
                                      textInputType: TextInputType.number,
                                      textColor: Color(0xCC252525),
                                      hintText: "Enter Balance Amount",
                                      isReadOnly: true,
                                      focusNode: controller.balanceFocusNode,
                                      onTextChange: (string) {
                                        updateCombinedSubValue();
                                        controller.popUpValue.value = true;
                                      },
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.commonVisible.value,
                      child: Row(
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
                                                    null
                                            ? Image.file(
                                                controller.itemImagePick!.value!
                                                    .imagePath,
                                                width: 150,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              )
                                            : controller.imagePathFromData.value
                                                        .isNotEmpty &&
                                                    controller
                                                        .isUpdateImageAvailable
                                                        .value
                                                ? Image.network(
                                                    controller
                                                        .imagePathFromData!
                                                        .value,
                                                    width: 150,
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
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
                              controller.toLocationVisibleDropdown.value =
                                  false;
                              controller.fromLocationVisibleDropdown.value =
                                  false;
                              controller.vendorOnClick.value = false;
                              controller.isSub1.value = false;
                              controller.isSub2.value = false;
                              controller.ownerOnClick.value = false;
                              controller.rendList.value = false;
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
                              controller.toLocationVisibleDropdown.value =
                                  false;
                              controller.fromLocationVisibleDropdown.value =
                                  false;
                              controller.ownerOnClick.value = false;
                              controller.rendList.value = false;
                              controller.toLocationVisibleDropdown.value =
                                  false;
                              controller.fromLocationVisibleDropdown.value =
                                  false;
                              controller.toLocationVisibleDropdown.value =
                                  false;
                              controller.fromLocationVisibleDropdown.value =
                                  false;
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
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
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
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.isAudio.value,
                      child: Column(
                        children: [
                          controller.userDataProvider.getCurrentStatus ==
                                      "Edit" ||
                                  controller
                                          .userDataProvider.getCurrentStatus ==
                                      "Re-Use"
                              ? Container()
                              : Container(
                                  child: Row(
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                              child: GestureDetector(
                                            onTap: () {
                                              if (controller.userDataProvider
                                                          .getCurrentStatus ==
                                                      "Edit" ||
                                                  controller.userDataProvider
                                                          .getCurrentStatus ==
                                                      "Re-Use") {
                                                controller.deleteOldData();
                                              }
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
                                //SizedBox(width: 20),
                                StreamBuilder<PlayerState>(
                                    stream: controller
                                        .audioPlayer.playerStateStream,
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
                                            onPressed:
                                                controller.audioPlayer.pause,
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
                      controller.toLocationVisibleDropdown.value = false;
                      controller.fromLocationVisibleDropdown.value = false;
                      controller.vendorOnClick.value = false;
                      controller.isSub1.value = false;
                      controller.isSub2.value = false;
                      controller.ownerOnClick.value = false;
                      controller.rendList.value = false;
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
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child:  Obx(() =>    Button(
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
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Button(
                                            widthFactor: 0.28,
                                            heightFactor: 0.04,
                                            onPressed: () {
                                              controller.updateTravel();
                                            },
                                            child: Text(
                                              "Yes",
                                              style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
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
                              controller.updateTravel();
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
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Button(
                                            widthFactor: 0.28,
                                            heightFactor: 0.04,
                                            onPressed: () {
                                              controller.insertTravel();
                                            },
                                            child: Text(
                                              "Yes",
                                              style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
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
                              controller.insertTravel();
                            }
                          } else {
                            controller.insertTravel();
                          }
                        },
                        child:  controller.uploadLoading.isTrue ? CircularProgressIndicator():    Text(
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
                  SizedBox(
                    height: 15,
                  ),
                ]),
              ),
            )));
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey,
      actions: [
        KeyboardActionsItem(
          focusNode: controller.startingKmFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.closingKmFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.tollChargesFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.amountFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.ticketChargesFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.driverTipsFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.durationFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.balanceFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.currentlyPaidAmountFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.totalChargesFocusNode,
        ),
      ],
    );
  }
}
