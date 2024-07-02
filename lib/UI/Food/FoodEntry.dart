import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import '../../Components/DateRangeExample.dart';
import '../../Controller/FoodEntryController.dart';
import '../../Utils/image_picker.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
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

class FoodEntryScreen extends GetView<FoodEntryController> {
  const FoodEntryScreen({super.key});

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
    String noOfPeopleText = controller.noOfPeopleController.text;
    String amountText = controller.amountController.text;

    double noOfPeople = double.tryParse(noOfPeopleText) ?? 0.0;
    double amount = double.tryParse(amountText) ?? 0.0;

    double result = amount / noOfPeople;

    controller.rateController.text = result.toString();
  }

  @override
  Widget build(BuildContext context) {
    FoodEntryController controller = Get.put(FoodEntryController());

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
                        width: 67,
                      ),
                      Text(
                        controller.userDataProvider.getCurrentStatus
                                    .toString() ==
                                'Edit'
                            ? "Update Food Expense"
                            : "Add Food Expense",
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
              child: Container(
                width: width,
                height: height,
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextInput(
                      controller: controller.subCategory1Controller,
                      height: 100,
                      label: "Food*",
                      onPressed: () {
                        if (controller.isSub1.value) {
                          controller.isSub1.value = false;
                        } else {
                          controller.isSub1.value = true;
                        }
                      },
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Select Food",
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
                                              controller.isSub2Available.value =
                                                  controller.subCategory1[index]
                                                              .isSubCategory ==
                                                          1
                                                      ? true
                                                      : false;

                                              controller.popUpValue.value =
                                                  true;

                                              if (controller
                                                      .subCategory1Controller
                                                      .text ==
                                                  'Others') {
                                                controller.allVisible.value =
                                                    true;
                                                controller.othersVisible.value =
                                                    true;
                                              } else {
                                                controller.othersVisible.value =
                                                    false;
                                                controller.allVisible.value =
                                                    true;
                                              }

                                              controller.isSub1.value = false;

                                              controller.allVisible.value =
                                                  true;
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
                    TextInput(
                      controller: controller.foodForController,
                      height: 100,
                      label: "Food For*",
                      onPressed: () {
                        if (controller.isFoodFor.value) {
                          controller.isFoodFor.value = false;
                        } else {
                          controller.isFoodFor.value = true;
                        }
                      },
                      isReadOnly: true,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Select Food For",
                      obscureText: true,
                      onTextChange: (text) {},
                    ),
                    Obx(() => Visibility(
                          visible: controller.isFoodFor.value,
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
                                  controller.foodForList.length,
                                  (index) {
                                    var model = controller.foodForList[index];
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller
                                                      .foodForController.text =
                                                  controller
                                                      .foodForList[index]!;
                                              controller.isFoodFor.value =
                                                  false;
                                            },
                                            margin: false,
                                            withImage: false,
                                            isSelected: controller
                                                    .foodForController.text ==
                                                controller.foodForList[index],
                                            label: "",
                                            isEntryField: false,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC234345),
                                            hintText: model,
                                            obscureText: true,
                                            onTextChange: (String) {},
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Visibility(
                                              visible: controller
                                                      .foodForList.length !=
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
                        visible: controller.allVisible.value,
                        child: Column(
                          children: [
                            Visibility(
                              visible: controller.othersVisible.value,
                              child: TextInput(
                                height: 100,
                                label: "Other Food Categories*",
                                onPressed: () {
                                  controller.isSub1.value = false;
                                },
                                controller:
                                    controller.otherFoodCategoriesController,
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "Other Food Categories",
                                onTextChange: (String) {
                                  controller.popUpValue.value = true;
                                },
                              ),
                            ),
                            TextInput(
                              height: 100,
                              label: "No Of People*",
                              onPressed: () {
                                controller.isSub1.value = false;
                              },
                              controller: controller.noOfPeopleController,
                              textInputType: TextInputType.number,
                              focusNode: controller.noOfPeopleFocusNode,
                              textColor: Color(0xCC252525),
                              hintText: "No Of People",
                              onTextChange: (String) {
                                updateCombinedValue();
                                controller.popUpValue.value = true;
                              },
                            ),
                            TextInput(
                              height: 100,
                              label: 'Amount*',
                              onPressed: () {
                                controller.isSub1.value = false;
                              },
                              controller: controller.amountController,
                              textInputType: TextInputType.number,
                              textColor: Color(0xCC252525),
                              hintText: "Enter Total Amount",
                              focusNode: controller.amountFocusNode,
                              //isReadOnly: true,
                              onTextChange: (String) {
                                updateCombinedValue();
                                controller.popUpValue.value = true;
                              },
                            ),
                            TextInput(
                              height: 100,
                              label: "Rate*",
                              onPressed: () {
                                controller.isSub1.value = false;
                              },
                              isReadOnly: true,
                              controller: controller.rateController,
                              textInputType: TextInputType.number,
                              focusNode: controller.rateFocusNode,
                              textColor: Color(0xCC252525),
                              hintText: "Enter Rate",
                              onTextChange: (String) {
                                //updateCombinedValue();
                                controller.popUpValue.value = true;
                              },
                            ),
                            TextInput(
                              height: 100,
                              label: "Comments*",
                              onPressed: () {
                                controller.isSuggestionComments.value =
                                    !controller.isSuggestionComments.value;
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
                                  visible:
                                      controller.isSuggestionComments.value,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Obx(
                                  () => Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side:
                                          BorderSide(color: AppTheme.liteWhite),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            controller.pickImageSelected.value
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
                                                onSave:
                                                    (List<PickedImage> images) {
                                                  if (images.isNotEmpty) {
                                                    controller.itemImagePick
                                                        .value = images[0];
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
                                                      controller
                                                              .itemImagePick
                                                              .value
                                                              .imagePath !=
                                                          null
                                                  ? Image.file(
                                                      controller.itemImagePick!
                                                          .value!.imagePath,
                                                      width: 150,
                                                      height: 150,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : controller.imagePathFromData.value.isNotEmpty &&
                                                          controller.isUpdateImageAvailable.value
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
                                      borderRadius: BorderRadius.circular(10),
                                      side:
                                          BorderSide(color: AppTheme.liteWhite),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      width: MediaQuery.of(context).size.width *
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
                          selectDate(context);
                          controller.isSub1.value = false;
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
                    SizedBox(height: 15),
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
                                                controller.updateFood();
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
                                controller.updateFood();
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
                                                controller.insertFood();
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
                                controller.insertFood();
                              }
                            } else {
                              controller.insertFood();
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
          focusNode: controller.noOfPeopleFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.rateFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.amountFocusNode,
        ),
      ],
    );
  }
}

void _showBottomSheetDateAndTime(
  BuildContext context,
  TextEditingController controller,
  RxString selectedDate,
  RxString dateFormat,
  FoodEntryController pageController,
) {
  DateTime focusDay = DateTime.now();
  DateTime? selectedDay = focusDay;
  selectedDate.value = formatDate(selectedDay!, [yyyy, '-', mm, '-', dd]);
  dateFormat.value = formatDate(selectedDay, [dd, '.', M, '.', yyyy]);

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
                              dateformat.value =
                                  "${selectedDate.value} ${formatDate(times, [
                                    HH,
                                    ':',
                                    nn,
                                    ':',
                                    ss
                                  ])}";
                              controller.text = "${date} | ${formatDate(times, [
                                    hh.trim(),
                                    ':',
                                    nn.trim(),
                                    ':',
                                    am.trim()
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
