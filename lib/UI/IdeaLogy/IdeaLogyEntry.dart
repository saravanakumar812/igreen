import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../../Utils/image_picker.dart';
import '../../../forms/forms.dart';
import '../../../forms/theme.dart';
import 'package:intl/intl.dart';
import '../../Controller/IdeaLogyEntryController.dart';
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

class IdeaLogyEntryScreen extends GetView<IdeaLogyEntryController> {
  const IdeaLogyEntryScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    IdeaLogyEntryController controller = Get.put(IdeaLogyEntryController());

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
                              Get.offNamed(AppRoutes.ideaLogySummary.toName);

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
                      Text(
                        controller.userDataProvider.getCurrentStatus
                                    .toString() ==
                                'Edit'
                            ? "Update Ideology Expense"
                            : "Add Ideology Expense",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                        width: width * 0.2,
                        height: height * 0.05,
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
                      controller: controller.ideasController,
                      height: 100,
                      label: "Ideas",
                      onPressed: () {},
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Enter Ideas",
                      //obscureText: true,

                      onTextChange: (general) {
                        controller.popUpValue.value = true;
                      },
                    ),


                    Obx(() => Visibility(
                      visible: true,
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
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                          () => Visibility(
                        visible: controller.isAudio.value,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
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
                                  // Container(
                                  //   child: Row(
                                  //     children: [
                                  //       IconButton(
                                  //         onPressed: () async {
                                  //           play(controller,
                                  //               recordProvider.recordedFilePath);
                                  //         },
                                  //         icon: Icon(playProvider.isSongPlaying
                                  //             ? Icons.pause
                                  //             : Icons.play_arrow_rounded),
                                  //         color: const Color(0xff4BB543),
                                  //         iconSize: 30,
                                  //       ),
                                  //       Container(
                                  //         width: 150,
                                  //         margin: const EdgeInsets.symmetric(
                                  //             horizontal: 10, vertical: 5),
                                  //         child: LinearPercentIndicator(
                                  //           percent: playProvider.currLoadingStatus,
                                  //           backgroundColor: Colors.black26,
                                  //           progressColor: const Color(0xff4BB543),
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),

                                  // IconButton(
                                  //   onPressed: () async {
                                  //     play(context,recordProvider.recordedFilePath);
                                  //    // controller.play(File(recordProvider.recordedFilePath));
                                  //   },
                                  //   icon: Icon(
                                  //      playProvider.isSongPlaying? Icons.pause : Icons.play_arrow_rounded),
                                  //   color: const Color(0xff4BB543),
                                  //   iconSize: 30,
                                  // ),
                                  // SizedBox(width: 20),
                                  // Expanded(
                                  //     child: Container(
                                  //       width: 200,
                                  //       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  //       child: LinearPercentIndicator(
                                  //         percent:playProvider.currLoadingStatus,
                                  //         backgroundColor: Colors.black26,
                                  //         progressColor: const Color(0xff4BB543),
                                  //       ),
                                  //     ))
                                  StreamBuilder<PlayerState>(
                                    stream: controller.audioPlayer.playerStateStream,
                                    builder: (context, snapshot) {
                                      final playerState = snapshot.data;
                                      final processingState = playerState?.processingState;
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
                                          ),
                                        );
                                      } else if (processingState != ProcessingState.completed) {
                                        return IconButton(
                                          onPressed: controller.audioPlayer.pause,
                                          icon: Icon(
                                            Icons.pause_rounded,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        );
                                      }

                                      // If processingState is completed, return an empty container
                                      return Icon(Icons.play_arrow_rounded);// No icon shown
                                    },
                                  ),


                                  SizedBox(width: 30),
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    width: 180,
                                    child: StreamBuilder(
                                      stream: _positionDataStream,
                                      builder: (context, snapshot) {
                                        final positionData = snapshot.data;

                                        return ProgressBar(
                                          progress: positionData?.position ?? Duration.zero,
                                          buffered:
                                          positionData?.bufferedPosition ?? Duration.zero,
                                          total: positionData?.duration ?? Duration.zero,
                                          onSeek: controller.audioPlayer.seek,
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
                                                  controller.updateIdeaLogy();
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
                                  controller.updateIdeaLogy();
                                }
                              } else if (controller
                                      .userDataProvider.getCurrentStatus
                                      .toString() ==
                                  "Re-Use") {
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
                                                  controller.addIdeas();
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
                                  controller.addIdeas();
                                }
                              } else {
                                controller.addIdeas();
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
          focusNode: controller.amountFocusNode,
        ),
      ],
    );
  }


}
