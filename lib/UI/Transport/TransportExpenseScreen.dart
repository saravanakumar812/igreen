import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import '../../../Utils/image_picker.dart';
import '../../../forms/forms.dart';
import '../../../forms/theme.dart';
import '../../Controller/TransportExpenseController.dart';
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

class TransportExpenseScreen extends GetView<TransportExpenseController> {
  const TransportExpenseScreen({super.key});

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
    TransportExpenseController controller =
        Get.put(TransportExpenseController());

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
                              Get.offNamed(AppRoutes.transportSummaryScreen.toName);
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
                      SizedBox(
                        width: 35,
                      ),
                      Text(
                        controller.userDataProvider.getCurrentStatus
                                    .toString() ==
                                'Edit'
                            ? "Update Transport Expense"
                            : "Add Transport Expense",
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
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: controller.subCategory1Controller,
                    height: 100,
                    label: "Sub Category 1*",
                    onPressed: () {
                      controller.fromLocationVisibleDropdown.value = false;
                      controller.toLocationVisibleDropdown.value = false;
                      if (controller.isSub1.value) {
                        controller.isSub1.value = false;
                      } else {
                        controller.isSub1.value = true;
                      }
                    },
                    textInputType: TextInputType.text,
                    textColor: Color(0xCC252525),
                    hintText: "Select Type",
                    obscureText: true,

                    onTextChange: (text) {
                      if(controller.subCategory1Controller.text == ""){
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

                                            controller.isSub1.value = false;
                                            controller.allVisible.value = true;
                                            controller.commonVisible.value =
                                                true;
                                            controller.popUpValue.value = true;
                                            controller.packingUpload.value = false;
                                            if(controller
                                                .subCategory1Controller
                                                .text ==
                                                'Sea-way' || controller
                                                .subCategory1Controller
                                                .text ==
                                                'Air-way'){
                                              controller.packingUpload.value = true;
                                            }
                                            if (controller
                                                    .subCategory1Controller
                                                    .text ==
                                                'Others') {
                                              controller.othersVisible.value =
                                                  true;
                                            } else {
                                              controller.isSub1.value = false;
                                              controller.allVisible.value = true;
                                              controller.commonVisible.value =
                                              true;
                                              controller.popUpValue.value = true;
                                            }
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
                                            )),
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
                      visible: controller.allVisible.value,
                      child: Column(
                        children: [
                          Visibility(
                            visible: controller.othersVisible.value,
                            child: TextInput(
                              height: 100,
                              label: "Others Transport Categories",
                              onPressed: () {
                                controller.vendorOnClick.value =
                                false;
                                controller.fromLocationVisibleDropdown.value =
                                false;
                                controller.isSub1.value = false;
                                controller.toLocationVisibleDropdown.value =
                                false;
                              },
                              controller: controller.othersTransportController,
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "Enter Comments",
                              onTextChange: (String) {
                                controller.popUpValue.value = true;
                              },
                            ),
                          ),
                          Container(child: Row(children: [
                            Container(
                              width: (width / 2) - 10,
                              child: TextInput(
                                height: 100,
                                label: "From location*",
                                onPressed: () {
                                  controller.isSub1.value = false;
                                  if (controller
                                      .fromLocationVisibleDropdown.value) {
                                    controller.fromLocationVisibleDropdown
                                        .value = false;
                                  } else {
                                    controller.fromLocationVisibleDropdown
                                        .value = true;
                                  }
                                  controller.toLocationVisibleDropdown.value =
                                  false; controller.vendorOnClick.value =
                                  false;
                                },
                                controller: controller.fromLocationController,
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                obscureText: true,
                                // isReadOnly: true,
                                hintText: "Enter From location",
                                onTextChange: (loc) {
                                  if(controller.fromLocationController.text == ""){
                                    controller.getCityTransport(loc);
                                  }
                                  if (loc.length >= 3) {
                                    controller.getCityTransport(loc);
                                  } else {
                                    return;
                                  }
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
                                  controller.isSub1.value = false;
                                  if (controller
                                      .toLocationVisibleDropdown.value) {
                                    controller.toLocationVisibleDropdown.value =
                                        false;
                                  } else {
                                    controller.toLocationVisibleDropdown.value =
                                        true;
                                  }
                                  controller.vendorOnClick.value =
                                  false;
                                  controller.fromLocationVisibleDropdown
                                      .value = false;
                                },
                                controller: controller.toLocationController,
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "Enter To location",
                                obscureText: true,
                                //isReadOnly: true,
                                onTextChange: (loc) {
                                  if(controller.toLocationController.text == ""){
                                    controller.getCityTransport(loc);
                                  }
                                  if (loc.length >= 3) {
                                    controller.getCityTransport(loc);
                                  } else {
                                    return;
                                  }
                                },
                              ),
                            ),
                          ])),
                          Visibility(
                            visible:
                                controller.fromLocationVisibleDropdown.value,
                            child: Container(
                              height: height*0.5,
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
                                    MediaQuery.of(context).size.height * 0.5,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                      controller.cityValues.length,
                                      (index) {
                                        var model = controller.cityValues[index];
                                        return Container(
                                          child: Column(
                                            children: [
                                              TextInput(
                                                onPressed: () {
                                                  controller
                                                          .fromLocationController
                                                          .text =
                                                      controller.cityValues[index]
                                                          .cityName!;
                                  
                                                  controller
                                                      .fromLocationVisibleDropdown
                                                      .value = false;
                                                  controller.popUpValue.value =
                                                      true;
                                                },
                                                margin: false,
                                                withImage: false,
                                                isSelected: controller
                                                        .fromLocationController
                                                        .text ==
                                                    controller.cityValues[index]
                                                        .cityName,
                                                label: "",
                                                isEntryField: false,
                                                textInputType: TextInputType.text,
                                                textColor: Color(0xCC234345),
                                                hintText: model.cityName,
                                                obscureText: true,
                                                onTextChange: (String) {},
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Visibility(
                                                  visible: controller
                                                          .cityValues.length !=
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
                            ),
                          ),
                          Obx(() => Visibility(
                                visible:
                                    controller.toLocationVisibleDropdown.value,
                                child: Container(
                                  height: height*0.5,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: List.generate(
                                          controller.cityValues.length,
                                          (index) {
                                            var model =
                                                controller.cityValues[index];
                                            return Container(
                                              child: Column(
                                                children: [
                                                  TextInput(
                                                    onPressed: () {
                                                      controller
                                                              .toLocationController
                                                              .text =
                                                          controller
                                                              .cityValues[index]
                                                              .cityName!;
                                      
                                                      controller
                                                          .toLocationVisibleDropdown
                                                          .value = false;
                                                      controller.popUpValue
                                                          .value = true;
                                                    },
                                                    margin: false,
                                                    withImage: false,
                                                    isSelected: controller
                                                            .toLocationController
                                                            .text ==
                                                        controller
                                                            .cityValues[index]
                                                            .cityName,
                                                    label: "",
                                                    isEntryField: false,
                                                    textInputType:
                                                        TextInputType.text,
                                                    textColor: Color(0xCC234345),
                                                    hintText: model.cityName,
                                                    obscureText: true,
                                                    onTextChange: (String) {},
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Visibility(
                                                      visible: controller
                                                              .cityValues
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
                                ),
                              )),
                          TextInput(
                            height: 100,
                            label: "Comments*",
                            onPressed: () {
                              controller.isSuggestionComments.value = ! controller.isSuggestionComments.value;
                              controller.fromLocationVisibleDropdown.value =
                              false;
                              controller.isSub1.value = false;
                              controller.toLocationVisibleDropdown.value =
                              false; controller.vendorOnClick.value =
                              false;  },
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
                            label: "Trip Cost*",
                            onPressed: () {
                              controller.fromLocationVisibleDropdown.value =
                                  false;
                              controller.isSub1.value = false;
                              controller.toLocationVisibleDropdown.value =
                                  false; controller.vendorOnClick.value =
                              false;
                            },
                            controller: controller.tripCostController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Trip Cost",
                            focusNode: controller.tripCostFocusNode,
                            onTextChange: (String) {
                              controller.popUpValue.value = true;
                            },
                          ),
                          TextInput(
                            height: 100,
                            label: "Goods Name*",
                            onPressed: () {
                              controller.fromLocationVisibleDropdown.value =
                                  false;
                              controller.isSub1.value = false;
                              controller.toLocationVisibleDropdown.value =
                                  false;
                              controller.vendorOnClick.value =
                              false;
                            },
                            controller: controller.goodsNameController,
                            textInputType: TextInputType.text,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Goods Name",
                            //focusNode: controller.tripCostFocusNode,
                            onTextChange: (String) {
                              controller.popUpValue.value = true;
                            },
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width -
                                    60,
                                child: TextInput(
                                  controller:
                                  controller.customerNameController,
                                  height: 100,
                                  label: "Customer Name*",
                                  onPressed: () {
                                    // controller
                                    //     .subCategoryDropDownTwoOnClick
                                    //     .value = false;
                                    // controller.subCategoryDropDownOne
                                    //     .value = false;
                                    // controller.rentTypeDropDown.value =
                                    // false;
                                    // // controller.vendorOnClick.value =
                                    // // false;
                                    // controller.rendList.value = false;
                                    if (controller.vendorOnClick.value) {
                                      controller.vendorOnClick.value =
                                      false;
                                    } else {
                                      controller.vendorOnClick.value =
                                      true;}
                                    // }
                                    controller.refreshData();
                                    if(controller.customerNameController.text == ""){
                                      controller.getVendor('');
                                    }
                                  },
                                  // isReadOnly: true,
                                  obscureText: true,
                                  textInputType: TextInputType.text,
                                  textColor: Color(0xCC252525),
                                  hintText: "Enter CustomerName ",
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
                                  // controller.subCategoryDropDownTwoOnClick
                                  //     .value = false;
                                  // controller.subCategoryDropDownOne
                                  //     .value = false;
                                  // controller.rentTypeDropDown.value =
                                  // false;
                                  // controller.vendorOnClick.value = false;
                                  // controller.rendList.value = false;
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
                                                    label: "CustomerName",
                                                    onPressed: () {},
                                                    controller: controller
                                                        .customerNameAddController,
                                                    textInputType:
                                                    TextInputType.text,
                                                    textColor:
                                                    Color(0xCC252525),
                                                    hintText:
                                                    "Enter CustomerName",
                                                    onTextChange: (string) {
                                                      controller.popUpValue
                                                          .value = true;
                                                    },
                                                  ),
                                                  TextInput(
                                                    height: 100,
                                                    label: "Customer Contact",
                                                    onPressed: () {},
                                                    controller: controller
                                                        .customerContactController,
                                                    textInputType:
                                                    TextInputType.number,
                                                    textColor:
                                                    Color(0xCC252525),
                                                    hintText:
                                                    "Enter Customer Contact",
                                                    onTextChange: (string) {
                                                      controller.popUpValue
                                                          .value = true;
                                                    },
                                                  ),
                                                  TextInput(
                                                    height: 100,
                                                    label: "CustomerAddress",
                                                    onPressed: () {},
                                                    controller: controller
                                                        .customerAddressAddController,
                                                    textInputType:
                                                    TextInputType.text,
                                                    textColor:
                                                    Color(0xCC252525),
                                                    hintText:
                                                    "Enter CustomerAddress",
                                                    onTextChange: (string) {
                                                      controller.popUpValue
                                                          .value = true;
                                                    },
                                                  ),

                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Center(
                                                    child:   Obx(() =>    Button(
                                                        widthFactor: 0.8,
                                                        heightFactor: 0.06,
                                                        onPressed: () {
                                                          controller
                                                              .addCustomer();
                                                         // Get.back();
                                                        },
                                                        child:    controller.uploadLoading.isTrue ? CircularProgressIndicator():     const Text(
                                                            "Add",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600))),
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
                                child: Container(    height: height*0.5,
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
                                    height: height*0.5,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: List.generate(
                                          controller.customerData.length,
                                              (index) {
                                            var model = controller
                                                .customerData[index];
                                            return Container(
                                              child: Column(
                                                children: [
                                                  TextInput(
                                                    onPressed: () {
                                                      controller
                                                          .customerNameController
                                                          .text =
                                                      controller
                                                          .customerData[
                                                      index]
                                                          .customerName!;
                                      
                                                      controller
                                                          .vendorOnClick
                                                          .value = false;
                                                      controller.popUpValue
                                                          .value = true;
                                                    },
                                                    margin: false,
                                                    withImage: false,
                                                    isSelected: controller
                                                        .customerNameController
                                                        .text ==
                                                        controller
                                                            .customerData[
                                                        index]
                                                            .customerName,
                                                    label: "",
                                                    isEntryField: false,
                                                    textInputType:
                                                    TextInputType.text,
                                                    textColor:
                                                    Color(0xCC234345),
                                                    hintText:
                                                    model.customerName,
                                                    obscureText: true,
                                                    onTextChange:
                                                        (String) {},
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Visibility(
                                                      visible: controller
                                                          .customerData
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => Visibility(
                        visible: controller.commonVisible.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
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
                                          title: " Dc Uploads ",
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

                                        controller.dcImagePathFromData.value.isNotEmpty &&
                                            controller.isUpdateImageDcAvailable.value ?
                                        Image.network(
                                          controller.dcImagePathFromData!.value,
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
                                                "Dc Uploads",
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
                            Card(
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
                                  border: controller.eWayImageSelected.value
                                      ? null
                                      : Border.all(
                                          color: AppTheme.liteWhite, width: 3),
                                ),
                                child: Material(
                                  color: AppTheme.liteWhite,
                                  child: InkWell(
                                    onTap: () {
                                      controller.fromLocationVisibleDropdown
                                          .value = false;
                                      controller.isSub1.value = false;
                                      controller.toLocationVisibleDropdown
                                          .value = false;
                                      Get.to(
                                        ImagePick(
                                          isMultiple: true,
                                          title: "Eway Bill ",
                                          onClose: () => Get.back(),
                                          onSave: (List<PickedImage> images) {
                                            if (images.isNotEmpty) {
                                              controller.eWayBillImagePick
                                                  .value = images[0];
                                              controller.eWayImageSelected
                                                  .value = true;
                                            }
                                            Get.back();
                                          },
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        controller.eWayBillImagePick.value !=
                                            null &&
                                            controller.eWayBillImagePick.value
                                                .imagePath !=
                                                null?
                                        Image.file(
                                          controller.eWayBillImagePick!.value!
                                              .imagePath,
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ):

                                        controller.eWayImagePathFromData.value.isNotEmpty &&
                                            controller.isUpdateEWayImageAvailable.value ?
                                        Image.network(
                                          controller.eWayImagePathFromData.value,
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
                                                "E way Uploads",
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
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => Visibility(
                        visible: controller.commonVisible.value,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
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
                                      border: controller.invoiceImageSelected.value
                                          ? null
                                          : Border.all(
                                              color: AppTheme.liteWhite, width: 3),
                                    ),
                                    child: Material(
                                      color: AppTheme.liteWhite,
                                      child: InkWell(
                                        onTap: () {
                                          controller.fromLocationVisibleDropdown
                                              .value = false;
                                          controller.isSub1.value = false;
                                          controller.toLocationVisibleDropdown
                                              .value = false;
                                          Get.to(
                                            ImagePick(
                                              isMultiple: true,
                                              title: "In voice  Bill",
                                              onClose: () => Get.back(),
                                              onSave: (List<PickedImage> images) {
                                                if (images.isNotEmpty) {
                                                  controller.invoiceBillImagePick
                                                      .value = images[0];
                                                  controller.invoiceImageSelected
                                                      .value = true;
                                                }
                                                Get.back();
                                              },
                                            ),
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            controller.invoiceBillImagePick.value !=
                                                null &&
                                                controller.invoiceBillImagePick.value
                                                    .imagePath !=
                                                    null?
                                            Image.file(
                                              controller.invoiceBillImagePick!.value!
                                                  .imagePath,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ):

                                            controller.inVoiceImagePathFromData.value.isNotEmpty &&
                                                controller.isUpdateInVoiceImageAvailable.value ?
                                            Image.network(
                                              controller.inVoiceImagePathFromData!.value,
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
                                                    "InVoice ",
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
                                GestureDetector(
                                  onTapDown: (TapDownDetails details) {
                                    controller.fromLocationVisibleDropdown.value =
                                        false;
                                    controller.isSub1.value = false;
                                    controller.toLocationVisibleDropdown.value =
                                        false;
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
                                    controller.fromLocationVisibleDropdown.value =
                                        false;
                                    controller.isSub1.value = false;
                                    controller.toLocationVisibleDropdown.value =
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
                            Obx(() => Visibility(
                              visible: controller.packingUpload.value,
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: AppTheme.liteWhite),
                                      ),
                                      child: Container(
                                        height:
                                        MediaQuery.of(context).size.height * 0.13,
                                        width: MediaQuery.of(context).size.width * 0.32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: controller.packingListUpload.value
                                              ? null
                                              : Border.all(
                                              color: AppTheme.liteWhite, width: 3),
                                        ),
                                        child: Material(
                                          color: AppTheme.liteWhite,
                                          child: InkWell(
                                            onTap: () {
                                              controller.fromLocationVisibleDropdown
                                                  .value = false;
                                              controller.isSub1.value = false;
                                              controller.toLocationVisibleDropdown
                                                  .value = false;
                                              Get.to(
                                                ImagePick(
                                                  isMultiple: true,
                                                  title: "Packing uploads ",
                                                  onClose: () => Get.back(),
                                                  onSave: (List<PickedImage> images) {
                                                    if (images.isNotEmpty) {
                                                      controller.packingListUploadImagePick
                                                          .value = images[0];
                                                      controller.packingListUpload
                                                          .value = true;
                                                    }
                                                    Get.back();
                                                  },
                                                ),
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                controller.packingListUploadImagePick.value !=
                                                    null &&
                                                    controller.packingListUploadImagePick.value
                                                        .imagePath !=
                                                        null?
                                                Image.file(
                                                  controller.packingListUploadImagePick!.value!
                                                      .imagePath,
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ):

                                                controller.packingImagePathFromData.value.isNotEmpty &&
                                                    controller.isUpdatePackingImageAvailable.value ?
                                                Image.network(
                                                  controller.packingImagePathFromData!.value,
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
                                                        "Packing Uploads",
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
                                  ],))),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.isAudio.value,
                      child: Column(
                        children: [  controller.userDataProvider.getCurrentStatus == "Edit" ||
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
                                //SizedBox(width: 20),
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
                        controller.fromLocationVisibleDropdown.value = false;
                        controller.isSub1.value = false;
                        controller.toLocationVisibleDropdown.value = false;
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
                                                controller.updateTransport();
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
                                controller.updateTransport();
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
                                                controller.insertTransport();
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
                                controller.insertTransport();
                              }
                            } else {
                              controller.insertTransport();
                            }
                          },
                          child:  controller.uploadLoading.isTrue ? CircularProgressIndicator():             Text(
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

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey,
      actions: [
        KeyboardActionsItem(
          focusNode: controller.tripCostFocusNode,
        ),
      ],
    );
  }
}
