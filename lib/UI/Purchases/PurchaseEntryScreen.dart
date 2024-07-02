import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import '../../../Utils/image_picker.dart';
import '../../../forms/forms.dart';
import '../../../forms/theme.dart';
import '../../Components/DateRangeExample.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart' as rx;
import '../../Controller/FoodEntryController.dart';
import '../../Controller/PurchaseEntryController.dart';
import '../../Controller/RepairPurchaseController.dart';
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
class PurchaseEntryScreen extends GetView<PurchaseEntryController> {
  const PurchaseEntryScreen({super.key});

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
  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          controller.audioPlayer.positionStream,
          controller.audioPlayer.bufferedPositionStream,
          controller.audioPlayer.durationStream,
              (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration!));
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

  void function1() {
    String totalText = controller.amountController.text;
    String currentlyPaidText = controller.currentlyPaidAmountController.text;
    double totalPaid = double.tryParse(totalText) ?? 0;
    double currentlyPaid = double.tryParse(currentlyPaidText) ?? 0;
    double result1 = (totalPaid - currentlyPaid);
    double balanceAmount = result1 < 0 ? 0.0 : result1;
    controller.balanceAmountController.text = balanceAmount.toString();
    // if (totalPaid != 0 && currentlyPaid != 0) {
    //   int result1 = (totalPaid - currentlyPaid).abs();
    //   controller.balanceAmountController.text = result1.toString();
    // }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PurchaseEntryController controller = Get.put(PurchaseEntryController());
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: InkWell(
                            onTap: () {
                              Get.back();
                              Get.offNamed(
                                  AppRoutes.purchaseSummaryScreen.toName);
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

                      const Text(
                        "Add Purchase Expense",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),

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
              child: Container(
                width: width,
                // height: height,
                child: SingleChildScrollView(
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
                          controller.isSub2.value = false;
                          controller.unitOnClick.value = false;
                          controller.unitOnClick.value = false;
                          controller.vendorOnClick.value = false;
                          controller.isSub1.value = false;
                        } else {
                          controller.isSub1.value = true;
                        }
                        controller.isSub2.value = false;
                      },
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Select Type",
                      obscureText: true,
                      onTextChange: (purchase) {
                        if (controller.subCategory1Controller.text == " ") {
                          controller.subCategory1Call(purchase);
                        }
                        if (purchase.length >= 2) {
                          controller.subCategory1Call(purchase);
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
                                              controller.subCategory1Controller
                                                      .text =
                                                  controller.subCategory1[index]
                                                      .sub1CategoryName!;
                                              controller.selectedSub1Index
                                                  .value = index;
                                              controller.fetchSubCategoryTwo(
                                                  controller.subCategory1[index]
                                                      .sub1CategoryId,
                                                  "");
                                              controller.isSub2Available.value =
                                                  controller.subCategory1[index]
                                                              .isSubCategory ==
                                                          1
                                                      ? true
                                                      : false;

                                              if (controller.subCategory1[index]
                                                      .isSubCategory ==
                                                  1) {
                                                controller.entries.value =
                                                    false;


                                              } else {
                                                controller.entries.value = true;
                                                controller.fetchCategoryTwo
                                                    .clear();
                                              }
                                              controller.isSub1.value = false;
                                              controller.popUpValue.value =
                                                  true;
                                              controller.commonVisible.value = true;
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
                                controller.isSub1.value = false;
                                controller.unitOnClick.value = false;
                                controller.vendorOnClick.value = false;
                                if (controller.isSub2.value) {
                                  controller.isSub2.value = false;
                                } else {
                                  controller.isSub2.value = true;
                                }
                                controller.isSub1.value = false;
                                if (controller.userDataProvider.getCurrentStatus == "Edit" ||
                                    controller.userDataProvider.getCurrentStatus == "Re-Use") {
                                  for (int i = 0; i < controller.subCategory1.length; i++) {
                                    if (controller.subCategory1[i].sub1CategoryName ==
                                        controller.userDataProvider.getPurchaseData!.category2) {
                                      controller.fetchSubCategoryTwo(controller.subCategory1[i].sub1CategoryId,"");
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
                                          .subCategory1[controller
                                              .selectedSub1Index.value]
                                          .sub1CategoryId,
                                      String);
                                  controller.popUpValue.value = true;
                                }
                                controller.fetchSubCategoryTwo(
                                    controller
                                        .subCategory1[
                                            controller.selectedSub1Index.value]
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
                                                      controller
                                                          .selectedSub2Index
                                                          .value = index;
                                                      controller.isSub2.value =
                                                          false;
                                                      controller.entries.value =
                                                          true;
                                                      controller.commonVisible.value = true;
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
                                                    textColor:
                                                        Color(0xCC234345),
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
                                                        color:
                                                            AppTheme.appBlack,
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
                    Obx(() =>   Visibility(
                      visible: controller.commonVisible.value,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: TextInput(
                                  controller: controller.materialNameController,
                                  height: 100,
                                  label: "Material Name*",
                                  onPressed: () {
                                    controller.isSub2.value = false;
                                    controller.isSub1.value = false;
                                    controller.unitOnClick.value = false;
                                    controller.unitOnClick.value = false;
                                    if (controller.vendorOnClick.value) {
                                      controller.vendorOnClick.value = false;
                                    } else {
                                      controller.vendorOnClick.value = true;
                                    }
                                    controller.refreshData();
                                    if (controller
                                        .materialNameController.text ==
                                        "") {
                                      controller.getVendor('');
                                    }
                                  },
                                  // isReadOnly: true,
                                  obscureText: true,
                                  textInputType: TextInputType.text,
                                  textColor: Color(0xCC252525),
                                  hintText: "Enter Material Name",
                                  onTextChange: (loc) {
                                    if (loc.length >= 2) {
                                      controller.getVendor(loc);
                                    } else {
                                      return;
                                    }
                                    controller.subcategoryName = loc;
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

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
                                                    label: "MaterialName*",
                                                    onPressed: () {},
                                                    controller: controller
                                                        .materialNameAddController,
                                                    textInputType:
                                                    TextInputType.text,
                                                    textColor: Color(0xCC252525),
                                                    hintText: "Enter MaterialName",
                                                    onTextChange: (string) {
                                                      controller.popUpValue.value =
                                                      true;
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
                                                          controller.addMaterial();

                                                        },
                                                        child: const Text("Add",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.white,
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
                                  margin: EdgeInsets.only(top: 5, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey),
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
                                    width:
                                    MediaQuery.of(context).size.width / 2 -
                                        25,
                                    child: Column(
                                      children: List.generate(
                                        controller.materialName.length,
                                            (index) {
                                          var model =
                                          controller.materialName[index];
                                          return Container(
                                            child: Column(
                                              children: [
                                                TextInput(
                                                  onPressed: () {
                                                    controller
                                                        .materialNameController
                                                        .text =
                                                    controller
                                                        .materialName[index]
                                                        .materialName!;

                                                    controller.materialId.value = index;

                                                    controller.getUnit(
                                                        controller
                                                            .materialName[index]
                                                            .id);
                                                    controller.vendorOnClick
                                                        .value = false;
                                                    controller.popUpValue
                                                        .value = true;
                                                  },
                                                  margin: false,
                                                  withImage: false,
                                                  isSelected: controller
                                                      .materialNameController
                                                      .text ==
                                                      controller
                                                          .materialName[index]
                                                          .materialName,
                                                  label: "",
                                                  isEntryField: false,
                                                  textInputType:
                                                  TextInputType.text,
                                                  textColor: Color(0xCC234345),
                                                  hintText: model.materialName,
                                                  obscureText: true,
                                                  onTextChange: (String) {},
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Visibility(
                                                    visible: controller
                                                        .materialName
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
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: TextInput(
                                  controller: controller.unitController,
                                  height: 100,
                                  label: "unit*",
                                  onPressed: () {
                                    controller.isSub2.value = false;
                                    controller.isSub1.value = false;
                                    controller.vendorOnClick.value = false;

                                    if (controller.unitOnClick.value) {
                                      controller.unitOnClick.value = false;
                                    } else {
                                      controller.unitOnClick.value = true;
                                    }
                                    // controller.refreshData();
                                    // if(controller.vendorNameController.text == ""){
                                    //   controller.getVendor('');
                                    // }
                                  },
                                  // isReadOnly: true,
                                  obscureText: true,
                                  textInputType: TextInputType.text,
                                  textColor: Color(0xCC252525),
                                  hintText: "unit",
                                  onTextChange: (loc) {
                                    if (loc.length >= 2) {
                                      // controller.getVendor(loc);
                                    } else {
                                      return;
                                    }
                                    // controller.vendorName = loc;
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
                                                    label: "unit*",
                                                    onPressed: () {},
                                                    controller: controller
                                                        .unitAddController,
                                                    textInputType:
                                                    TextInputType.text,
                                                    textColor: Color(0xCC252525),
                                                    hintText: "Enter Unit",
                                                    onTextChange: (string) {
                                                      controller.popUpValue.value =
                                                      true;
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
                                                          controller.addUnit(

                                                          );

                                                        },
                                                        child: const Text("Add",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.white,
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
                                  margin: EdgeInsets.only(top: 5, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                                () => Visibility(
                              visible: controller.unitOnClick.value,
                              child: Align(
                                alignment: Alignment.centerLeft,
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
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width / 2 -
                                        25,
                                    child: Column(
                                      children: List.generate(
                                        controller.unit.length,
                                            (index) {
                                          var model = controller.unit[index];
                                          return Container(
                                            child: Column(
                                              children: [
                                                TextInput(
                                                  onPressed: () {
                                                    controller.unitController
                                                        .text =
                                                    controller
                                                        .unit[index].unit!;

                                                    controller.vendorOnClick
                                                        .value = false;
                                                    controller.popUpValue
                                                        .value = true;
                                                    controller.unitOnClick.value = false;
                                                  },
                                                  margin: false,
                                                  withImage: false,
                                                  isSelected: controller
                                                      .unitController
                                                      .text ==
                                                      controller
                                                          .unit[index].unit,

                                                  label: "",
                                                  isEntryField: false,
                                                  textInputType:
                                                  TextInputType.text,
                                                  textColor: Color(0xCC234345),
                                                  hintText: model.unit,
                                                  obscureText: true,
                                                  onTextChange: (String) {},
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Visibility(
                                                    visible: controller
                                                        .unit.length !=
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
                          ),
                          TextInput(
                            height: 100,
                            label: "Total Amount*",
                            onPressed: () {
                              controller.isSub2.value = false;
                              controller.isSub1.value = false;
                              controller.unitOnClick.value = false;
                              controller.unitOnClick.value = false;
                              controller.vendorOnClick.value = false;
                            },
                            controller: controller.amountController,
                            textInputType: TextInputType.number,
                            focusNode: controller.amountFocusNode,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Total Amount",
                            onTextChange: (String) {
                              function1();
                              controller.popUpValue.value = true;
                            },
                          ),
                          TextInput(
                            height: 100,
                            label: "Currently Paid Amount*",
                            onPressed: () {
                              controller.isSub2.value = false;
                              controller.isSub1.value = false;
                              controller.unitOnClick.value = false;
                              controller.unitOnClick.value = false;
                              controller.vendorOnClick.value = false;
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
                              //updateCombinedValue();
                              function1();
                              controller.popUpValue.value = true;
                            },
                          ),
                          TextInput(
                            height: 100,
                            label: "Balance*",
                            onPressed: () {
                              controller.isSub2.value = false;
                              controller.isSub1.value = false;
                              controller.unitOnClick.value = false;
                              controller.unitOnClick.value = false;
                              controller.vendorOnClick.value = false;
                            },
                            controller: controller.balanceAmountController,
                            textInputType: TextInputType.number,
                            textColor: Color(0xCC252525),
                            hintText: "Enter Balance Amount",
                            //focusNode: controller.balanceFocusNode,
                            isReadOnly: true,
                            onTextChange: (string) {
                              //function1();
                              //updateCombinedValue();
                              controller.popUpValue.value = true;
                            },
                          ),

                          TextInput(
                            height: 100,
                            label: "Comments*",
                            onPressed: () {
                              controller.isSuggestionComments.value = ! controller.isSuggestionComments.value;
                              controller.isSub2.value = false;
                              controller.isSub1.value = false;
                              controller.unitOnClick.value = false;
                              controller.unitOnClick.value = false;
                              controller.vendorOnClick.value = false;
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

                        ],
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
                                              "Pick Image",
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
                          controller.isSub2.value = false;
                          controller.isSub1.value = false;
                          controller.unitOnClick.value = false;
                          controller.unitOnClick.value = false;
                          controller.vendorOnClick.value = false;
                          selectDate(context);
                        },
                        controller: controller.currentDateController,
                        height: 100,
                        //isReadOnly: true,
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
                        child: Obx(() =>    Button(
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
                              if (controller
                                  .userDataProvider.getCurrentStatus
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
                                              fontWeight:
                                              FontWeight.w600),
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
                                                      FontWeight
                                                          .w500),
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
                                                      .updatePurchase();
                                                },
                                                child: Text(
                                                  "Yes",
                                                  style: GoogleFonts.lato(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
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
                                  controller.updatePurchase();
                                }
                              } else if (controller
                                  .userDataProvider.getCurrentStatus
                                  .toString() ==
                                  'Re-Use') {
                                if (controller.popUpValue.value ==
                                    false) {
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
                                              fontWeight:
                                              FontWeight.w600),
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
                                                      FontWeight
                                                          .w500),
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
                                                      .insertPurchaseApi();
                                                },
                                                child: Text(
                                                  "Yes",
                                                  style: GoogleFonts.lato(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
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
                                  controller.insertPurchaseApi();
                                }
                              } else {
                                controller.insertPurchaseApi();
                              }
                            },
                            child:  controller.uploadLoading.isTrue ? CircularProgressIndicator():         Text(
                                controller.userDataProvider
                                    .getCurrentStatus
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
              ),
            )));
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey,
      actions: [
        KeyboardActionsItem(
          focusNode: controller.amountFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.unitFocusNode,
        ), KeyboardActionsItem(
          focusNode: controller.currentlyPaidAmountFocusNode,
        ),
      ],
    );
  }
}
