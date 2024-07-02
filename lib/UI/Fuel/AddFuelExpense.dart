import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:provider/provider.dart';
import '../../Components/DateRangeExample.dart';
import '../../Controller/AddFuelExpenseController.dart';
import '../../Utils/AppPreference.dart';
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

class AddFuelExpense extends GetView<AddFuelExpenseController> {
  const AddFuelExpense({super.key});

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
    String noOfPeopleText = controller.quantityController.text;
    String rateText = controller.rateController.text;
    double noOfPeople = double.tryParse(noOfPeopleText) ?? 0.0;
    double rate = double.tryParse(rateText) ?? 0.0;
    double result = noOfPeople * rate;
    controller.expenseAmountController.text = result.toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AddFuelExpenseController controller = Get.put(AddFuelExpenseController());

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
                            Get.offNamed(AppRoutes.fuelSummary.toName);
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
                      controller.userDataProvider.getCurrentStatus.toString() ==
                              'Edit'
                          ? " Update ${controller.userDataProvider.subCategoryName}  Expense"
                          : "Add  ${controller.userDataProvider.subCategoryName}  Expense",
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
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextInput(
                      height: 100,
                      label: "Type*",
                      onPressed: () {
                        if (controller.subCategoryDropDownOne.value) {
                          controller.subCategoryDropDownOne.value = false;
                        } else {
                          controller.subCategoryDropDownOne.value = true;
                        }
                        // controller.subCategoryDropDownTwo.value = false;
                        controller.vendorOnClick.value = false;
                        controller.subCategoryDropDownTwoOnClick.value = false;
                        controller.vehihilesDetailsClick.value = false;
                        controller.ownerOnClick.value = false;
                        // controller.refreshDataKm();
                        controller.typeControllerTwo.text == "";
                      },
                      controller: controller.typeControllerOne,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Select Type ",
                      obscureText: true,
                      onTextChange: (text) {
                        if (controller.typeControllerOne.text == "Machines") {
                          controller.fetchSubCategoryTwo(text);
                        }
                        if (text.length >= 2) {
                          controller.fetchSubCategoryTwo(text);
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
                                  controller.fetchCategoryTwo.length,
                                  (index) {
                                    var model =
                                        controller.fetchCategoryTwo[index];
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller
                                                      .typeControllerOne.text =
                                                  controller
                                                      .fetchCategoryTwo[index]!
                                                      .sub2CategoryName
                                                      .toString();
                                              controller.subCategoryDropDownOne
                                                  .value = false;
                                              controller.subCategoryDropDownTwo
                                                  .value = true;

                                              controller.popUpValue.value =
                                                  true;

                                              controller
                                                  .fetchSubCategoryTwo('');
                                              controller.selectedSub2Index
                                                  .value = index;
                                              controller.fetchSubCategoryThree(
                                                  controller
                                                      .fetchCategoryTwo[index]
                                                      .sub2CategoryId,
                                                  "");

                                              if (controller
                                                      .typeControllerOne.text ==
                                                  'Machines') {
                                                controller.machineDetailVisible
                                                    .value = true;
                                                controller.refreshDataKm();
                                              } else if (controller
                                                          .typeControllerOne
                                                          .text ==
                                                      'Machines' &&
                                                  controller.userDataProvider
                                                          .getFuelTypes ==
                                                      "Petrol") {
                                                controller.machineDetailVisible
                                                    .value = true;
                                                controller.refreshDataKm();
                                              } else if (controller
                                                      .typeControllerOne.text ==
                                                  'Vehicles') {
                                                controller.machineDetailVisible
                                                    .value = true;

                                                controller.refreshDataHr();
                                              } else {
                                                controller.machineDetailVisible
                                                    .value = true;
                                                controller.refreshDataKm();
                                                controller.refreshDataHr();
                                              }
                                              controller.hoursVisibleDiesel
                                                  .value = false;
                                              controller.vehicleVisibleRadio
                                                  .value = false;
                                              controller.rentOwnedOnClick
                                                  .value = false;

                                              controller
                                                  .buttonAndImageHoldVisible
                                                  .value = false;
                                              controller.kmVisible.value =
                                                  false;
                                              controller.machineDetailVisible
                                                  .value = false;
                                              controller.isSub1.value = false;
                                              controller.allVisible.value =
                                                  true;
                                            },
                                            margin: false,
                                            withImage: true,
                                            imagePath: controller
                                                .fetchCategoryTwo[index]
                                                .sub2CategoryImage,
                                            isSelected: controller
                                                    .typeControllerOne.text ==
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
                                  i < controller.fetchCategoryTwo.length;
                                  i++) {
                                if (controller
                                        .fetchCategoryTwo[i].sub2CategoryName ==
                                    controller.userDataProvider
                                        .getFuelExpenseData!.category3) {
                                  controller.fetchSubCategoryThree(
                                      controller
                                          .fetchCategoryTwo[i].sub2CategoryId,
                                      "");
                                }
                              }
                            }
                            controller.subCategoryDropDownOne.value = false;
                            controller.vendorOnClick.value = false;
                            controller.vehihilesDetailsClick.value = false;
                            controller.ownerOnClick.value = false;
                          },
                          controller: controller.typeControllerTwo,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Select Type ",
                          obscureText: true,
                          //isReadOnly: true,
                          onTextChange: (text) {
                            if (controller.typeControllerTwo.text == "") {
                              controller.fetchSubCategoryThree(
                                  controller
                                      .fetchCategoryTwo[
                                          controller.selectedSub2Index.value]
                                      .sub2CategoryId,
                                  text);
                            }
                            controller.fetchSubCategoryThree(
                                controller
                                    .fetchCategoryTwo[
                                        controller.selectedSub2Index.value]
                                    .sub2CategoryId,
                                text);
                          },
                        ),
                      ),
                    ),
                    Obx(() => Align(
                          alignment: Alignment.center,
                          child: Visibility(
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
                                    controller.fetchCategoryThree.length,
                                    (index) {
                                      var model =
                                          controller.fetchCategoryThree[index];
                                      return Container(
                                        child: Column(
                                          children: [
                                            TextInput(
                                              onPressed: () {
                                                controller.typeControllerTwo
                                                        .text =
                                                    controller
                                                        .fetchCategoryThree[
                                                            index]!
                                                        .sub3CategoryName
                                                        .toString();
                                                controller
                                                    .subCategoryDropDownTwoOnClick
                                                    .value = false;
                                                controller
                                                    .subCategoryDropDownThree
                                                    .value = false;
                                                controller.vehicleVisibleRadio
                                                    .value = false;
                                                controller.machineDetailVisible
                                                    .value = false;
                                                controller.kmVisible.value =
                                                    false;
                                                controller.hoursVisible.value =
                                                    false;
                                                controller.hoursVisibleDiesel
                                                    .value = false;
                                                controller.popUpValue.value =
                                                    true;
                                                controller.generatorVisible
                                                    .value = false;
                                                controller
                                                    .subCategoryDropDownThree
                                                    .value = false;
                                                controller.machineDetailVisible
                                                    .value = false;
                                                controller
                                                    .buttonAndImageHoldVisible
                                                    .value = false;
                                                controller
                                                    .onRadioValueChangedRented(
                                                        false);
                                                controller
                                                    .onRadioValueChangedOwned(
                                                        false);
                                                if (controller.typeControllerTwo.text == 'Others' &&
                                                    controller.userDataProvider.getFuelTypes ==
                                                        "CNG") {
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      false;
                                                  controller.othersVisible
                                                      .value = true;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                } else if (controller.typeControllerTwo.text == 'Others' &&
                                                    controller.userDataProvider.getFuelTypes ==
                                                        "Petrol") {
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      false;
                                                  controller.othersVisible
                                                      .value = true;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                } else if (controller.typeControllerTwo.text == 'Mud Pump' &&
                                                    controller.userDataProvider.getFuelTypes ==
                                                        "Petrol") {
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.othersVisible
                                                      .value = false;
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;

                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller.kmVisible.value =
                                                      false;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                  controller.refreshDataKm();
                                                } else if (controller.typeControllerTwo.text ==
                                                        'Suction Machine' &&
                                                    controller.userDataProvider.getFuelTypes ==
                                                        "Petrol") {
                                                  controller.othersVisible
                                                      .value = false;
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;

                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller.kmVisible.value =
                                                      false;
                                                  controller.hoursVisible
                                                      .value = true;
                                                  controller.refreshDataKm();
                                                } else if (controller.typeControllerTwo.text == 'RIG' &&
                                                    controller.userDataProvider.getFuelTypes ==
                                                        "Diesel") {
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                  controller.kmVisible.value =
                                                      false;
                                                } else if (controller.typeControllerOne.text == 'Machines' &&
                                                    controller.typeControllerTwo.text ==
                                                        'Generator set' &&
                                                    controller.userDataProvider.getFuelTypes ==
                                                        "Diesel") {
                                                  controller.generatorVisible
                                                      .value = true;
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = true;
                                                  controller.kmVisible.value =
                                                      false;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                } else if (controller.typeControllerTwo.text == 'Mud Pump' &&
                                                    controller.userDataProvider.getFuelTypes ==
                                                        "Diesel") {
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = true;
                                                  controller.kmVisible.value =
                                                      false;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                } else if (controller.typeControllerTwo.text ==
                                                    'Earth Movers') {
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = true;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                } else if (controller.typeControllerTwo.text ==
                                                    'Hydra') {
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = true;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                } else if (controller.typeControllerTwo.text ==
                                                    'Jack Hammer') {
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = true;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                } else if (controller.typeControllerTwo.text ==
                                                    'Suction Machine') {
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                } else if (controller
                                                        .typeControllerTwo
                                                        .text ==
                                                    'Three Wheeler') {
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.othersVisible
                                                      .value = false;
                                                  controller.refreshDataHr();
                                                } else if (controller.typeControllerTwo.text == 'Car') {
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.refreshDataHr();
                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == 'Van') {
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.refreshDataHr();
                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == '2 wheeler') {
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.refreshDataHr();
                                                } else if (controller.typeControllerTwo.text == 'Machine Lorry' || controller.typeControllerTwo.text == 'Water Lorry' || controller.typeControllerTwo.text == 'ToolLorry' || controller.typeControllerTwo.text == 'Mini Trucks') {
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == 'Machine Lorry' && controller.userDataProvider.getFuelTypes == "Diesel") {
                                                  controller.kmVisible.value =
                                                      true;

                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == 'Water Lorry' && controller.userDataProvider.getFuelTypes == "Diesel") {
                                                  controller.kmVisible.value =
                                                      true;

                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == 'Tool Lorry' && controller.userDataProvider.getFuelTypes == "Diesel") {
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      true;
                                                } else if (controller.typeControllerTwo.text == 'Mini Trucks' && controller.userDataProvider.getFuelTypes == "Diesel") {
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == 'Car' && controller.userDataProvider.getFuelTypes == "Diesel") {
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == 'Van' && controller.userDataProvider.getFuelTypes == "Diesel") {
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == 'Others' && controller.userDataProvider.getFuelTypes == "Diesel") {
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      false;
                                                  controller.othersVisible
                                                      .value = true;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                } else if (controller.typeControllerTwo.text == 'Car' && controller.userDataProvider.getFuelTypes == "Electricity") {
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == 'Van' && controller.userDataProvider.getFuelTypes == "Electricity") {
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == 'Two Wheeler' && controller.userDataProvider.getFuelTypes == "Electricity") {
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.othersVisible
                                                      .value = false;
                                                } else if (controller.typeControllerTwo.text == 'Others' && controller.userDataProvider.getFuelTypes == "Electricity") {
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      false;
                                                  controller.othersVisible
                                                      .value = true;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                } else if (controller.typeControllerTwo.text == 'Others' && controller.userDataProvider.getFuelTypes == "Others") {
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = false;
                                                  controller.hoursVisibleDiesel
                                                      .value = false;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.othersVisible
                                                      .value = true;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                } else {
                                                  controller
                                                      .subCategoryDropDownThree
                                                      .value = false;
                                                  controller
                                                      .machineDetailVisible
                                                      .value = true;
                                                  controller.generatorVisible
                                                      .value = true;
                                                  controller.hoursVisibleDiesel
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisible
                                                      .value = true;
                                                  controller
                                                      .buttonAndImageHoldVisibleOther
                                                      .value = false;
                                                  controller.kmVisible.value =
                                                      true;
                                                  controller.othersVisible
                                                      .value = true;
                                                }
                                                controller.fetchSubCategoryFour(
                                                    controller
                                                        .fetchCategoryThree[
                                                            index]
                                                        .sub3CategoryId);
                                                controller.isSub1.value = false;
                                                controller.allVisible.value =
                                                    true;
                                              },
                                              margin: false,
                                              withImage: true,
                                              imagePath: controller
                                                  .fetchCategoryThree[index]
                                                  .sub3CategoryImage,
                                              isSelected: controller
                                                      .typeControllerTwo.text ==
                                                  controller
                                                      .fetchCategoryThree[
                                                          index]!
                                                      .sub3CategoryName
                                                      .toString(),
                                              label: '',
                                              isEntryField: false,
                                              textInputType: TextInputType.text,
                                              textColor: Color(0xCC234345),
                                              hintText: model.sub3CategoryName,
                                              onTextChange: (String) {},
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Visibility(
                                              visible: controller
                                                      .fetchCategoryThree
                                                      .length !=
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
                        )),
                    Obx(
                      () => Visibility(
                        visible: controller.subCategoryDropDownThree.value,
                        child: TextInput(
                          height: 100,
                          label: "Select Type",
                          onPressed: () {
                            if (controller
                                .subCategoryDropDownThreeOnClick.value) {
                              controller.subCategoryDropDownThreeOnClick.value =
                                  false;
                            } else {
                              controller.subCategoryDropDownThreeOnClick.value =
                                  true;
                            }
                            controller.subCategoryDropDownOne.value = false;
                            controller.vendorOnClick.value = false;
                            controller.subCategoryDropDownTwoOnClick.value =
                                false;
                            controller.vehihilesDetailsClick.value = false;
                            controller.ownerOnClick.value = false;
                          },
                          isReadOnly: true,
                          controller: controller.typeControllerThree,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Select Type ",
                          obscureText: true,
                          onTextChange: (String) {
                            controller.fetchSubCategoryFour(controller
                                .fetchCategoryThree[
                                    controller.selectedSub1Index.value]
                                .sub3CategoryId);
                          },
                        ),
                      ),
                    ),
                    Obx(() => Visibility(
                          visible:
                              controller.subCategoryDropDownThreeOnClick.value,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                            padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.inputBorderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                children: List.generate(
                                  controller.fetchCategoryFour.length,
                                  (index) {
                                    var model =
                                        controller.fetchCategoryFour[index];
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller.typeControllerThree
                                                      .text =
                                                  controller
                                                      .fetchCategoryFour[index]!
                                                      .sub4CategoryName
                                                      .toString();
                                              controller
                                                  .subCategoryDropDownThreeOnClick
                                                  .value = false;

                                              controller
                                                  .buttonAndImageHoldVisibleOther
                                                  .value = false;
                                              controller.kmVisible.value =
                                                  false;
                                              controller.machineDetailVisible
                                                  .value = true;
                                              controller.popUpValue.value =
                                                  true;
                                              if (controller
                                                      .selectItemOne.value ==
                                                  'Machines') {
                                                controller
                                                    .buttonAndImageHoldVisibleOther
                                                    .value = true;
                                                // controller.kmVisible.value =
                                                //     true;
                                                controller.hoursVisible.value =
                                                    true;
                                              }
                                              controller.hoursVisible.value =
                                                  false;
                                              controller.isSub1.value = false;
                                              controller.allVisible.value =
                                                  true;
                                            },
                                            margin: false,
                                            withImage: true,
                                            imagePath: controller
                                                .fetchCategoryThree[index]
                                                .sub3CategoryImage,
                                            isSelected: controller
                                                    .typeControllerThree.text ==
                                                controller
                                                    .fetchCategoryThree[index]!
                                                    .sub3CategoryName
                                                    .toString(),
                                            label: '',
                                            isEntryField: false,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC234345),
                                            hintText: model.sub4CategoryName,
                                            onTextChange: (String) {},
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Visibility(
                                            visible: controller
                                                    .fetchCategoryThree
                                                    .length !=
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
                    SizedBox(
                      height: 10,
                    ),

                    Obx(
                      () => Visibility(
                          visible: controller.machineDetailVisible.value,
                          child: Column(children: [
                            Column(
                              children: [
                                Visibility(
                                  visible: controller.othersVisible.value,
                                  child: TextInput(
                                    height: 100,
                                    label: "Other  Categories*",
                                    onPressed: () {
                                      controller.subCategoryDropDownOne.value =
                                          false;
                                      controller.vendorOnClick.value = false;
                                      controller.subCategoryDropDownTwoOnClick
                                          .value = false;
                                      controller.vehihilesDetailsClick.value =
                                          false;
                                      controller.ownerOnClick.value = false;
                                      controller.subCategoryDropDownThreeOnClick
                                          .value = false;
                                    },
                                    controller:
                                        controller.othersVehicleController,
                                    textInputType: TextInputType.text,
                                    textColor: Color(0xCC252525),
                                    hintText: "Enter Others Categories",
                                    onTextChange: (string) {
                                      controller.popUpValue.value = true;
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: controller.otherButtonClick.value,
                                  child: TextInput(
                                    height: 100,
                                    label: "Other Phase",
                                    onPressed: () {
                                      controller.subCategoryDropDownOne.value =
                                          false;
                                      controller.vendorOnClick.value = false;
                                      controller.subCategoryDropDownTwoOnClick
                                          .value = false;
                                      controller.vehihilesDetailsClick.value =
                                          false;
                                      controller.ownerOnClick.value = false;
                                      controller.subCategoryDropDownThreeOnClick
                                          .value = false;
                                    },
                                    controller: controller.otherPhaseController,
                                    textInputType: TextInputType.number,
                                    textColor: Color(0xCC252525),
                                    hintText: "Enter Other Phase",
                                    onTextChange: (string) {
                                      controller.popUpValue.value = true;
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: controller.hoursVisibleDiesel.value,
                                  child: Row(children: [
                                    Container(
                                      width: (width / 2),
                                      child: TextInput(
                                          onPressed: () {
                                            controller.subCategoryDropDownOne
                                                .value = false;
                                            controller.vendorOnClick.value =
                                                false;
                                            controller
                                                .subCategoryDropDownTwoOnClick
                                                .value = false;
                                            controller.vehihilesDetailsClick
                                                .value = false;
                                            controller.ownerOnClick.value =
                                                false;
                                            controller
                                                .subCategoryDropDownThreeOnClick
                                                .value = false;
                                            _selectStartDate(context);
                                          },
                                          controller: controller
                                              .startDateAndTimeController,
                                          height: 100,
                                          isReadOnly: true,
                                          label: "Starting hr*",
                                          onTextChange: (text) {
                                            controller.popUpValue.value = true;
                                          },
                                          textInputType: TextInputType.phone,
                                          textColor: Color(0xCC252525),
                                          hintText: "Enter Starting hr",
                                          sufficIcon: Icon(
                                            Icons.calendar_month,
                                          ),
                                          obscureText: true),
                                    ),
                                    SizedBox(
                                      width: 0,
                                    ),
                                    Container(
                                      width: (width / 2),
                                      child: TextInput(
                                          onPressed: () {
                                            controller.subCategoryDropDownOne
                                                .value = false;
                                            controller.vendorOnClick.value =
                                                false;
                                            controller
                                                .subCategoryDropDownTwoOnClick
                                                .value = false;
                                            controller.vehihilesDetailsClick
                                                .value = false;
                                            controller.ownerOnClick.value =
                                                false;
                                            controller
                                                .subCategoryDropDownThreeOnClick
                                                .value = false;
                                            _selectEndDate(context);
                                          },
                                          controller: controller
                                              .closeDateAndTimeController,
                                          height: 100,
                                          isReadOnly: true,
                                          label: "Closing hr*",
                                          onTextChange: (text) {
                                            controller.popUpValue.value = true;
                                          },
                                          textInputType: TextInputType.phone,
                                          textColor: Color(0xCC252525),
                                          hintText: "Enter Closing hr",
                                          sufficIcon: Icon(
                                            Icons.calendar_month,
                                          ),
                                          obscureText: true),
                                    ),
                                  ]),
                                ),
                                Visibility(
                                  visible: controller.kmVisible.value,
                                  child: Row(children: [
                                    Container(
                                      width: (width / 2),
                                      child: TextInput(
                                        height: 100,
                                        label: "Starting Km*",
                                        onPressed: () {
                                          controller.subCategoryDropDownOne
                                              .value = false;
                                          controller.vendorOnClick.value =
                                              false;
                                          controller
                                              .subCategoryDropDownTwoOnClick
                                              .value = false;
                                          controller.vehihilesDetailsClick
                                              .value = false;
                                          controller.ownerOnClick.value = false;
                                          controller
                                              .subCategoryDropDownThreeOnClick
                                              .value = false;
                                        },
                                        controller:
                                            controller.staringKmController,
                                        textInputType: TextInputType.number,
                                        focusNode:
                                            controller.startingKmFocusNode,
                                        textColor: Color(0xCC252525),
                                        hintText: "Enter Starting Km",
                                        onTextChange: (String) {
                                          controller.popUpValue.value = true;
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: (width / 2),
                                      child: TextInput(
                                        height: 100,
                                        label: "Closing Km*",
                                        onPressed: () {
                                          controller.subCategoryDropDownOne
                                              .value = false;
                                          controller.vendorOnClick.value =
                                              false;
                                          controller
                                              .subCategoryDropDownTwoOnClick
                                              .value = false;
                                          controller.vehihilesDetailsClick
                                              .value = false;
                                          controller.ownerOnClick.value = false;
                                          controller
                                              .subCategoryDropDownThreeOnClick
                                              .value = false;
                                        },
                                        controller:
                                            controller.closingKmController,
                                        textInputType: TextInputType.number,
                                        textColor: Color(0xCC252525),
                                        focusNode:
                                            controller.closingKmFocusNode,
                                        hintText: "Enter To Closing KM",
                                        onTextChange: (string) {
                                          controller.popUpValue.value = true;
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                                Visibility(
                                  visible: controller
                                      .buttonAndImageHoldVisibleOther.value,
                                  child: Row(
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
                                                    // controller
                                                    //     .onRadioValueChangedRented(
                                                    //         value);
                                                    controller
                                                            .selectedRadioRented
                                                            .value =
                                                        !controller
                                                            .selectedRadioRented
                                                            .value;
                                                    controller.ownedOnClick
                                                        .value = false;
                                                    // controller.rentOwnedOnClick
                                                    //         .value =
                                                    //     !controller
                                                    //         .rentOwnedOnClick
                                                    //         .value;
                                                    controller
                                                        .selectedRadioOwned
                                                        .value = false;
                                                    controller.popUpValue
                                                        .value = true;
                                                    // controller.subCategoryDropDownTwo.value = false;
                                                    controller
                                                        .subCategoryDropDownOne
                                                        .value = false;
                                                    controller.vendorOnClick
                                                        .value = false;
                                                    controller
                                                        .vehihilesDetailsClick
                                                        .value = false;
                                                    controller.ownerOnClick
                                                        .value = false;
                                                  }
                                                },
                                                activeColor:
                                                    AppTheme.radioButtonColor,
                                              ),
                                              // Add spacing between the radio button and text
                                              Text(
                                                // '1',
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

                                                    controller.ownedOnClick
                                                            .value =
                                                        !controller
                                                            .ownedOnClick.value;
                                                    controller.rentOwnedOnClick
                                                        .value = false;
                                                    controller
                                                        .selectedRadioRented
                                                        .value = false;

                                                    controller.popUpValue
                                                        .value = true;
                                                    //controller.subCategoryDropDownTwo.value = false;
                                                    controller
                                                        .subCategoryDropDownOne
                                                        .value = false;
                                                    controller.vendorOnClick
                                                        .value = false;
                                                    controller
                                                        .vehihilesDetailsClick
                                                        .value = false;
                                                    controller.ownerOnClick
                                                        .value = false;
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
                                ),
                                Obx(() => Visibility(
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
                                                  label: controller
                                                              .typeControllerOne
                                                              .text ==
                                                          'Machines'
                                                      ? "Serial Number"
                                                      : "Registration Number",
                                                  onPressed: () {
                                                    if (controller
                                                        .ownerOnClick.value) {
                                                      controller.ownerOnClick
                                                          .value = false;
                                                    } else {
                                                      controller.ownerOnClick
                                                          .value = true;
                                                    }
                                                    controller
                                                        .ownerRefreshData();
                                                    controller
                                                        .subCategoryDropDownOne
                                                        .value = false;
                                                    controller.vendorOnClick
                                                        .value = false;
                                                    controller
                                                        .subCategoryDropDownTwoOnClick
                                                        .value = false;
                                                    controller
                                                        .vehihilesDetailsClick
                                                        .value = false;
                                                    //controller.ownerOnClick.value = false;
                                                    controller
                                                        .subCategoryDropDownThreeOnClick
                                                        .value = false;
                                                  },
                                                  //isReadOnly: true,
                                                  obscureText: true,
                                                  textInputType:
                                                      TextInputType.text,
                                                  textColor: Color(0xCC252525),
                                                  hintText: controller
                                                              .typeControllerOne
                                                              .text ==
                                                          'Machines'
                                                      ? " Enter Serial Number"
                                                      : "Enter Registration Number",

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
                                                                onPressed:
                                                                    () {},
                                                                controller:
                                                                    controller
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
                                                                onPressed:
                                                                    () {},
                                                                controller:
                                                                    controller
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
                                                                onPressed:
                                                                    () {},
                                                                controller:
                                                                    controller
                                                                        .registrationNumberController,
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
                                                                onPressed:
                                                                    () {},
                                                                controller:
                                                                    controller
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
                                                                child:  Obx(() =>  Button(
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
                                                                    },
                                                                    child:  controller.uploadLoading.value ? CircularProgressIndicator():    const Text(
                                                                        "Add",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w600))

                                                                ),
                                                                ),
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
                                                        BorderRadius.circular(
                                                            5),
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
                                                  height: height * 0.2,
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
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            25,
                                                    height: height * 0.2,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: List.generate(
                                                          controller
                                                              .ownerData.length,
                                                          (index) {
                                                            var model = controller
                                                                    .ownerData[
                                                                index];
                                                            return Container(
                                                              child: Column(
                                                                children: [
                                                                  TextInput(
                                                                    onPressed:
                                                                        () {
                                                                      controller
                                                                              .registrationNumberController
                                                                              .text =
                                                                          controller
                                                                              .ownerData[index]
                                                                              .registerationNumber!;

                                                                      controller
                                                                          .ownerOnClick
                                                                          .value = false;
                                                                      controller
                                                                          .popUpValue
                                                                          .value = true;
                                                                    },
                                                                    margin:
                                                                        false,
                                                                    withImage:
                                                                        false,
                                                                    isSelected: controller
                                                                            .registrationNumberController
                                                                            .text ==
                                                                        controller
                                                                            .ownerData[index]
                                                                            .registerationNumber,
                                                                    label: "",
                                                                    isEntryField:
                                                                        false,
                                                                    textInputType:
                                                                        TextInputType
                                                                            .text,
                                                                    textColor:
                                                                        Color(
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
                                                                          index +
                                                                              1,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            1,
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
                                        ],
                                      ),
                                    )),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        controller.vehihilesDetailsClick.value,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
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
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              25,
                                          child: Column(
                                            children: List.generate(
                                              controller.ownerData.length,
                                              (index) {
                                                var model =
                                                    controller.ownerData[index];
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      TextInput(
                                                        onPressed: () {
                                                          controller
                                                                  .vehicleDetailsController
                                                                  .text =
                                                              controller
                                                                  .ownerData[
                                                                      index]
                                                                  .vechicalDetails!;

                                                          controller
                                                              .vehihilesDetailsClick
                                                              .value = false;
                                                          controller.popUpValue
                                                              .value = true;
                                                        },
                                                        margin: false,
                                                        withImage: false,
                                                        isSelected: controller
                                                                .vehicleDetailsController
                                                                .text ==
                                                            controller
                                                                .ownerData[
                                                                    index]
                                                                .vechicalDetails,
                                                        label: "",
                                                        isEntryField: false,
                                                        textInputType:
                                                            TextInputType.text,
                                                        textColor:
                                                            Color(0xCC234345),
                                                        hintText: model
                                                            .vechicalDetails,
                                                        obscureText: true,
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
                                Obx(
                                  () => Visibility(
                                      visible:
                                          controller.vehicleVisibleRadio.value,
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: (width / 2) - 1,
                                                  child: TextInput(
                                                    height: 100,
                                                    label: "Quantity*",
                                                    onPressed: () {
                                                      controller
                                                          .subCategoryDropDownTwoOnClick
                                                          .value = false;
                                                      controller
                                                          .subCategoryDropDownOne
                                                          .value = false;
                                                      controller.vendorOnClick
                                                          .value = false;
                                                      controller
                                                          .vehihilesDetailsClick
                                                          .value = false;
                                                      controller.ownerOnClick
                                                          .value = false;
                                                    },
                                                    controller: controller
                                                        .quantityController,
                                                    textInputType:
                                                        TextInputType.number,
                                                    textColor:
                                                        Color(0xCC252525),
                                                    focusNode: controller
                                                        .quantityFocusNode,
                                                    hintText: "Enter Quantity",
                                                    onTextChange: (String) {
                                                      updateCombinedValue();
                                                      controller.popUpValue
                                                          .value = true;
                                                    },
                                                  ),
                                                ),
                                                // SizedBox(width: 20,),
                                                Container(
                                                  width: (width / 2),
                                                  child: TextInput(
                                                    height: 100,
                                                    label: "Rate",
                                                    onPressed: () {
                                                      controller
                                                          .subCategoryDropDownTwoOnClick
                                                          .value = false;
                                                      controller
                                                          .subCategoryDropDownOne
                                                          .value = false;
                                                      controller.vendorOnClick
                                                          .value = false;
                                                      controller
                                                          .vehihilesDetailsClick
                                                          .value = false;
                                                      controller.ownerOnClick
                                                          .value = false;
                                                    },
                                                    controller: controller
                                                        .rateController,
                                                    textInputType:
                                                        TextInputType.number,
                                                    textColor:
                                                        Color(0xCC252525),
                                                    focusNode: controller
                                                        .rateFocusNode,
                                                    hintText: "Enter Rate",
                                                    onTextChange: (string) {
                                                      updateCombinedValue();
                                                      controller.popUpValue
                                                          .value = true;
                                                    },
                                                  ),
                                                ),
                                              ]),
                                          TextInput(
                                            height: 100,
                                            label: "Amount",
                                            onPressed: () {},
                                            controller: controller
                                                .expenseAmountController,
                                            textInputType: TextInputType.number,
                                            textColor: Color(0xCC252525),
                                            hintText: " Enter Your Amount ",
                                            focusNode:
                                                controller.amountFocusNode,
                                            isReadOnly: true,
                                            onTextChange: (String) {
                                              controller.popUpValue.value =
                                                  true;
                                            },
                                          ),
                                          TextInput(
                                            height: 100,
                                            label: "Comments*",
                                            onPressed: () {
                                              // controller.subCategoryDropDownTwo.value =
                                              //     false;
                                              controller.subCategoryDropDownOne
                                                  .value = false;
                                              controller.vendorOnClick.value =
                                                  false;
                                              controller.vehihilesDetailsClick
                                                  .value = false;
                                              controller.ownerOnClick.value =
                                                  false;
                                            },
                                            controller:
                                                controller.commentController,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC252525),
                                            hintText: " Enter Your Comments ",
                                            onTextChange: (String) {
                                              controller.popUpValue.value =
                                                  true;
                                            },
                                          ),
                                        ],
                                      )),
                                ),
                                Visibility(
                                    visible: controller.generatorVisible.value,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.30,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  children: [
                                                    Radio<bool>(
                                                      value: true,
                                                      groupValue: controller
                                                          .selectedSinglePhase
                                                          .value,
                                                      onChanged: (bool? value) {
                                                        if (value != null) {
                                                          controller
                                                              .singlePhaseOnClick(
                                                                  value);

                                                          controller
                                                                  .singlePhaseButtonClick
                                                                  .value =
                                                              !controller
                                                                  .singlePhaseButtonClick
                                                                  .value;

                                                          controller
                                                              .selectedThreePhase
                                                              .value = false;
                                                          controller
                                                              .selectedOtherPhase
                                                              .value = false;

                                                          controller
                                                              .otherButtonClick
                                                              .value = false;
                                                          controller.popUpValue
                                                              .value = true;
                                                        }
                                                      },
                                                      activeColor: AppTheme
                                                          .radioButtonColor,
                                                    ),
                                                    Text(
                                                      controller
                                                          .singlePhase.value,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                children: [
                                                  Radio<bool>(
                                                    value: true,
                                                    groupValue: controller
                                                        .selectedThreePhase
                                                        .value,
                                                    onChanged: (bool? value) {
                                                      if (value != null) {
                                                        controller
                                                            .threePhaseOnClick(
                                                                value);

                                                        controller
                                                                .threePhaseButtonClick
                                                                .value =
                                                            !controller
                                                                .threePhaseButtonClick
                                                                .value;

                                                        controller
                                                            .selectedSinglePhase
                                                            .value = false;

                                                        controller
                                                            .selectedSinglePhase
                                                            .value = false;
                                                        controller
                                                            .selectedOtherPhase
                                                            .value = false;

                                                        controller
                                                            .otherButtonClick
                                                            .value = false;
                                                        controller.popUpValue
                                                            .value = true;
                                                      }
                                                    },
                                                    activeColor: AppTheme
                                                        .radioButtonColor,
                                                  ),
                                                  Text(
                                                    controller.threePhase.value,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                children: [
                                                  Radio<bool>(
                                                    value: true,
                                                    groupValue: controller
                                                        .selectedOtherPhase
                                                        .value,
                                                    onChanged: (bool? value) {
                                                      if (value != null) {
                                                        controller
                                                            .otherClick(value);

                                                        controller
                                                                .otherButtonClick
                                                                .value =
                                                            !controller
                                                                .otherButtonClick
                                                                .value;

                                                        controller
                                                            .selectedSinglePhase
                                                            .value = false;
                                                        controller
                                                            .selectedThreePhase
                                                            .value = false;
                                                        controller.popUpValue
                                                            .value = true;
                                                      }
                                                    },
                                                    activeColor: AppTheme
                                                        .radioButtonColor,
                                                  ),
                                                  Text(
                                                    controller.other.value,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                controller.selectedRadioRented.value == true ||
                                        controller.selectedRadioOwned.value ==
                                            true
                                    ? Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: AppTheme.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                    child: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .deleteRadioButton();

                                                    // controller
                                                    //     .onRadioValueChangedRented(
                                                    //     false);
                                                    // controller.onRadioValueChangedOwned(false);
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
                                      )
                                    : Container(),
                                Obx(
                                  () => Visibility(
                                    visible: controller
                                        .buttonAndImageHoldVisible.value,
                                    child: Row(
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
                                                    width: 1,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              children: [
                                                Radio<bool>(
                                                  value: true,
                                                  groupValue: controller
                                                      .selectedRadioRented
                                                      .value,
                                                  onChanged: (bool? value) {
                                                    if (value != null) {
                                                      controller
                                                          .onRadioValueChangedRented(
                                                              value);
                                                      controller.ownedOnClick1
                                                          .value = false;
                                                      controller
                                                          .selectedRadioOwned
                                                          .value = false;

                                                      controller
                                                              .rentOwnedOnClick
                                                              .value =
                                                          !controller
                                                              .rentOwnedOnClick
                                                              .value;
                                                      controller.popUpValue
                                                          .value = true;

                                                      controller
                                                          .subCategoryDropDownOne
                                                          .value = false;
                                                      controller.vendorOnClick
                                                          .value = false;
                                                      controller
                                                          .subCategoryDropDownTwoOnClick
                                                          .value = false;
                                                      controller
                                                          .vehihilesDetailsClick
                                                          .value = false;
                                                      controller.ownerOnClick
                                                          .value = false;
                                                      controller
                                                          .subCategoryDropDownThreeOnClick
                                                          .value = false;
                                                    }
                                                  },
                                                  activeColor:
                                                      AppTheme.radioButtonColor,
                                                ),
                                                // Add spacing between the radio button and text
                                                Text(
                                                  controller
                                                      .machineRented.value,
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
                                                    width: 1,
                                                    color: Colors.grey),
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

                                                      controller.ownedOnClick1
                                                              .value =
                                                          !controller
                                                              .ownedOnClick1
                                                              .value;
                                                      controller
                                                          .rentOwnedOnClick
                                                          .value = false;
                                                      controller
                                                          .selectedRadioRented
                                                          .value = false;

                                                      controller.popUpValue
                                                          .value = true;

                                                      controller
                                                          .subCategoryDropDownOne
                                                          .value = false;
                                                      controller.vendorOnClick
                                                          .value = false;
                                                      controller
                                                          .vehihilesDetailsClick
                                                          .value = false;
                                                      controller.ownerOnClick
                                                          .value = false;
                                                      controller
                                                          .vehicleVisibleRadio1
                                                          .value = false;
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
                                  ),
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
                                                      .vehihilesDetailsClick
                                                      .value = false;
                                                  controller.ownerOnClick
                                                      .value = false;
                                                  if (controller
                                                      .vendorOnClick.value) {
                                                    controller.vendorOnClick
                                                        .value = false;
                                                  } else {
                                                    controller.vendorOnClick
                                                        .value = true;
                                                  }
                                                  controller
                                                      .subCategoryDropDownOne
                                                      .value = false;
                                                  controller
                                                      .subCategoryDropDownTwoOnClick
                                                      .value = false;
                                                  controller
                                                      .vehihilesDetailsClick
                                                      .value = false;
                                                  controller.ownerOnClick
                                                      .value = false;
                                                  controller
                                                      .subCategoryDropDownThreeOnClick
                                                      .value = false;
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
                                      ],
                                    )),
                                Obx(
                                  () => Visibility(
                                    visible: controller.vendorOnClick.value,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(12, 4, 12, 0),
                                        height: height * 0.2,
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
                                                          withImage: false,
                                                          isSelected: controller
                                                                  .vendorNameController
                                                                  .text ==
                                                              model.vendorName,
                                                          label: "",
                                                          isEntryField: false,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          textColor:
                                                              Color(0xCC234345),
                                                          hintText: model
                                                                  .vendorName ??
                                                              '',
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
                                Obx(() => Visibility(
                                      visible: controller.ownedOnClick1.value,
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
                                                  label: controller
                                                              .typeControllerOne
                                                              .text ==
                                                          'Machines'
                                                      ? "Serial Number"
                                                      : "Registration Number",
                                                  onPressed: () {
                                                    if (controller
                                                        .ownerOnClick.value) {
                                                      controller.ownerOnClick
                                                          .value = false;
                                                    } else {
                                                      controller.ownerOnClick
                                                          .value = true;
                                                    }
                                                    controller
                                                        .ownerRefreshData();
                                                    //controller.vehihilesDetailsClick.value = false;
                                                  },
                                                  //isReadOnly: true,
                                                  obscureText: true,
                                                  textInputType:
                                                      TextInputType.text,
                                                  textColor: Color(0xCC252525),
                                                  hintText: controller
                                                              .typeControllerOne
                                                              .text ==
                                                          'Machines'
                                                      ? " Enter Serial Number"
                                                      : " Enter Registration Number",
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
                                                    controller
                                                        .subCategoryDropDownTwoOnClick
                                                        .value = false;
                                                    controller
                                                        .subCategoryDropDownOne
                                                        .value = false;
                                                    controller.vendorOnClick
                                                        .value = false;
                                                    controller
                                                        .vehihilesDetailsClick
                                                        .value = false;
                                                    controller.ownerOnClick
                                                        .value = false;
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
                                                                onPressed:
                                                                    () {},
                                                                controller:
                                                                    controller
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
                                                                onPressed:
                                                                    () {},
                                                                controller:
                                                                    controller
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
                                                                onPressed:
                                                                    () {},
                                                                controller:
                                                                    controller
                                                                        .registrationNumberController,
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
                                                                onPressed:
                                                                    () {},
                                                                controller:
                                                                    controller
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
                                                                      //Get.back();
                                                                    },
                                                                    child: const Text(
                                                                        "Add",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w600))),
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
                                                        BorderRadius.circular(
                                                            5),
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
                                                  height: height * 0.2,
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
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            25,
                                                    height: height * 0.2,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: List.generate(
                                                          controller
                                                              .ownerData.length,
                                                          (index) {
                                                            var model = controller
                                                                    .ownerData[
                                                                index];
                                                            return Container(
                                                              child: Column(
                                                                children: [
                                                                  TextInput(
                                                                    onPressed:
                                                                        () {
                                                                      controller
                                                                              .registrationNumberController
                                                                              .text =
                                                                          controller
                                                                              .ownerData[index]
                                                                              .registerationNumber!;

                                                                      controller
                                                                          .ownerOnClick
                                                                          .value = false;
                                                                      controller
                                                                          .popUpValue
                                                                          .value = true;
                                                                    },
                                                                    margin:
                                                                        false,
                                                                    withImage:
                                                                        false,
                                                                    isSelected: controller
                                                                            .registrationNumberController
                                                                            .text ==
                                                                        controller
                                                                            .ownerData[index]
                                                                            .registerationNumber,
                                                                    label: "",
                                                                    isEntryField:
                                                                        false,
                                                                    textInputType:
                                                                        TextInputType
                                                                            .text,
                                                                    textColor:
                                                                        Color(
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
                                                                          index +
                                                                              1,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            1,
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
                                        ],
                                      ),
                                    )),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        controller.vehihilesDetailsClick.value,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
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
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              25,
                                          child: Column(
                                            children: List.generate(
                                              controller.ownerData.length,
                                              (index) {
                                                var model =
                                                    controller.ownerData[index];
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      TextInput(
                                                        onPressed: () {
                                                          controller
                                                                  .vehicleDetailsController
                                                                  .text =
                                                              controller
                                                                  .ownerData[
                                                                      index]
                                                                  .vechicalDetails!;

                                                          controller
                                                              .vehihilesDetailsClick
                                                              .value = false;
                                                          controller.popUpValue
                                                              .value = true;
                                                        },
                                                        margin: false,
                                                        withImage: false,
                                                        isSelected: controller
                                                                .vehicleDetailsController
                                                                .text ==
                                                            controller
                                                                .ownerData[
                                                                    index]
                                                                .vechicalDetails,
                                                        label: "",
                                                        isEntryField: false,
                                                        textInputType:
                                                            TextInputType.text,
                                                        textColor:
                                                            Color(0xCC234345),
                                                        hintText: model
                                                            .vechicalDetails,
                                                        obscureText: true,
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
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: (width / 2) - 1,
                                        child: TextInput(
                                          height: 100,
                                          label: "Quantity*",
                                          onPressed: () {
                                            controller.subCategoryDropDownOne
                                                .value = false;
                                            controller.vendorOnClick.value =
                                                false;
                                            controller
                                                .subCategoryDropDownTwoOnClick
                                                .value = false;
                                            controller.vehihilesDetailsClick
                                                .value = false;
                                            controller.ownerOnClick.value =
                                                false;
                                            controller
                                                .subCategoryDropDownThreeOnClick
                                                .value = false;
                                          },
                                          controller:
                                              controller.quantityController,
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          focusNode:
                                              controller.quantityFocusNode,
                                          hintText: "Enter Quantity",
                                          onTextChange: (String) {
                                            updateCombinedValue();
                                            controller.popUpValue.value = true;
                                          },
                                        ),
                                      ),
                                      // SizedBox(width: 20,),
                                      Container(
                                        width: (width / 2),
                                        child: TextInput(
                                          height: 100,
                                          label: "Rate*",
                                          onPressed: () {
                                            controller.subCategoryDropDownOne
                                                .value = false;
                                            controller.vendorOnClick.value =
                                                false;
                                            controller
                                                .subCategoryDropDownTwoOnClick
                                                .value = false;
                                            controller.vehihilesDetailsClick
                                                .value = false;
                                            controller.ownerOnClick.value =
                                                false;
                                            controller
                                                .subCategoryDropDownThreeOnClick
                                                .value = false;
                                          },
                                          controller: controller.rateController,
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          focusNode: controller.rateFocusNode,
                                          hintText: "Enter Rate",
                                          onTextChange: (string) {
                                            updateCombinedValue();
                                            controller.popUpValue.value = true;
                                          },
                                        ),
                                      ),
                                    ]),
                                Container(
                                  width: width,
                                  child: TextInput(
                                    height: 100,
                                    label: "Amount*",
                                    onPressed: () {
                                      controller.subCategoryDropDownOne.value =
                                          false;
                                      controller.vendorOnClick.value = false;
                                      controller.subCategoryDropDownTwoOnClick
                                          .value = false;
                                      controller.vehihilesDetailsClick.value =
                                          false;
                                      controller.ownerOnClick.value = false;
                                      controller.subCategoryDropDownThreeOnClick
                                          .value = false;
                                    },
                                    controller:
                                        controller.expenseAmountController,
                                    textInputType: TextInputType.number,
                                    textColor: Color(0xCC252525),
                                    focusNode: controller.amountFocusNode,
                                    isReadOnly: true,
                                    hintText: "Enter Amount",
                                    onTextChange: (string) {
                                      controller.popUpValue.value = true;
                                    },
                                  ),
                                ),
                                TextInput(
                                  height: 100,
                                  label: "Comments*",
                                  onPressed: () {
                                    controller.isSuggestionComments.value =
                                        !controller.isSuggestionComments.value;
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
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ])),
                    ),

                    //Common Pick Image and Hold Visibility
                    Visibility(
                      visible: true,
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

                    SizedBox(
                      height: 20,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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

                    Visibility(
                      visible: controller.buttonAndImageHoldVisible.value,
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
                                  border: controller.startImageSelected.value
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
                                          title: "Start Image ",
                                          onClose: () => Get.back(),
                                          onSave: (List<PickedImage> images) {
                                            if (images.isNotEmpty) {
                                              controller.itemImageStart.value =
                                                  images[0];
                                              controller.startImageSelected
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
                                        controller.itemImageStart.value !=
                                                    null &&
                                                controller.itemImageStart.value
                                                        .imagePath !=
                                                    null
                                            ? Image.file(
                                                controller.itemImageStart!
                                                    .value!.imagePath,
                                                width: 150,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              )
                                            : controller.startImagePathFromData
                                                        .value.isNotEmpty &&
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
                                  border: controller.endImageSelected.value
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
                                          title: "End Image ",
                                          onClose: () => Get.back(),
                                          onSave: (List<PickedImage> images) {
                                            if (images.isNotEmpty) {
                                              controller.itemImageEnd.value =
                                                  images[0];
                                              controller.endImageSelected
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
                                        controller.itemImageEnd.value != null &&
                                                controller.itemImageEnd.value
                                                        .imagePath !=
                                                    null
                                            ? Image.file(
                                                controller.itemImageEnd!.value!
                                                    .imagePath,
                                                width: 150,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              )
                                            : controller.endImagePathFromData
                                                        .value.isNotEmpty &&
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
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    TextInput(
                        onPressed: () {
                          selectDate(context);
                          controller.subCategoryDropDownOne.value = false;
                          controller.vendorOnClick.value = false;
                          controller.subCategoryDropDownTwoOnClick.value =
                              false;
                          controller.vehihilesDetailsClick.value = false;
                          controller.ownerOnClick.value = false;
                          controller.subCategoryDropDownThreeOnClick.value =
                              false;
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
                      child:  Obx(() =>   Button(
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
                                                controller.updateFuel();
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
                                controller.updateFuel();
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
                                                controller.insertFuel();
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
                                controller.insertFuel();
                              }
                            } else {
                              controller.insertFuel();
                            }
                          },
                          child:   controller.uploadLoading.isTrue ? CircularProgressIndicator() :      Text(
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
            ),
          )),
    );
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey,
      actions: [
        KeyboardActionsItem(
          focusNode: controller.quantityFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.rateFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.startingKmFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.closingKmFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.amountFocusNode,
        ),
      ],
    );
  }

  void _showBottomSheetDateAndTime(
    BuildContext context,
    TextEditingController controller,
    RxString selectedDate,
    RxString dateFormat,
    AddFuelExpenseController pageController,
  ) {
    DateTime focusDay = DateTime.now();
    DateTime? selectedDay = focusDay;
    selectedDate.value = formatDate(
        selectedDay!, [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss]);
    dateFormat.value = formatDate(
        selectedDay, [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss]);
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
                                    selectedDate);
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
}

void _showBottomSheetDateAndTimeDiesel(
  BuildContext context,
  TextEditingController controller,
  RxString selectedDate,
  RxString dateFormat,
  AddFuelExpenseController pageController,
) {
  DateTime focusDay = DateTime.now();
  DateTime? selectedDay = focusDay;
  selectedDate.value = formatDate(
      selectedDay!, [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss]);
  dateFormat.value = formatDate(
      selectedDay, [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss]);
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
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                                  selectedDate);
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                              controller.text = "${date} | ${formatDate(times, [
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

Future<void> _selectStartDate(BuildContext context) async {
  AddFuelExpenseController controller = Get.put(AddFuelExpenseController());
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
  AddFuelExpenseController controller = Get.put(AddFuelExpenseController());
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
