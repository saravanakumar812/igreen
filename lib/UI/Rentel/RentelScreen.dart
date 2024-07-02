import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/AudioPlayer/extensions.dart';
import 'package:intl/intl.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../AudioPlayer/animated_favorite_button.dart';
import '../../Components/DateRangeExample.dart';
import '../../Controller/RentedScreenController.dart';
import '../../Utils/image_picker.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
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

class RentedScreen extends GetView<RentedScreenController> {
  const RentedScreen({super.key});

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          controller.audioPlayer.positionStream,
          controller.audioPlayer.bufferedPositionStream,
          controller.audioPlayer.durationStream,
          (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration!));

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
    // String durationText = controller.durationController.text;
    // String rateText = controller.rateController.text;
    // int duration = int.tryParse(durationText) ?? 0;
    // int rate = int.tryParse(rateText) ?? 0;
    // int result = (duration1 * rate1) ;
    // controller.totalChargesController.text = result.toString();

    // String totalText = controller.totalChargesController.text;
    String currentlyPaidText = controller.currentlyPaidAmountController.text;
    //int totalPaid = int.tryParse(totalText) ?? 0;
    double currentlyPaid = double.tryParse(currentlyPaidText) ?? 0;
    //int result1 = (totalPaid - currentlyPaid).abs();
    //controller.balanceAmountController.text = result1.toString();

    String rateText1 = controller.rateController.text;
    String currentlyPaidText1 = controller.currentlyPaidAmountController.text;
    double rate1 = double.tryParse(rateText1) ?? 0;
    double currentlyPaid1 = double.tryParse(currentlyPaidText1) ?? 0;
    double result2 = rate1 - currentlyPaid1;
    controller.balanceAmountController.text = result2.toString();

    String durationText1 = controller.durationController.text;
    String currentlyPaidText2 = controller.currentlyPaidAmountController.text;
    int duration1 = int.tryParse(durationText1) ?? 0;
    int currentlyPaid2 = int.tryParse(currentlyPaidText2) ?? 0;
    int result3 = duration1 - currentlyPaid2;
    controller.balanceAmountController.text = result3.toString();

    double totalCharges = rate1 * duration1;
    if (totalCharges != 0) {
      double result4 = totalCharges - currentlyPaid;
      controller.balanceAmountController.text = result4.toString();
    }
    controller.totalChargesController.text = totalCharges.toString();
    if (controller.currentlyPaidAmountController.text.isEmpty ||
        currentlyPaid == 0) {
      controller.balanceAmountController.text = totalCharges.toString();
    }

    if (totalCharges != 0 && currentlyPaid != 0) {
      double result1 = (totalCharges - currentlyPaid);
      double balanceAmount = result1 < 0 ? 0.0 : result1;
      controller.balanceAmountController.text = balanceAmount.toString();
    }

    if (currentlyPaid == 0) {
      // If currentlyPaid is 0, set balanceAmountController to totalCharges
      controller.balanceAmountController.text = totalCharges.toString();
    } else if (totalCharges > currentlyPaid) {
      // Only update balanceAmountController if it is greater than currentlyPaid
      double remainingBalance = totalCharges - currentlyPaid;
      controller.balanceAmountController.text = remainingBalance.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    RentedScreenController controller = Get.put(RentedScreenController());

    late final SongRepository songRepository;
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
                              Get.offNamed(AppRoutes.rentSummary.toName);
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
                        width: 34,
                      ),
                      Text(
                        controller.userDataProvider.getCurrentStatus
                                    .toString() ==
                                'Edit'
                            ? "Update Rental Expense"
                            : "Add Rental Expense",
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
            body: KeyboardActions(
              config: _buildKeyboardActionsConfig(context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextInput(
                      height: 100,
                      label: "Type*",
                      onPressed: () {
                        if (controller.subOneController.text == "") {
                          controller.subCategoryFuel('');
                        }

                        if (controller.subCategoryDropDownOne.value) {
                          controller.subCategoryDropDownOne.value = false;
                        } else {
                          controller.subCategoryDropDownOne.value = true;
                        }

                        controller.subCategoryDropDownTwoOnClick.value = false;
                        controller.rentTypeDropDown.value = false;
                        controller.vendorOnClick.value = false;
                        controller.rendList.value = false;
                      },
                      controller: controller.subOneController,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Select Type ",
                      obscureText: true,
                      onTextChange: (text) {
                        if (controller.subOneController.text == '') {
                          controller.subCategoryFuel('');
                        }
                        if (text.length >= 2) {
                          controller.subCategoryFuel(text);
                        } else {
                          return;
                        }
                        controller.subcategoryName = text;
                      },
                    ),
                    Obx(() => Visibility(
                          visible: controller.subCategoryDropDownOne.value,
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
                                  controller.fuelSubCategoryData.length,
                                  (index) {
                                    var model =
                                        controller.fuelSubCategoryData[index];
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller.subOneController.text =
                                                  controller
                                                      .fuelSubCategoryData[
                                                          index]!
                                                      .sub1CategoryName
                                                      .toString();
                                              controller.selectedSub1Index
                                                  .value = index;
                                              controller.subCategoryFuel('');
                                              controller.fetchSubCategoryTwo(
                                                  controller
                                                      .fuelSubCategoryData[
                                                          index]
                                                      .sub1CategoryId,
                                                  "");
                                              controller.subCategoryDropDownOne
                                                  .value = false;
                                              controller.subCategoryDropDownTwo
                                                  .value = true;
                                              controller.allFieldVisible.value =
                                                  true;
                                              controller.popUpValue.value =
                                                  true;
                                              controller.rendDetails.clear();
                                              controller.typeController.text =
                                                  "";
                                              controller.rendDetails
                                                  .add('Litter');
                                              controller.rendDetails
                                                  .add('Meter');

                                              if (controller
                                                      .subOneController.text ==
                                                  'Truck') {
                                                controller.rendDetails
                                                    .add('Month');

                                                controller.rendDetails
                                                    .add('Day');
                                                controller.rendDetails
                                                    .add('Lease');
                                                controller.rendDetails
                                                    .add('One Time');
                                              }
                                              if (controller
                                                      .subOneController.text ==
                                                  'Trencher') {
                                                controller.rendDetails
                                                    .add('Per Hour');
                                                controller.rendDetails
                                                    .add('Day');

                                                controller.rendDetails
                                                    .add('Month Basis');
                                                controller.rendDetails
                                                    .add('One Time');
                                                controller.rendDetails
                                                    .add('Lease');
                                                controller.rendDetails
                                                    .add('Shot Length(meters)');
                                              }
                                              if (controller
                                                      .subOneController.text ==
                                                  'Earth movers') {
                                                controller.rendDetails
                                                    .add('Per Hour');
                                                controller.rendDetails
                                                    .add('Day');
                                                controller.rendDetails
                                                    .add('Month Basis');
                                                controller.rendDetails
                                                    .add('One Time');
                                                controller.rendDetails
                                                    .add('Lease');
                                              }

                                              if (controller
                                                      .subOneController.text ==
                                                  'Hydra') {
                                                controller.rendDetails
                                                    .add('Per Hour');
                                                controller.rendDetails
                                                    .add('Day');
                                                controller.rendDetails
                                                    .add('Month Basis');
                                                controller.rendDetails
                                                    .add('One Time');
                                                controller.rendDetails
                                                    .add('Lease');
                                              }

                                              if (controller
                                                      .subOneController.text ==
                                                  'Suction truck') {
                                                controller.rendDetails
                                                    .add('Per Hour');
                                                controller.rendDetails
                                                    .add('Day');
                                                controller.rendDetails
                                                    .add('Month Basis');
                                                controller.rendDetails
                                                    .add('One Time');
                                                controller.rendDetails
                                                    .add('Lease');
                                              }
                                              if (controller
                                                      .subOneController.text ==
                                                  'Pilling equipment') {
                                                controller.rendDetails
                                                    .add('Per Hour');
                                                controller.rendDetails
                                                    .add('Day');
                                                controller.rendDetails
                                                    .add('Month Basis');
                                                controller.rendDetails
                                                    .add('One Time');
                                                controller.rendDetails
                                                    .add('Lease');
                                                controller.rendDetails
                                                    .add('Feet');
                                                controller.rendDetails
                                                    .add('Meters');
                                              }
                                              if (controller
                                                      .subOneController.text ==
                                                  'WINCH MACHINE') {
                                                controller.rendDetails
                                                    .add('Per Hour');
                                                controller.rendDetails
                                                    .add('Day');
                                                controller.rendDetails
                                                    .add('Month Basis');
                                                controller.rendDetails
                                                    .add('One Time');
                                                controller.rendDetails
                                                    .add('Lease');
                                                controller.rendDetails
                                                    .add('Feet');
                                                controller.rendDetails
                                                    .add('Meters');
                                              }
                                              if (controller
                                                      .subOneController.text ==
                                                  'Motor') {
                                                controller.rendDetails
                                                    .add('Per Hour');
                                                controller.rendDetails
                                                    .add('Day');
                                                controller.rendDetails
                                                    .add('Month Basis');
                                                controller.rendDetails
                                                    .add('One Time');
                                                controller.rendDetails
                                                    .add('Lease');
                                              }
                                              if (controller
                                                      .subOneController.text ==
                                                  'Generator set') {
                                                controller.rendDetails
                                                    .add('Per Hour');
                                                controller.rendDetails
                                                    .add('Day');
                                                controller.rendDetails
                                                    .add('Month Basis');
                                                controller.rendDetails
                                                    .add('One Time');
                                                controller.rendDetails
                                                    .add('Lease');
                                              }
                                              if (controller
                                                      .subOneController.text ==
                                                  'Others') {
                                                controller.rendDetails
                                                    .add('Per Hour');
                                                controller.rendDetails
                                                    .add('Day');
                                                controller.rendDetails
                                                    .add('Month Basis');
                                                controller.rendDetails
                                                    .add('One Time');
                                                controller.rendDetails
                                                    .add('Lease');
                                                controller.rendDetails
                                                    .add('Feet');
                                              }

                                              controller.hrVisible.value =
                                                  false;
                                              controller.othersVisible.value =
                                                  false;
                                              controller.kmVisible.value =
                                                  false;

                                              controller.subCategoryDropDownTwo
                                                  .value = false;

                                              if (controller
                                                      .subOneController.text ==
                                                  'Earth movers') {
                                                controller
                                                    .subCategoryDropDownTwo
                                                    .value = true;
                                                controller.refreshDataKm();
                                              } else if (controller
                                                          .subOneController
                                                          .text ==
                                                      'Motor' ||
                                                  controller.subOneController
                                                          .text ==
                                                      'WINCH MACHINE' ||
                                                  controller.subOneController
                                                          .text ==
                                                      'Generator set' ||
                                                  controller.subOneController
                                                          .text ==
                                                      'Suction truck') {
                                                controller.hrVisible.value =
                                                    true;
                                                controller.refreshDataKm();
                                              } else if (controller
                                                      .subOneController.text ==
                                                  'Trencher') {
                                                controller.kmVisible.value =
                                                    false;
                                                controller
                                                    .subCategoryDropDownTwo
                                                    .value = true;
                                                controller.hrVisible.value =
                                                    false;
                                                controller.refreshDataKm();
                                              } else if (controller
                                                      .subOneController.text ==
                                                  'Pilling equipment') {
                                                controller.kmVisible.value =
                                                    false;
                                                controller
                                                    .subCategoryDropDownTwo
                                                    .value = true;
                                                controller.hrVisible.value =
                                                    true;
                                                controller.refreshDataKm();
                                              } else if (controller
                                                      .subOneController.text ==
                                                  'Truck') {
                                                controller
                                                    .subCategoryDropDownTwo
                                                    .value = true;
                                                controller.refreshDataKm();
                                              } else if (controller
                                                      .subOneController.text ==
                                                  'Hydra') {
                                                controller
                                                    .subCategoryDropDownTwo
                                                    .value = true;
                                              } else {
                                                controller.othersVisible.value =
                                                    true;
                                                controller.kmVisible.value =
                                                    true;
                                                controller.hrVisible.value =
                                                    true;
                                                controller.refreshDataKm();
                                                controller.refreshDataHr();
                                              }
                                            },
                                            margin: false,
                                            withImage: true,
                                            imagePath: controller
                                                .fuelSubCategoryData[index]
                                                .sub1CategoryImage,
                                            isSelected: controller
                                                    .subOneController.text ==
                                                controller
                                                    .fuelSubCategoryData[index]
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
                                                      .fuelSubCategoryData
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
                    Obx(
                      () => Visibility(
                        visible: controller.subCategoryDropDownTwo.value,
                        child: TextInput(
                          height: 100,
                          label: "Type*",
                          onPressed: () {
                            if (controller
                                .subCategoryDropDownTwoOnClick.value) {
                              controller.subCategoryDropDownTwoOnClick.value =
                                  false;
                            } else {
                              controller.subCategoryDropDownTwoOnClick.value =
                                  true;
                            }
                            if (controller.userDataProvider.getCurrentStatus ==
                                    "Edit" ||
                                controller.userDataProvider.getCurrentStatus ==
                                    "Re-Use") {
                              for (int i = 0;
                                  i < controller.fuelSubCategoryData.length;
                                  i++) {
                                if (controller.fuelSubCategoryData[i]
                                        .sub1CategoryName ==
                                    controller.userDataProvider.getRentData!
                                        .category2) {
                                  controller.fetchSubCategoryTwo(
                                      controller.fuelSubCategoryData[i]
                                          .sub1CategoryId,
                                      "");
                                }
                              }
                            }
                            controller.subCategoryDropDownOne.value = false;
                            controller.rentTypeDropDown.value = false;
                            controller.vendorOnClick.value = false;
                            controller.rendList.value = false;
                          },
                          controller: controller.subTwoController,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          obscureText: true,
                          //isReadOnly: true,
                          hintText: "Select Type ",
                          onTextChange: (String) {
                            if (controller.subTwoController.text == "") {
                              controller.fetchSubCategoryTwo(
                                  controller
                                      .fuelSubCategoryData[
                                          controller.selectedSub1Index.value]
                                      .sub1CategoryId,
                                  String);
                            }
                            controller.fetchSubCategoryTwo(
                                controller
                                    .fuelSubCategoryData[
                                        controller.selectedSub1Index.value]
                                    .sub1CategoryId,
                                String);
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.othersVisible.value,
                        child: TextInput(
                          height: 100,
                          label: "Other Rental Categories ",
                          onPressed: () {
                            controller.subCategoryDropDownTwoOnClick.value =
                                false;
                            controller.subCategoryDropDownOne.value = false;
                            controller.rentTypeDropDown.value = false;
                            controller.vendorOnClick.value = false;
                            controller.rendList.value = false;
                          },
                          controller: controller.othersController,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Other Categories",
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                      ),
                    ),
                    Obx(() => Visibility(
                          visible:
                              controller.subCategoryDropDownTwoOnClick.value,
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
                                    var model =
                                        controller.fetchCategoryTwo[index];
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller.subTwoController.text =
                                                  controller
                                                      .fetchCategoryTwo[index]!
                                                      .sub2CategoryName
                                                      .toString();
                                              controller
                                                  .subCategoryDropDownTwoOnClick
                                                  .value = false;
                                              controller.hrVisible.value =
                                                  false;
                                              controller.kmVisible.value =
                                                  false;
                                              if (controller
                                                          .subTwoController.text ==
                                                      'Tractor' ||
                                                  controller
                                                          .subTwoController.text ==
                                                      'TYRE MOUNTED' ||
                                                  controller
                                                          .subTwoController.text ==
                                                      'ROCK TRENCHER' ||
                                                  controller
                                                          .subTwoController.text ==
                                                      'MICRO TRENCHER' ||
                                                  controller
                                                          .subTwoController.text ==
                                                      'TRENCHER' ||
                                                  controller.subTwoController
                                                          .text ==
                                                      'FOUR WHEEL' ||
                                                  controller.subTwoController
                                                          .text ==
                                                      'Small' ||
                                                  controller.subTwoController
                                                          .text ==
                                                      'Large') {
                                                controller.hrVisible.value =
                                                    true;
                                                controller.refreshDataKm();
                                                //controller.refreshDataHr();
                                              } else if (controller
                                                      .subTwoController.text ==
                                                  'BELT MOUNTED') {
                                                controller.hrVisible.value =
                                                    true;
                                                //controller.refreshDataKm();
                                                controller.refreshDataHr();
                                              } else {
                                                controller.kmVisible.value =
                                                    true;
                                                //controller.refreshDataKm();
                                                controller.refreshDataHr();
                                              }
                                              controller.popUpValue.value =
                                                  true;
                                            },
                                            margin: false,
                                            withImage: true,
                                            imagePath: controller
                                                .fetchCategoryTwo[index]
                                                .sub2CategoryImage,
                                            isSelected: controller
                                                    .subTwoController.text ==
                                                controller
                                                    .fetchCategoryTwo[index]
                                                    .sub2CategoryName,
                                            label: "",
                                            isEntryField: false,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC234345),
                                            hintText: model.sub2CategoryName,
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
                    Obx(
                      () => Visibility(
                        visible: controller.allFieldVisible.value,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: (width / 2) - 5,
                                      child: TextInput(
                                        height: 100,
                                        label: "Type*",
                                        onPressed: () {
                                          controller
                                              .subCategoryDropDownTwoOnClick
                                              .value = false;
                                          controller.subCategoryDropDownOne
                                              .value = false;
                                          controller.rentTypeDropDown.value =
                                              false;
                                          controller.vendorOnClick.value =
                                              false;
                                          if (controller.rendList.value) {
                                            controller.rendList.value = false;
                                          } else {
                                            controller.rendList.value = true;
                                          }
                                        },
                                        controller: controller.typeController,
                                        textInputType: TextInputType.number,
                                        textColor: Color(0xCC252525),
                                        obscureText: true,
                                        isReadOnly: true,
                                        hintText: "Select  Duration Type",
                                        onTextChange: (string) {},
                                      ),
                                    ),
                                    Container(
                                      width: (width / 2) - 5,
                                      child: TextInput(
                                        height: 100,
                                        label: "Duration*",
                                        onPressed: () {
                                          controller
                                              .subCategoryDropDownTwoOnClick
                                              .value = false;
                                          controller.subCategoryDropDownOne
                                              .value = false;
                                          controller.rentTypeDropDown.value =
                                              false;
                                          controller.vendorOnClick.value =
                                              false;
                                          controller.rendList.value = false;
                                        },
                                        controller:
                                            controller.durationController,
                                        focusNode: controller.durationFocusNode,
                                        textInputType: TextInputType.number,
                                        textColor: Color(0xCC252525),
                                        hintText: "Enter Duration",
                                        onTextChange: (string) {
                                          updateCombinedValue();
                                          controller.popUpValue.value = true;
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
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              25,
                                          height: height * 0.2,
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
                                          child: SingleChildScrollView(
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
                                                                  .typeController
                                                                  .text = controller
                                                                      .rendDetails[
                                                                  index];
                                                              controller
                                                                      .rendList
                                                                      .value =
                                                                  false;

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
                                                            isEntryField: false,
                                                            textInputType:
                                                                TextInputType
                                                                    .text,
                                                            textColor: Color(
                                                                0xCC234345),
                                                            hintText: controller
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
                                                            child: Container(
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
                                      ),
                                    )),
                                TextInput(
                                  height: 100,
                                  label: "Rate*",
                                  onPressed: () {
                                    controller.subCategoryDropDownTwoOnClick
                                        .value = false;
                                    controller.subCategoryDropDownOne.value =
                                        false;
                                    controller.rentTypeDropDown.value = false;
                                    controller.vendorOnClick.value = false;
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
                                Obx(() => Visibility(
                                      visible: controller.hrVisible.value,
                                      child: Column(children: [
                                        TextInput(
                                          onPressed: () {
                                            controller
                                                .subCategoryDropDownTwoOnClick
                                                .value = false;
                                            controller.subCategoryDropDownOne
                                                .value = false;
                                            controller.rentTypeDropDown.value =
                                                false;
                                            controller.vendorOnClick.value =
                                                false;
                                            controller.rendList.value = false;
                                            _selectStartDate(context);
                                          },
                                          controller: controller
                                              .startDateAndTimeController,
                                          height: 100,
                                          isReadOnly: true,
                                          label: "Starting hr*",
                                          onTextChange: (text) {
                                            controller
                                                .startDateAndTimeController
                                                .text = text;
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
                                              controller
                                                  .subCategoryDropDownTwoOnClick
                                                  .value = false;
                                              controller.subCategoryDropDownOne
                                                  .value = false;
                                              controller.rentTypeDropDown
                                                  .value = false;
                                              controller.vendorOnClick.value =
                                                  false;
                                              controller.rendList.value = false;
                                              //
                                              _selectEndDate(context);
                                            },
                                            controller: controller
                                                .closeDateAndTimeController,
                                            height: 100,
                                            isReadOnly: true,
                                            label: "Closing hr*",
                                            onTextChange: (text) {
                                              controller
                                                  .closeDateAndTimeController
                                                  .text = text;
                                              controller.popUpValue.value =
                                                  true;
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
                                              controller
                                                  .subCategoryDropDownTwoOnClick
                                                  .value = false;
                                              controller.subCategoryDropDownOne
                                                  .value = false;
                                              controller.rentTypeDropDown
                                                  .value = false;
                                              controller.vendorOnClick.value =
                                                  false;
                                              controller.rendList.value = false;
                                            },
                                            controller:
                                                controller.staringKmController,
                                            height: 100,
                                            label: "Starting km*",
                                            textInputType: TextInputType.number,
                                            textColor: Color(0xCC252525),
                                            hintText: "Enter Starting km",
                                            focusNode:
                                                controller.startingKmFocusNode,
                                            onTextChange: (text) {
                                              controller.popUpValue.value =
                                                  true;
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
                                              controller
                                                  .subCategoryDropDownTwoOnClick
                                                  .value = false;
                                              controller.subCategoryDropDownOne
                                                  .value = false;
                                              controller.rentTypeDropDown
                                                  .value = false;
                                              controller.vendorOnClick.value =
                                                  false;
                                              controller.rendList.value = false;
                                            },
                                            controller:
                                                controller.closingKmController,
                                            height: 100,
                                            label: " Closing km*",
                                            textInputType: TextInputType.number,
                                            textColor: Color(0xCC252525),
                                            hintText: "Enter Closing km",
                                            focusNode:
                                                controller.closingKmFocusNode,
                                            onTextChange: (text) {
                                              controller.popUpValue.value =
                                                  true;
                                            },
                                          ),
                                        ),
                                      ]),
                                    )),
                                TextInput(
                                  height: 100,
                                  label: "Comments*",
                                  onPressed: () {
                                    controller.isSuggestionComments.value =
                                        !controller.isSuggestionComments.value;
                                    controller.subCategoryDropDownTwoOnClick
                                        .value = false;
                                    controller.subCategoryDropDownOne.value =
                                        false;
                                    controller.rentTypeDropDown.value = false;
                                    controller.vendorOnClick.value = false;
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
                                      visible:
                                          controller.isSuggestionComments.value,
                                      child: Container(
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
                                        child: IntrinsicHeight(
                                          child: Column(
                                            children: List.generate(
                                              controller.suggestionList.length,
                                              (index) {
                                                var model = controller
                                                    .suggestionList[index];
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      TextInput(
                                                        onPressed: () {
                                                          controller
                                                                  .commentController
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
                                                                .suggestionList[
                                                                    index]
                                                                .suggestion,
                                                        label: "",
                                                        isEntryField: false,
                                                        textInputType:
                                                            TextInputType.text,
                                                        textColor:
                                                            Color(0xCC234345),
                                                        hintText:
                                                            model.suggestion,
                                                        obscureText: true,
                                                        onTextChange:
                                                            (String) {},
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
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          60,
                                      child: TextInput(
                                        controller:
                                            controller.vendorNameController,
                                        height: 100,
                                        label: "Vendor Name*",
                                        onPressed: () {
                                          controller
                                              .subCategoryDropDownTwoOnClick
                                              .value = false;
                                          controller.subCategoryDropDownOne
                                              .value = false;
                                          controller.rentTypeDropDown.value =
                                              false;
                                          controller.vendorOnClick.value =
                                              !controller.vendorOnClick.value;
                                          controller.rendList.value = false;
                                          // if (controller.vendorOnClick.value) {
                                          //   controller.vendorOnClick.value =
                                          //   false;
                                          // } else {
                                          //   controller.vendorOnClick.value =
                                          //   true;
                                          // }
                                          controller.refreshData();
                                          if (controller
                                                  .vendorNameController.text ==
                                              "") {
                                            controller.getVendor('');
                                          }
                                        },
                                        // isReadOnly: true,
                                        obscureText: true,
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Enter Vendor Name",
                                        onTextChange: (loc) {
                                          if (loc.length >= 2) {
                                            controller.getVendor(loc);
                                          } else {
                                            return;
                                          }
                                          controller.vendorName = loc;
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.subCategoryDropDownTwoOnClick
                                            .value = false;
                                        controller.subCategoryDropDownOne
                                            .value = false;
                                        controller.rentTypeDropDown.value =
                                            false;
                                        controller.vendorOnClick.value = false;
                                        controller.rendList.value = false;
                                        showDialog(
                                          context: context,
                                          // Ensure that context is valid
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              content: Container(
                                                child: SingleChildScrollView(
                                                    child: Column(
                                                  children: [
                                                    TextInput(
                                                      height: 100,
                                                      label: "VendorName",
                                                      onPressed: () {},
                                                      controller: controller
                                                          .vendorNameAddController,
                                                      textInputType:
                                                          TextInputType.text,
                                                      textColor:
                                                          Color(0xCC252525),
                                                      hintText:
                                                          "Enter VendorName",
                                                      onTextChange: (string) {
                                                        controller.popUpValue
                                                            .value = true;
                                                      },
                                                    ),
                                                    TextInput(
                                                      height: 100,
                                                      label: "VendorCompany",
                                                      onPressed: () {},
                                                      controller: controller
                                                          .vendorCompanyController,
                                                      textInputType:
                                                          TextInputType.text,
                                                      textColor:
                                                          Color(0xCC252525),
                                                      hintText:
                                                          "Enter VendorCompany",
                                                      onTextChange: (string) {
                                                        controller.popUpValue
                                                            .value = true;
                                                      },
                                                    ),
                                                    TextInput(
                                                      height: 100,
                                                      label: "VendorAddress",
                                                      onPressed: () {},
                                                      controller: controller
                                                          .vendorAddressAddController,
                                                      textInputType:
                                                          TextInputType.text,
                                                      textColor:
                                                          Color(0xCC252525),
                                                      hintText:
                                                          "Enter VendorAddress",
                                                      onTextChange: (string) {
                                                        controller.popUpValue
                                                            .value = true;
                                                      },
                                                    ),
                                                    TextInput(
                                                      height: 100,
                                                      label: "VendorGST",
                                                      onPressed: () {},
                                                      controller: controller
                                                          .vendorGstController,
                                                      textInputType:
                                                          TextInputType.text,
                                                      textColor:
                                                          Color(0xCC252525),
                                                      hintText:
                                                          "Enter VendorGST",
                                                      onTextChange: (string) {
                                                        controller.popUpValue
                                                            .value = true;
                                                      },
                                                    ),
                                                    TextInput(
                                                      height: 100,
                                                      label: "VendorMobile",
                                                      onPressed: () {},
                                                      controller: controller
                                                          .vendorMobileController,
                                                      textInputType:
                                                          TextInputType.number,
                                                      textColor:
                                                          Color(0xCC252525),
                                                      hintText:
                                                          "Enter VendorMobile",
                                                      onTextChange: (string) {
                                                        controller.popUpValue
                                                            .value = true;
                                                      },
                                                    ),
                                                    TextInput(
                                                      height: 100,
                                                      label: "VendorEmail",
                                                      onPressed: () {},
                                                      controller: controller
                                                          .vendorEmailController,
                                                      textInputType:
                                                          TextInputType.text,
                                                      textColor:
                                                          Color(0xCC252525),
                                                      hintText:
                                                          "Enter VendorEmail",
                                                      onTextChange: (string) {
                                                        controller.popUpValue
                                                            .value = true;
                                                      },
                                                    ),
                                                    TextInput(
                                                      height: 100,
                                                      label: "VendorService",
                                                      onPressed: () {},
                                                      controller: controller
                                                          .vendorServiceController,
                                                      textInputType:
                                                          TextInputType.text,
                                                      textColor:
                                                          Color(0xCC252525),
                                                      hintText:
                                                          "Enter VendorService",
                                                      onTextChange: (string) {
                                                        controller.popUpValue
                                                            .value = true;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Center(
                                                      child: Button(
                                                          widthFactor: 0.8,
                                                          heightFactor: 0.06,
                                                          onPressed: () {
                                                            controller
                                                                .addVendor();
                                                          },
                                                          child: const Text(
                                                              "Add",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
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
                                        margin:
                                            EdgeInsets.only(top: 5, right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.vendorOnClick.value,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: height * 0.2,
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
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              25,
                                          height: height * 0.2,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: List.generate(
                                                controller.vendorData.length,
                                                (index) {
                                                  var model = controller
                                                      .vendorData[index];
                                                  return Container(
                                                    child: Column(
                                                      children: [
                                                        TextInput(
                                                          onPressed: () {
                                                            controller
                                                                    .vendorNameController
                                                                    .text =
                                                                controller
                                                                    .vendorData[
                                                                        index]
                                                                    .vendorName!;

                                                            controller
                                                                .vendorOnClick
                                                                .value = false;
                                                            controller
                                                                .popUpValue
                                                                .value = true;
                                                          },
                                                          margin: false,
                                                          withImage: false,
                                                          isSelected: controller
                                                                  .vendorNameController
                                                                  .text ==
                                                              controller
                                                                  .vendorData[
                                                                      index]
                                                                  .vendorName,
                                                          label: "",
                                                          isEntryField: false,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          textColor:
                                                              Color(0xCC234345),
                                                          hintText:
                                                              model.vendorName,
                                                          obscureText: true,
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
                                ),
                                TextInput(
                                  height: 100,
                                  label: "Currently Paid Amount*",
                                  onPressed: () {
                                    controller.subCategoryDropDownTwoOnClick
                                        .value = false;
                                    controller.subCategoryDropDownOne.value =
                                        false;
                                    controller.rentTypeDropDown.value = false;
                                    controller.vendorOnClick.value = false;
                                    controller.rendList.value = false;
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
                                    controller.subCategoryDropDownTwoOnClick
                                        .value = false;
                                    controller.subCategoryDropDownOne.value =
                                        false;
                                    controller.rentTypeDropDown.value = false;
                                    controller.vendorOnClick.value = false;
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
                                    //function1();
                                    updateCombinedValue();
                                    controller.popUpValue.value = true;
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: (width / 2) - 5,
                                      child: TextInput(
                                        height: 100,
                                        label: "Rent Type*",
                                        onPressed: () {
                                          controller
                                              .subCategoryDropDownTwoOnClick
                                              .value = false;
                                          controller.subCategoryDropDownOne
                                              .value = false;
                                          // controller.rentTypeDropDown.value =
                                          // false;
                                          controller.vendorOnClick.value =
                                              false;
                                          controller.rendList.value = false;
                                          if (controller
                                              .rentTypeDropDown.value) {
                                            controller.rentTypeDropDown.value =
                                                false;
                                          } else {
                                            controller.rentTypeDropDown.value =
                                                true;
                                          }
                                        },
                                        controller: controller.rentController,
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
                                        label: "Rent Charges*",
                                        isReadOnly: true,
                                        onPressed: () {
                                          controller
                                              .subCategoryDropDownTwoOnClick
                                              .value = false;
                                          controller.subCategoryDropDownOne
                                              .value = false;
                                          controller.rentTypeDropDown.value =
                                              false;
                                          controller.vendorOnClick.value =
                                              false;
                                          controller.rendList.value = false;
                                        },
                                        controller:
                                            controller.totalChargesController,
                                        textInputType: TextInputType.number,
                                        textColor: Color(0xCC252525),
                                        hintText: "Enter Rent Charges ",
                                        focusNode:
                                            controller.totalChargesFocusNode,
                                        onTextChange: (string) {
                                          controller.popUpValue.value = true;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(() => Visibility(
                                      visible:
                                          controller.rentTypeDropDown.value,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              25,
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
                                          child: IntrinsicHeight(
                                            child: Column(
                                              children: List.generate(
                                                controller
                                                    .rendTypeDetail.length,
                                                (index) {
                                                  return Container(
                                                    child: Column(
                                                      children: [
                                                        TextInput(
                                                          onPressed: () {
                                                            controller
                                                                .rentController
                                                                .text = controller
                                                                    .rendTypeDetail[
                                                                index];
                                                            controller
                                                                .rentTypeDropDown
                                                                .value = false;

                                                            controller
                                                                .popUpValue
                                                                .value = true;
                                                          },
                                                          margin: false,
                                                          isSelected: controller
                                                                  .rentController
                                                                  .text ==
                                                              controller
                                                                      .rendTypeDetail[
                                                                  index]!,
                                                          label: "",
                                                          isEntryField: false,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          textColor:
                                                              Color(0xCC234345),
                                                          hintText: controller
                                                                  .rendTypeDetail[
                                                              index],
                                                          onTextChange:
                                                              (String) {},
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Visibility(
                                                          visible: controller
                                                                  .rendTypeDetail
                                                                  .length !=
                                                              index + 1,
                                                          child: Container(
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Obx(
                                      () => Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: AppTheme.liteWhite),
                                        ),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: controller
                                                    .startImageSelected.value
                                                ? null
                                                : Border.all(
                                                    color: AppTheme.liteWhite,
                                                    width: 3),
                                          ),
                                          child: Material(
                                            color: AppTheme.liteWhite,
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(
                                                  ImagePick(
                                                    isMultiple: true,
                                                    title: "Start Image ",
                                                    onClose: () => Get.back(),
                                                    onSave: (List<PickedImage>
                                                        images) {
                                                      if (images.isNotEmpty) {
                                                        controller
                                                            .itemImageStart
                                                            .value = images[0];
                                                        controller
                                                            .startImageSelected
                                                            .value = true;
                                                        // controller.clearImage();
                                                      }
                                                      Get.back();
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  controller.itemImageStart
                                                                  .value !=
                                                              null &&
                                                          controller
                                                                  .itemImageStart
                                                                  .value
                                                                  .imagePath !=
                                                              null
                                                      ? Image.file(
                                                          controller
                                                              .itemImageStart!
                                                              .value!
                                                              .imagePath,
                                                          width: 150,
                                                          height: 150,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : controller
                                                                  .startImagePathFromData
                                                                  .value
                                                                  .isNotEmpty &&
                                                              controller
                                                                  .isUpdateStartImageAvailable
                                                                  .value
                                                          ? Image.network(
                                                              controller
                                                                  .startImagePathFromData!
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
                                                                    "Start Image",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Colors
                                                                            .black),
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
                                    Obx(
                                      () => Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: AppTheme.liteWhite),
                                        ),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: controller
                                                    .endImageSelected.value
                                                ? null
                                                : Border.all(
                                                    color: AppTheme.liteWhite,
                                                    width: 3),
                                          ),
                                          child: Material(
                                            color: AppTheme.liteWhite,
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(
                                                  ImagePick(
                                                    isMultiple: true,
                                                    title: "End Image ",
                                                    onClose: () => Get.back(),
                                                    onSave: (List<PickedImage>
                                                        images) {
                                                      if (images.isNotEmpty) {
                                                        controller.itemImageEnd
                                                            .value = images[0];
                                                        controller
                                                            .endImageSelected
                                                            .value = true;
                                                        // controller.clearImage();
                                                      }
                                                      Get.back();
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  controller.itemImageEnd
                                                                  .value !=
                                                              null &&
                                                          controller
                                                                  .itemImageEnd
                                                                  .value
                                                                  .imagePath !=
                                                              null
                                                      ? Image.file(
                                                          controller
                                                              .itemImageEnd!
                                                              .value!
                                                              .imagePath,
                                                          width: 150,
                                                          height: 150,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : controller
                                                                  .endImagePathFromData
                                                                  .value
                                                                  .isNotEmpty &&
                                                              controller
                                                                  .isUpdateEndImageAvailable
                                                                  .value
                                                          ? Image.network(
                                                              controller
                                                                  .endImagePathFromData!
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
                                                                    "End Image",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Colors
                                                                            .black),
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
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Obx(
                                      () => Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: AppTheme.liteWhite),
                                        ),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: controller
                                                    .pickImageSelected.value
                                                ? null
                                                : Border.all(
                                                    color: AppTheme.liteWhite,
                                                    width: 3),
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
                                                    onSave: (List<PickedImage>
                                                        images) {
                                                      if (images.isNotEmpty) {
                                                        controller.itemImagePick
                                                            .value = images[0];
                                                        controller
                                                            .pickImageSelected
                                                            .value = true;
                                                      }
                                                      Get.back();
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  controller.itemImagePick
                                                                  .value !=
                                                              null &&
                                                          controller
                                                                  .itemImagePick
                                                                  .value
                                                                  .imagePath !=
                                                              null
                                                      ? Image.file(
                                                          controller
                                                              .itemImagePick!
                                                              .value!
                                                              .imagePath,
                                                          width: 150,
                                                          height: 150,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : controller
                                                                  .imagePathFromData
                                                                  .value
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
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Colors
                                                                            .black),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: AppTheme.liteWhite),
                                        ),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          decoration: BoxDecoration(
                                              color: AppTheme.liteWhite,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                            )
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
                                    controller.userDataProvider
                                            .getCurrentStatus ==
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  // SizedBox(width: 20),
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
                                                  size: 30,
                                                  color: Colors.black));
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
                                            buffered: positionData
                                                    ?.bufferedPosition ??
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
                          controller.subCategoryDropDownTwoOnClick.value =
                              false;
                          controller.subCategoryDropDownOne.value = false;
                          controller.rentTypeDropDown.value = false;
                          controller.vendorOnClick.value = false;
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
                        obscureText: true),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Obx(() =>  Button(
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
                                                controller.updateRent();
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
                                controller.updateRent();
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
                                                controller.insetRent();
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
                                controller.insetRent();
                              }
                            } else {
                              controller.insetRent();
                            }
                          },
                          child:  controller.uploadLoading.isTrue ? CircularProgressIndicator():  Text(
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
                      height: 20,
                    ),
                  ],
                ),
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
          focusNode: controller.durationFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.rateFocusNode,
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

  void _showBottomSheetDateAndTime(
    BuildContext context,
    TextEditingController controller,
    RxString selectedDate,
    RxString dateFormat,
    RentedScreenController pageController,
  ) {
    DateTime focusDay = DateTime.now();
    // var currentDate = today.day;
    DateTime? selectedDay = focusDay;
    selectedDate.value = formatDate(selectedDay!, [hh, ':', nn, ':', ss]);
    dateFormat.value = formatDate(selectedDay, [hh, ':', nn, ':', ss]);

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Wrap(children: [
              Container(
                height: 400,
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: DateRangeExample(
                          controller: controller,
                          selectedDate: selectedDate,
                          dateformat: dateFormat),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      4), // Set the border radius according to your preference
                                ),
                                side: BorderSide(
                                    color: AppTheme
                                        .inputBorderColor), // Set the border color
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppTheme.secondaryColor),
                              ),
                              child: Text("Apply",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              onPressed: () {
                                controller.text = dateFormat.value;
                                Navigator.pop(context);

                                _showbottomTimePicker(
                                  context,
                                  controller,
                                  controller.value.text,
                                  dateFormat,
                                  selectedDate,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]));
      },
    );
  }

  _showbottomTimePicker(BuildContext context, TextEditingController controller,
      String? date, RxString dateformat, RxString selectedDate) {
    var times;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              height: 280,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 115),
                          child: Text(
                            "Select Time",
                            style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Future.delayed(Duration(milliseconds: 200), () {
                              Navigator.of(context).pop();
                            });
                          },
                          child: Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: TimePickerSpinner(
                      is24HourMode: false,
                      spacing: 30,
                      itemHeight: 37,
                      itemWidth: 60,
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        times = time;
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                side: BorderSide(
                                  color: AppTheme.inputBorderColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  AppTheme.secondaryColor,
                                ),
                              ),
                              child: Text(
                                "Done",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                controller.text =
                                    "${date} | ${formatDate(times, [
                                      yyyy,
                                      '-',
                                      mm,
                                      '-',
                                      dd,
                                      ' ',
                                      hh,
                                      ':',
                                      nn,
                                      ':',
                                      ss
                                    ])}";
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

// void datePicker(context) async {
//   RentedScreenController controller = Get.put(RentedScreenController());
//
//   DateTime? selectedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2101),
//   );
//
//   if (selectedDate != null) {
//     controller.selectedDay = selectedDate;
//     // Format the selected date and time
//     String formattedStartDateTime = formatDate(
//       selectedDate,
//       [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss],
//     );
//     String formattedEndDateTime = formatDate(
//       selectedDate,
//       [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss],
//     );
//
//     // Assign the formatted date and time to the controllers
//     controller.startDateAndTimeController.text = formattedStartDateTime;
//     controller.closeDateAndTimeController.text = formattedEndDateTime;
//   }
// }}
}

// Future<void> _selectStartDateTime(BuildContext context) async {
//   RentedScreenController controller = Get.put(RentedScreenController());
//   final DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: controller.selectedDateTime,
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2101),
//   );
//
//   if (pickedDate != null) {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.fromDateTime(controller.selectedDateTime),
//     );
//
//     if (pickedTime != null) {
//       controller.selectedDateTime = DateTime(
//         pickedDate.year,
//         pickedDate.month,
//         pickedDate.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );
//
//       controller.startDateAndTimeController.text =
//           DateFormat('yyyy-MM-dd HH:mm:ss').format(controller.selectedDateTime);
//     }
//   }
// }
// Future<void> _selectEndDateTime(BuildContext context) async {
//   RentedScreenController controller = Get.put(RentedScreenController());
//   final DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: controller.selectedDateTime,
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2101),
//   );
//
//   if (pickedDate != null) {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.fromDateTime(controller.selectedDateTime),
//     );
//
//     if (pickedTime != null) {
//       controller.selectedDateTime = DateTime(
//         pickedDate.year,
//         pickedDate.month,
//         pickedDate.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );
//
//       controller.closeDateAndTimeController.text =
//           DateFormat('yyyy-MM-dd HH:mm:ss').format(controller.selectedDateTime);
//     }
//   }
// }
// Future<void> _selectDateTime(TextEditingController controller, context) async {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//
//   // Show date picker
//   selectedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2101),
//   ) ?? DateTime.now();
//
//   // Show time picker
//   selectedTime = await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay.now(),
//   ) ?? TimeOfDay.now();
//
//   // Combine date and time
//   DateTime selectedDateTime = DateTime(
//     selectedDate.year,
//     selectedDate.month,
//     selectedDate.day,
//     selectedTime.hour,
//     selectedTime.minute,
//   );
//
//   // Set the formatted date and time in the text field
//   controller.text = DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
// }

Future<void> _selectStartDate(BuildContext context) async {
  RentedScreenController controller = Get.put(RentedScreenController());
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
  RentedScreenController controller = Get.put(RentedScreenController());
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
          DateFormat('yyyy-MM-dd HH:mm:ss').format(controller.selectedEndDate!);
    }
  }
}

class SongRepository {
  SongRepository() {
    _loadEmptyPlaylist();
  }

  Future<void> _loadEmptyPlaylist() async {
    try {
      await audioPlayer.setAudioSource(playlist);
    } catch (err) {
      debugPrint("Error: $err");
    }
  }

  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      Uri.parse(mediaItem.extras!['url'] as String),
      tag: mediaItem,
    );
  }

  bool arePlaylistsEqual(
      ConcatenatingAudioSource a, ConcatenatingAudioSource b) {
    if (a.children.length != b.children.length) {
      return false;
    }

    for (int i = 0; i < a.children.length; i++) {
      UriAudioSource sourceA = a.children[i] as UriAudioSource;
      UriAudioSource sourceB = b.children[i] as UriAudioSource;

      if (sourceA.uri != sourceB.uri) {
        return false;
      }
    }

    return true;
  }

  final audioPlayer = AudioPlayer();

  // playlist
  final playlist = ConcatenatingAudioSource(children: []);

  // media items
  var mediaItems = <MediaItem>[];

  // add songs to playlist
  Future<void> addSongsToPlaylist(List<SongModel> songs) async {
    final mediaItems = getMediaItemsFromSongs(songs);
    this.mediaItems = mediaItems;

    var temp = ConcatenatingAudioSource(children: []);

    await temp.addAll(mediaItems.map((mediaItem) {
      final source = _createAudioSource(mediaItem);
      return source;
    }).toList());

    if (!arePlaylistsEqual(playlist, temp)) {
      playlist.clear();
      playlist.addAll(temp.children);
      await audioPlayer.setAudioSource(temp);
    }
  }

  // media item to song model
  SongModel getSongFromMediaItem(MediaItem mediaItem) {
    return SongModel({
      'id': int.parse(mediaItem.id),
      'title': mediaItem.title,
      'artist': mediaItem.artist,
      'album': mediaItem.album,
      'duration': mediaItem.duration?.inMilliseconds,
      'uri': mediaItem.extras!['url'],
    });
  }

  // song model to media item
  MediaItem getMediaItemFromSong(SongModel song) {
    return MediaItem(
      id: song.id.toString(),
      album: song.album,
      title: song.title,
      artist: song.artist,
      duration: Duration(milliseconds: song.duration!),
      // artUri: uri,
      extras: {
        'url': song.uri,
      },
    );
  }

  // song models to media items
  List<MediaItem> getMediaItemsFromSongs(List<SongModel> songs) {
    return songs.map((song) => getMediaItemFromSong(song)).toList();
  }

  // current index
  Stream<int?> get currentIndex => audioPlayer.currentIndexStream;

  // current media item
  Stream<MediaItem?> get mediaItem => mediaItems.isEmpty
      ? Stream.value(null)
      : audioPlayer.currentIndexStream.map((index) => mediaItems[index!]);

  // current position
  Stream<Duration> get position => audioPlayer.positionStream;

  // duration
  Stream<Duration?> get duration => audioPlayer.durationStream;

  // shuffle mode enabled
  Stream<bool> get shuffleModeEnabled => audioPlayer.shuffleModeEnabledStream;

  // loop mode
  Stream<LoopMode> get loopMode => audioPlayer.loopModeStream;

  // playing
  Stream<bool> get playing => audioPlayer.playingStream;

  // play
  Future<void> play() async {
    await audioPlayer.play();
  }

  // play from queue
  Future<void> playFromQueue(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    await audioPlayer.play();
  }

  int getMediaItemIndex(MediaItem mediaItem) {
    return mediaItems.indexWhere((item) => item == mediaItem);
  }

  int getMediaItemId(MediaItem mediaItem) {
    return mediaItems.indexWhere((item) => item.id == mediaItem.id);
  }

  // pause
  Future<void> pause() async {
    await audioPlayer.pause();
  }

  // stop
  Future<void> stop() async {
    await audioPlayer.stop();
  }

  // dispose
  Future<void> dispose() async {
    await audioPlayer.dispose();
  }

  // seek next
  Future<void> seekNext() async {
    await audioPlayer.seekToNext();
  }

  // seek previous
  Future<void> seekPrevious() async {
    // if first song, seek to last song
    if (audioPlayer.currentIndex == 0) {
      await audioPlayer.seek(Duration.zero, index: playlist.length - 1);
    } else {
      await audioPlayer.seekToPrevious();
    }
  }

  // seek
  Future<void> seek(Duration position) async {
    await audioPlayer.seek(position);
  }

  // set volume
  Future<void> setVolume(double volume) async {
    await audioPlayer.setVolume(volume);
  }

  // set speed
  Future<void> setSpeed(double speed) async {
    await audioPlayer.setSpeed(speed);
  }

  // set loop mode
  Future<void> setLoopMode(LoopMode loopMode) async {
    await audioPlayer.setLoopMode(loopMode);
  }

  // set shuffle mode
  Future<void> setShuffleModeEnabled(bool enabled) async {
    await audioPlayer.setShuffleModeEnabled(enabled);
  }
}
