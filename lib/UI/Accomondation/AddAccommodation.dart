import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import '../../Controller/AddAccommodationController.dart';
import '../../Utils/image_picker.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:just_audio/just_audio.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class AddAccommodation extends GetView<AddAccommodationController> {
  const AddAccommodation({super.key});

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          controller.audioPlayer.positionStream,
          controller.audioPlayer.bufferedPositionStream,
          controller.audioPlayer.durationStream,
          (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration!));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AddAccommodationController controller =
        Get.put(AddAccommodationController());

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
        controller.checkInDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      }
    }

    Future<void> selectDate2(BuildContext context) async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: controller.selectedEndDate ?? DateTime.now(),
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
        controller.checkOutDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      }
    }

    Future<void> selectDate3(BuildContext context) async {
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
        controller.spendDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      }
    }

    void updateCombinedValue() {
      String noOfPeopleText = controller.perDayAmountController.text;
      String rateText = controller.rateController.text;
      int noOfPeople = int.tryParse(noOfPeopleText) ?? 0;
      int rate = int.tryParse(rateText) ?? 0;
      int result = noOfPeople * rate;
      controller.totalAmountController.text = result.toString();
      String extraChargesText = controller.extraAmountChargesController.text;
      int extraCharges = int.tryParse(extraChargesText) ?? 0;
      int result2 = result + extraCharges;
      controller.totalAmountController.text = result2.toString();

    }

    void updateCombinedSubValue() {
      String noOfPeopleText = controller.totalAmountController.text;
      String rateText = controller.currentlyPaidAmountController.text;
      int noOfPeople = int.tryParse(noOfPeopleText) ?? 0;
      int rate = int.tryParse(rateText) ?? 0;
      int result = noOfPeople - rate;
      result = result < 0 ? 0 : result;
      controller.balanceAmountController.text = result.toString();
    }



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
                    width: 10,
                  ),
                  Text(
                    controller.userDataProvider.getCurrentStatus.toString() ==
                            'Edit'
                        ? "Update Accommodation"
                        : "Add Accommodation",
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
                  height: 20,
                ),
                TextInput(
                  controller: controller.subCategory1Controller,
                  height: 100,
                  label: "Sub Category 1*",
                  onPressed: () {
                    if (controller.isSub1.value) {
                      controller.isSub1.value = false;
                    } else {
                      controller.isSub1.value = true;
                    }
                    controller.rendList.value = false;
                    controller.rendChargeList.value = false;
                   // controller.isSub1.value = false;
                  },
                  textInputType: TextInputType.text,
                  textColor: Color(0xCC252525),
                  hintText: "Select Type",
                  obscureText: true,

                  onTextChange: (text) {
                    if(controller.subCategory1Controller.text == ''){
                      controller.subCategory1Call('');
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
                          color:
                              Colors.white, // Set the desired background color
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
                                          controller
                                                  .subCategory1Controller.text =
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

                                          controller.popUpValue.value = true;

                                          controller.amountController.text = "";
                                          controller
                                              .perDayAmountController.text = "";
                                          controller
                                              .extraChargesController.text = "";

                                          controller
                                              .extraAmountChargesController
                                              .text = "";
                                          controller.perTypeController.text =
                                              "";

                                          controller.rendDetails.clear();
                                          controller.chargesDetails.clear();

                                          if (controller.subCategory1Controller
                                                      .text ==
                                                  'Lodge' ||
                                              controller.subCategory1Controller
                                                      .text ==
                                                  'PG') {
                                            controller.rendDetails
                                                .add('Per Hour');
                                            controller.rendDetails.add('Day');
                                          }

                                          if (controller.subCategory1Controller
                                                      .text ==
                                                  'Lodge' ||
                                              controller.subCategory1Controller
                                                      .text ==
                                                  'PG') {
                                            controller.chargesDetails
                                                .add('Others Charges');
                                            controller.chargesDetails
                                                .add('Extra Bed Charges');
                                            controller.chargesDetails
                                                .add('Cleaning Charges');
                                            controller.chargesDetails
                                                .add('Washing Charges');
                                          }

                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Office') {
                                            controller.rendDetails
                                                .add('Per Hour');
                                            controller.rendDetails.add('Day');
                                          }

                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Office') {
                                            controller.chargesDetails
                                                .add('Others Charges');
                                            controller.chargesDetails
                                                .add('Cleaning Charges');
                                            controller.chargesDetails
                                                .add('Water Charges');
                                            controller.chargesDetails
                                                .add('Painting Charges');
                                          }

                                          if (controller.subCategory1Controller
                                                      .text ==
                                                  'House' ||
                                              controller.subCategory1Controller
                                                      .text ==
                                                  'Resort' ||
                                              controller.subCategory1Controller
                                                      .text ==
                                                  'Guest House') {
                                            controller.rendDetails.add('Month');
                                            controller.rendDetails.add('Day');
                                            controller.rendDetails
                                                .add('Advance');
                                          }

                                          if (controller.subCategory1Controller
                                                      .text ==
                                                  'House' ||
                                              controller.subCategory1Controller
                                                      .text ==
                                                  'Guest House') {
                                            controller.chargesDetails
                                                .add('Others Charges');
                                            controller.chargesDetails
                                                .add('House Repair Charges');
                                            controller.chargesDetails
                                                .add('Cleaning Charges');
                                            controller.chargesDetails
                                                .add('Water Charges');
                                          }
                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Resort') {
                                            controller.chargesDetails
                                                .add('Others Charges');
                                            controller.chargesDetails
                                                .add('Resort Repair Charges');
                                            controller.chargesDetails
                                                .add('Cleaning Charges');
                                            controller.chargesDetails
                                                .add('Water Charges');
                                          }

                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Land') {
                                            controller.rendDetails
                                                .add('Per Hour');
                                            controller.rendDetails.add('Day');
                                          }

                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Land') {
                                            controller.chargesDetails
                                                .add('Others Charges');
                                            controller.chargesDetails
                                                .add('Land Repair Charges');
                                            controller.chargesDetails
                                                .add('Cleaning Charges');
                                            controller.chargesDetails
                                                .add('Water Charges');
                                          }

                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Factory') {
                                            controller.rendDetails
                                                .add('Per Hour');
                                            controller.rendDetails.add('Day');
                                          }

                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Factory') {
                                            controller.chargesDetails
                                                .add('Others Charges');
                                            controller.chargesDetails
                                                .add('Factory Repair Charges');
                                            controller.chargesDetails
                                                .add('Cleaning Charges');
                                            controller.chargesDetails
                                                .add('Water Charges');
                                          }
                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Factory Labour') {
                                            controller.chargesDetails
                                                .add('Others Charges');
                                            controller.chargesDetails
                                                .add('Factory Repair Charges');
                                            controller.chargesDetails
                                                .add('Cleaning Charges');
                                            controller.chargesDetails
                                                .add('Water Charges');
                                          }
                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Factory Labour') {
                                            controller.rendDetails
                                                .add('Per Hour');
                                            controller.rendDetails.add('Day');
                                          }
                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Others') {
                                            controller.rendDetails
                                                .add('Per Hour');
                                            controller.rendDetails.add('Day');
                                          }
                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'Others') {
                                            controller.chargesDetails
                                                .add('Others Charges');
                                          } if (controller.subCategory1Controller
                                              .text ==
                                              'Hotel') {
                                            controller.chargesDetails
                                                .add('Others Charges');
                                            controller.chargesDetails
                                                .add('Extra Bed Charges');
                                            controller.chargesDetails
                                                .add('Cleaning Charges');
                                            controller.chargesDetails
                                                .add('Washing Charges');
                                          }

                                          controller.isSub1.value = false;
                                          controller.lodgeHouseDetailsVisible
                                              .value = false;
                                          controller.othersCategoriesVisible
                                              .value = false;
                                          controller.chargesVisible.value =
                                              false;
                                          controller.houseVisible.value = false;

                                          controller.dateVisible.value = false;
                                          controller.billHoldVisible.value =
                                              true;
                                          controller.brokerage.value = false;
                                          controller.roomsVisible.value = false;

                                          if (controller.subCategory1Controller
                                                  .text ==
                                              'House') {
                                            controller.houseVisible.value =
                                                true;
                                            controller.chargesVisible.value =
                                                true;
                                            controller.brokerage.value = true;
                                          } else if (controller
                                                  .subCategory1Controller
                                                  .text ==
                                              'Lodge') {
                                            controller.lodgeHouseDetailsVisible
                                                .value = true;
                                            controller.dateVisible.value = true;
                                            controller.rentTypeVisible.value =
                                                true;
                                            controller.chargesVisible.value =
                                                true;controller.brokerage.value = true;

                                          } else if (controller
                                                  .subCategory1Controller
                                                  .text ==
                                              'Resort') {
                                            controller.dateVisible.value = false;
                                            controller.brokerage.value = false;
                                            controller.houseVisible.value =
                                                true;
                                            controller.chargesVisible.value =
                                                true;
                                            controller.roomsVisible.value = true;
                                           controller.refreshDataResort();
                                          } else if (controller
                                                  .subCategory1Controller
                                                  .text ==
                                              'PG') {
                                            controller.dateVisible.value = true;
                                            controller.lodgeHouseDetailsVisible
                                                .value = true;
                                            controller.rentTypeVisible.value =
                                                true;
                                            controller.chargesVisible.value =
                                                true;controller.brokerage.value = true;
                                          } else if (controller
                                              .subCategory1Controller
                                              .text ==
                                              'Hostel') {
                                            controller.dateVisible.value = true;
                                            controller.lodgeHouseDetailsVisible
                                                .value = true;
                                            controller.rentTypeVisible.value =
                                            true;
                                            controller.chargesVisible.value =
                                            true;controller.brokerage.value = true;
                                          }
                                          else if (controller
                                                  .subCategory1Controller
                                                  .text ==
                                              'Land') {
                                            controller.dateVisible.value = true;
                                            controller.houseVisible.value =
                                                true;
                                            controller.chargesVisible.value =
                                                true; controller.brokerage.value = true;
                                          } else if (controller
                                                  .subCategory1Controller
                                                  .text ==
                                              'Guest House') {
                                            controller.dateVisible.value = true;
                                            controller.houseVisible.value =
                                                true;
                                            controller.chargesVisible.value =
                                                true;controller.brokerage.value = true;
                                          } else if (controller
                                                  .subCategory1Controller
                                                  .text ==
                                              'Office') {
                                            controller.dateVisible.value = true;
                                            controller.houseVisible.value =
                                                true;
                                            controller.chargesVisible.value =
                                                true;controller.brokerage.value = true;
                                          } else if (controller
                                                  .subCategory1Controller
                                                  .text ==
                                              'Factory') {
                                            controller.dateVisible.value = true;
                                            controller.houseVisible.value =
                                                true;
                                            controller.chargesVisible.value =
                                                true;controller.brokerage.value = true;
                                          } else if (controller
                                                  .subCategory1Controller
                                                  .text ==
                                              'Factory Labour') {
                                            controller.dateVisible.value = true;
                                            controller.houseVisible.value =
                                                true;
                                            controller.chargesVisible.value =
                                                true;controller.brokerage.value = true;
                                          } else if (controller
                                                  .subCategory1Controller
                                                  .text ==
                                              'Others') {
                                            controller.dateVisible.value = true;
                                            controller.houseVisible.value =
                                                true;
                                            controller.chargesVisible.value =
                                                true;
                                            controller.othersCategoriesVisible
                                                .value = true;controller.brokerage.value = true;
                                          } else if (controller
                                              .subCategory1Controller
                                              .text ==
                                              'Hotel'){
                                            controller.lodgeHouseDetailsVisible
                                              .value = true;
                                          controller.dateVisible.value = true;
                                          controller.rentTypeVisible.value =
                                          true;
                                          controller.chargesVisible.value =
                                          true;controller.brokerage.value = true;

                                          } else{
                                            controller.dateVisible.value = true;
                                            controller.rentTypeVisible.value =
                                            true;
                                            controller.houseVisible.value =
                                            true;
                                            controller.chargesVisible.value =
                                            true;controller.brokerage.value = true;
                                            controller.lodgeHouseDetailsVisible
                                                .value = true;
                                          }
                                        },
                                        margin: false,
                                        withImage: true,
                                        imagePath: controller
                                            .subCategory1[index]
                                            .sub1CategoryImage,
                                        isSelected: controller
                                                .subCategory1Controller.text ==
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
                                          visible:
                                              controller.subCategory1.length !=
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
                    visible: controller.othersCategoriesVisible.value,
                    child: TextInput(
                      height: 100,
                      label: "Others",
                      onPressed: () {
                        controller.rendList.value = false;
                        controller.rendChargeList.value = false;
                        controller.isSub1.value = false;
                      },
                      // controller: controller.lodgeNameController,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Enter Others Categories",
                      onTextChange: (String) {
                        controller.popUpValue.value = true;
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.dateVisible.value,
                    child: Row(children: [
                      Container(
                        width: (width / 2) - 10,
                        child: TextInput(
                            onPressed: () {
                              controller.rendList.value = false;
                              controller.rendChargeList.value = false;
                              controller.isSub1.value = false;
                              _selectStartDate(context);
                            },
                            controller: controller.checkInDateController,
                            height: 100,
                            isReadOnly: true,
                            label: "CheckInDate*",
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
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: (width / 2) - 10,
                        child: TextInput(
                            onPressed: () {
                              controller.rendList.value = false;
                              controller.rendChargeList.value = false;
                              controller.isSub1.value = false;
                              _selectEndDate(context);
                            },
                            controller: controller.checkOutDateController,
                            height: 100,
                            isReadOnly: true,
                            label: "CheckOutDate*",
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
                      ),
                    ]),
                  ),
                ),
                Obx(() => Visibility(
                    visible: controller.lodgeHouseDetailsVisible.value,
                    child: Column(
                      children: [
                        // TextInput(
                        //   height: 100,
                        //   label: "Name",
                        //   onPressed: () {  controller.rendList.value = false;
                        //   controller.rendChargeList.value = false;
                        //   controller.isSub1.value = false;},
                        //   controller: controller.subCategory1Controller,
                        //   textInputType: TextInputType.text,
                        //   textColor: Color(0xCC252525),
                        //   hintText: "Enter Name",
                        //   onTextChange: (String) {
                        //     controller.popUpValue.value = true;
                        //   },
                        // ),
                        TextInput(
                          height: 100,
                          label: "Name*",
                          onPressed: () {
                            controller.rendList.value = false;
                            controller.rendChargeList.value = false;
                            controller.isSub1.value = false;
                          },
                          controller: controller.lodgeNameController,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter ${controller.subCategory1Controller.text} Name",
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                        TextInput(
                          height: 100,
                          label: "Address*",
                          onPressed: () {  controller.rendList.value = false;
                          controller.rendChargeList.value = false;
                          controller.isSub1.value = false;},
                          controller: controller.addressController,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Address",
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                        TextInput(
                          height: 100,
                          label: "Mobile Number*",
                          onPressed: () {  controller.rendList.value = false;
                          controller.rendChargeList.value = false;
                          controller.isSub1.value = false;},
                          controller: controller.mobileController,
                          textInputType: TextInputType.number,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Mobile Number",
                          focusNode: controller.mobileNumberFocusNode,
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                        TextInput(
                          height: 100,
                          label: "Number of Rooms*",
                          onPressed: () {   controller.rendList.value = false;
                          controller.rendChargeList.value = false;
                          controller.isSub1.value = false;},
                          controller: controller.numberOfRoomsController,
                          textInputType: TextInputType.number,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Number of Rooms",
                          focusNode: controller.numberOfRoomsFocusNode,
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                        TextInput(
                          height: 100,
                          label: "Room Number*",
                          onPressed: () {   controller.rendList.value = false;
                          controller.rendChargeList.value = false;
                          controller.isSub1.value = false;},
                          controller: controller.roomsNumberController,
                          textInputType: TextInputType.number,
                          focusNode: controller.roomNumberFocusNode,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Room Number",
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
                            controller.rendChargeList.value = false;
                            controller.isSub1.value = false;
                             },
                          obscureText: true,
                          controller: controller.commentsController,
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
                                                  .commentsController.text =
                                                  controller
                                                      .suggestionList[index]!
                                                      .suggestion
                                                      .toString();

                                              controller.isSuggestionComments.value = false;
                                            },
                                            margin: false,
                                            withImage: false,
                                            isSelected: controller
                                                .commentsController.text ==
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

                      ],
                    ))),
                Obx(() => Visibility(
                    visible: controller.houseVisible.value,
                    child: Column(
                      children: [
                        TextInput(
                          height: 100,
                          label: "Owner Details*",
                          onPressed: () {
                            controller.rendList.value = false;
                            controller.rendChargeList.value = false;
                            controller.isSub1.value = false;
                          },
                          controller: controller.ownerDetailsController,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: 'Enter Owner Details',
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                        TextInput(
                          height: 100,
                          label: "Pan Card*",
                          isCapital: true,
                          isCapsNumeric: true,
                          MaxLength: 10,
                          onPressed: () {
                            controller.rendList.value = false;
                            controller.rendChargeList.value = false;
                            controller.isSub1.value = false;
                          },
                          controller: controller.panCardDetailsController,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: 'Enter Pan Card Details',
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                        TextInput(
                          height: 100,
                          label: "Maintenance Charges*",
                          onPressed: () {},
                          controller: controller.maintenanceController,
                          focusNode: controller.maintenanceFocusNode,
                          textInputType: TextInputType.number,
                          textColor: Color(0xCC252525),
                          hintText: 'Enter Maintenance Charges',
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                        TextInput(
                          height: 100,
                          label: "LumSum Charges*",
                          onPressed: () {
                            controller.rendList.value = false;
                            controller.rendChargeList.value = false;
                            controller.isSub1.value = false;
                          },
                          controller: controller.lumSumChargesController,
                          textInputType: TextInputType.number,
                          textColor: Color(0xCC252525),
                          hintText: "Enter LumSum Charges",
                          focusNode: controller.lumSumChargesFocusNode,
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                        TextInput(
                          height: 100,
                          label: "Current Bill*",
                          onPressed: () {
                            controller.rendList.value = false;
                            controller.rendChargeList.value = false;
                            controller.isSub1.value = false;
                          },
                          controller: controller.currentBillController,
                          textInputType: TextInputType.number,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Current Bill",
                          focusNode: controller.currentBillFocusNode,
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                        Visibility(
                          visible: controller.brokerage.value,
                          child: TextInput(
                            height: 100,
                            label: "Brokerage*",
                            onPressed: () {
                              controller.rendList.value = false;
                              controller.rendChargeList.value = false;
                              controller.isSub1.value = false;
                            },
                            controller: controller.brokerageController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            focusNode: controller.brokerageFocusNode,
                            hintText: "Enter Brokerage",
                            onTextChange: (String) {
                              controller.popUpValue.value = true;
                            },
                          ),
                        ),
                        Visibility(
                          visible: controller.roomsVisible.value,
                            child: Column(
                          children: [
                            TextInput(
                              height: 100,
                              label: "Number of Rooms*",
                              onPressed: () {
                                controller.rendList.value = false;
                                controller.rendChargeList.value = false;
                                controller.isSub1.value = false;
                              },
                              controller: controller.numberOfRoomsController,
                              textInputType: TextInputType.number,
                              textColor: Color(0xCC252525),
                              hintText: "Enter Number of Rooms",
                              focusNode: controller.numberOfRoomsFocusNode,
                              onTextChange: (String) {
                                controller.popUpValue.value = true;
                              },
                            ),
                            TextInput(
                              height: 100,
                              label: "Room Number*",
                              onPressed: () {
                                controller.rendList.value = false;
                                controller.rendChargeList.value = false;
                                controller.isSub1.value = false;
                              },
                              controller: controller.roomsNumberController,
                              textInputType: TextInputType.number,
                              focusNode: controller.roomNumberFocusNode,
                              textColor: Color(0xCC252525),
                              hintText: "Enter Room Number",
                              onTextChange: (String) {
                                controller.popUpValue.value = true;
                              },
                            ),
                          ],
                        )),
                        TextInput(
                          height: 100,
                          label: "Comments*",
                          onPressed: () {
                            controller.rendList.value = false;
                            controller.rendChargeList.value = false;
                            controller.isSub1.value = false;
                          },
                          controller: controller.commentsController,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Comments",
                          onTextChange: (String) {
                            controller.popUpValue.value = true;
                          },
                        ),
                      ],
                    ))),
                Obx(
                  () => Visibility(
                      visible: controller.chargesVisible.value,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: (width / 2) - 5,
                                child: TextInput(
                                  height: 100,
                                  label: "Charges Type*",
                                  onPressed: () {
                                    if (controller.rendChargeList.value) {
                                      controller.rendChargeList.value = false;
                                    } else {
                                      controller.rendChargeList.value = true;
                                    }
                                    controller.rendList.value = false;
                                   // controller.rendChargeList.value = false;
                                    controller.isSub1.value = false;
                                  },
                                  controller: controller.extraChargesController,
                                  textInputType: TextInputType.number,
                                  textColor: Color(0xCC252525),
                                  obscureText: true,
                                  isReadOnly: true,
                                  hintText: "Select Charges Type",
                                  onTextChange: (string) {},
                                ),
                              ),
                              Container(
                                width: (width / 2) - 5,
                                child: TextInput(
                                  height: 100,
                                  label: "Extra Charges*",
                                  onPressed: () {
                                    controller.rendList.value = false;
                                    controller.rendChargeList.value = false;
                                    controller.isSub1.value = false;
                                  },
                                  controller:
                                      controller.extraAmountChargesController,
                                  textInputType: TextInputType.number,
                                  focusNode: controller.extraChargesFocusNode,
                                  textColor: Color(0xCC252525),
                                  hintText: "Enter Extra Charges",
                                  onTextChange: (String) {
                                    controller.popUpValue.value = true;

                                   // updateCombinedAddValue();
                                    updateCombinedValue();
                                    print('object');
                                  },
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.othersChargesVisible.value,
                              child: TextInput(
                                height: 100,
                                label: "Others Charges Name*",
                                onPressed: () {
                                  controller.rendList.value = false;
                                  controller.rendChargeList.value = false;
                                  controller.isSub1.value = false;
                                },
                                controller: controller.othersChargesController,
                                textInputType: TextInputType.text,
                                focusNode: controller.othersFocusNode,
                                textColor: Color(0xCC252525),
                                hintText: "Enter Others Charges Name",
                                onTextChange: (String) {},
                              ),
                            ),
                          ),
                          Obx(() => Visibility(
                                visible: controller.rendChargeList.value,
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
                                          controller.chargesDetails.length,
                                          (index) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  TextInput(
                                                    onPressed: () {
                                                      controller
                                                          .extraChargesController
                                                          .text = controller
                                                              .chargesDetails[
                                                          index];
                                                      controller.rendChargeList
                                                          .value = false;

                                                      controller
                                                          .othersChargesVisible
                                                          .value = false;
                                                      controller.popUpValue
                                                          .value = true;

                                                      if (controller
                                                              .extraChargesController
                                                              .text ==
                                                          'Others Charges') {
                                                        controller
                                                            .othersChargesVisible
                                                            .value = true;
                                                      }
                                                    },
                                                    margin: false,
                                                    isSelected: controller
                                                            .extraChargesController
                                                            .text ==
                                                        controller
                                                                .chargesDetails[
                                                            index]!,
                                                    label: "",
                                                    isEntryField: false,
                                                    textInputType:
                                                        TextInputType.text,
                                                    textColor:
                                                        Color(0xCC234345),
                                                    hintText: controller
                                                        .chargesDetails[index],
                                                    onTextChange: (String) {},
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Visibility(
                                                    visible: controller
                                                            .chargesDetails
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
                                    //controller.rendList.value = false;
                                    controller.rendChargeList.value = false;
                                    controller.isSub1.value = false;
                                  },
                                  controller: controller.perTypeController,
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
                                  label: "Per Day Amount*",
                                  onPressed: () {
                                    controller.rendList.value = false;
                                    controller.rendChargeList.value = false;
                                    controller.isSub1.value = false;
                                  },
                                  controller: controller.perDayAmountController,
                                  textInputType: TextInputType.number,
                                  textColor: Color(0xCC252525),
                                  hintText: "Enter Per Day Amount",
                                  focusNode: controller.perDayAmountFocusNode,
                                  onTextChange: (String) {
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
                                                      controller
                                                              .perTypeController
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
                                                            .perTypeController
                                                            .text ==
                                                        controller.rendDetails[
                                                            index]!,
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
                            label: "Rate*",
                            onPressed: () {
                              controller.rendList.value = false;
                              controller.rendChargeList.value = false;
                              controller.isSub1.value = false;
                            },
                            controller: controller.rateController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Rate",
                            focusNode: controller.rateFocusNode,
                            onTextChange: (String) {
                              updateCombinedValue();
                              controller.popUpValue.value = true;
                            },
                          ),
                          TextInput(
                            height: 100,
                            label: "Currently Paid Amount(Advance)*",
                            onPressed: () {
                              controller.rendList.value = false;
                              controller.rendChargeList.value = false;
                              controller.isSub1.value = false;
                            },
                            controller:
                                controller.currentlyPaidAmountController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Amount",
                            focusNode: controller.currentlyPaidAmountFocusNode,
                            onTextChange: (String) {
                              updateCombinedSubValue();
                              controller.popUpValue.value = true;
                            },
                          ),
                          TextInput(
                            height: 100,
                            label: "Balance Amount*",
                            onPressed: () {},
                            controller: controller.balanceAmountController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Balance Amount",
                            focusNode: controller.balanceAmountFocusNode,
                            isReadOnly: true,
                            onTextChange: (String) {
                              controller.popUpValue.value = true;
                            },
                          ),
                          TextInput(
                            height: 100,
                            label: "Total Amount*",
                            onPressed: () {},
                            controller: controller.totalAmountController,
                            textInputType: TextInputType.number,
                            focusNode: controller.totalAmountFocusNode,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Amount",
                            isReadOnly: true,
                            onTextChange: (String) {
                              updateCombinedSubValue();
                              updateCombinedValue();
                              controller.popUpValue.value = true;
                            },
                          ),
                        ],
                      )),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.billHoldVisible.value,
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
                                        controller.imagePathFromData!.value,
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                             // SizedBox(width: 20),
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
                      selectDate3(context);
                    },
                    controller: controller.spendDateController,
                    height: 100,
                    isReadOnly: true,
                    label: "CheckOutDate*",
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
                  height: 15,
                ),
                Center(
                  child:   Obx(() =>  Button(
                      widthFactor: 0.9,
                      heightFactor: 0.06,
                      onPressed: () {  if(controller.uploadLoading.isTrue){
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
                                            controller.updateAccommodation();
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
                            controller.updateAccommodation();
                          }
                        }
                        else if (controller.userDataProvider.getCurrentStatus
                            .toString() ==
                            'Re-Use')  {
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
                                            controller.insertAccommodation();
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
                            controller.insertAccommodation();
                          }} else{
                          controller.insertAccommodation();

                        }
                      },
                      child:  controller.uploadLoading.isTrue? CircularProgressIndicator():       Text(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey,
      actions: [
        KeyboardActionsItem(
          focusNode: controller.mobileNumberFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.numberOfRoomsFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.roomNumberFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.lumSumChargesFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.currentBillFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.brokerageFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.extraChargesFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.othersFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.perDayAmountFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.rateFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.currentlyPaidAmountFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.balanceAmountFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.totalAmountFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.maintenanceFocusNode,
        ),
      ],
    );
  }
}

Future<void> _selectStartDate(BuildContext context) async {
  AddAccommodationController controller =
  Get.put(AddAccommodationController());

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate:  DateTime(DateTime.now().year, 1),
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

  );if (picked != null) {
    controller.selectedStartDate = DateTime(
      picked.year,
      picked.month,
      picked.day,

    );
    controller.checkInDateController.text =
        DateFormat('yyyy-MM-dd').format(controller.selectedStartDate!);

}}

Future<void> _selectEndDate(BuildContext context) async {
  final DateTime currentDate = DateTime.now();
  AddAccommodationController controller =
  Get.put(AddAccommodationController());
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: controller.selectedEndDate ?? DateTime.now(),
    firstDate: currentDate,
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
    controller.selectedEndDate = DateTime(
              picked.year,
              picked.month,
              picked.day,

            );
    controller.checkOutDateController.text =
        DateFormat('yyyy-MM-dd').format(controller.selectedEndDate!);

  // if (picked != null) {
  //   final TimeOfDay? selectedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           primaryColor: Colors.pink,
  //           // Change the primary color
  //           hintColor: Colors.pink,
  //           // Change the accent color
  //           colorScheme: ColorScheme.light(primary: Colors.pink),
  //           // Change the color scheme
  //           buttonTheme: ButtonThemeData(
  //               textTheme: ButtonTextTheme.primary), // Change button text color
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //   if (selectedTime != null) {
  //     controller.selectedEndDate = DateTime(
  //       picked.year,
  //       picked.month,
  //       picked.day,
  //       selectedTime.hour,
  //       selectedTime.minute,
  //     );
  //
  //
  //   }
  // }
}}