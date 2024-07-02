import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/Controller/LeaveApplyScreenController.dart';
import 'package:igreen_flutter/forms/forms.dart';
import '../../../../forms/theme.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:just_audio/just_audio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api_config/ApiUrl.dart';

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

class LeaveApplyScreen extends GetView<LeaveApplyScreenController> {
  const LeaveApplyScreen({super.key});

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
    LeaveApplyScreenController controller =
        Get.put(LeaveApplyScreenController());

    return SafeArea(
        child: Scaffold(
            backgroundColor: AppTheme.screenBackground,
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
                        width: 70,
                      ),
                      Text(
                        'Leave List',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeaveApplyScreen()),
                          );
                        },
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.contain,
                          width: width * 0.2,
                          height: height * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 80),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [
                        Container(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          top: 40,
                                        ),
                                        child: Text(
                                          "Leave Type",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          //top: 20,
                                        ),
                                        child: Text(
                                          controller.userDataProvider
                                              .getLeaveDataValues!.reason
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, top: 10),
                                        height: 2,
                                        width: width,
                                        color: Colors.black,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        child: Text(
                                          "Duration",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          //top: 20,
                                        ),
                                        child: Text(
                                          controller.userDataProvider
                                                  .getLeaveDataValues!.fromDate
                                                  .toString() +
                                              '-' +
                                              controller.userDataProvider
                                                  .getLeaveDataValues!.toDate
                                                  .toString(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, top: 10),
                                        height: 2,
                                        width: width,
                                        color: Colors.black,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        child: Text(
                                          "Total Days",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          //top: 20,
                                        ),
                                        child: Text(
                                          controller.userDataProvider
                                              .getLeaveDataValues!.approved
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, top: 10),
                                        height: 2,
                                        width: width,
                                        color: Colors.black,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        child: Text(
                                          "Reason ",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          //top: 20,
                                        ),
                                        child: Text(
                                          controller.userDataProvider
                                              .getLeaveDataValues!.explanation
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, top: 10),
                                        height: 2,
                                        width: width,
                                        color: Colors.black,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        child: Text(
                                          "Voice ",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(left: 25),
                                      //   child: Container(
                                      //     width: 300,
                                      //     height: 70,
                                      //     decoration: BoxDecoration(
                                      //         color: AppTheme.bgBlue,
                                      //         borderRadius:
                                      //             BorderRadius.circular(15)),
                                      //     child: Row(
                                      //       children: [
                                      //         SizedBox(width: 20),
                                      //         StreamBuilder<PlayerState>(
                                      //             stream: controller.audioPlayer
                                      //                 .playerStateStream,
                                      //             builder: (context, snapshot) {
                                      //               final playerState =
                                      //                   snapshot.data;
                                      //               final processingState =
                                      //                   playerState
                                      //                       ?.processingState;
                                      //               final playing =
                                      //                   playerState?.playing;
                                      //               if (!(playing ?? false)) {
                                      //                 return IconButton(
                                      //                     onPressed: () {
                                      //                       // network(
                                      //                       //   ApiUrl.baseUrl + "leave_apply/" + controller.userDataProvider
                                      //                       //       .getLeaveDataValues!.voiceNote.toString()),
                                      //                     },
                                      //                     icon: Icon(
                                      //                       Icons
                                      //                           .play_arrow_rounded,
                                      //                       size: 30,
                                      //                       color: Colors.black,
                                      //                     ));
                                      //               } else if (processingState !=
                                      //                   ProcessingState
                                      //                       .completed) {
                                      //                 return IconButton(
                                      //                     onPressed: controller
                                      //                         .audioPlayer
                                      //                         .pause,
                                      //                     icon: Icon(
                                      //                         Icons
                                      //                             .pause_rounded,
                                      //                         size: 30,
                                      //                         color: Colors
                                      //                             .black));
                                      //               }
                                      //               return Icon(Icons
                                      //                   .play_arrow_rounded);
                                      //             }),
                                      //         SizedBox(
                                      //           width: 30,
                                      //         ),
                                      //         Container(
                                      //           margin:
                                      //               EdgeInsets.only(top: 15),
                                      //           width: 180,
                                      //           child: StreamBuilder(
                                      //               stream: _positionDataStream,
                                      //               builder:
                                      //                   (context, snapshot) {
                                      //                 final positionData =
                                      //                     snapshot.data;
                                      //                 return ProgressBar(
                                      //                   progress: positionData
                                      //                           ?.position ??
                                      //                       Duration.zero,
                                      //                   buffered: positionData
                                      //                           ?.bufferedPosition ??
                                      //                       Duration.zero,
                                      //                   total: positionData
                                      //                           ?.duration ??
                                      //                       Duration.zero,
                                      //                   onSeek: controller
                                      //                       .audioPlayer.seek,
                                      //                 );
                                      //               }),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, top: 10),
                                        height: 2,
                                        width: width,
                                        color: Colors.black,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(20),
                                            child: Button(
                                              widthFactor: 0.28,
                                              heightFactor: 0.04,
                                              onPressed: () {
                                                controller.leaveApprove();
                                              },
                                              child: Text(
                                                "Approve",
                                                style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(20),
                                            child: Button(
                                              widthFactor: 0.28,
                                              heightFactor: 0.04,
                                              onPressed: () {
                                                if (controller
                                                    .isRejectVisible.value) {
                                                  controller.isRejectVisible
                                                      .value = false;
                                                } else {
                                                  controller.isRejectVisible
                                                      .value = true;
                                                }
                                              },
                                              child: Text(
                                                "Reject",
                                                style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    letterSpacing: 0.1,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Obx(
                                        () => Visibility(
                                            visible: controller
                                                .isRejectVisible.value,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTapDown:
                                                      (TapDownDetails details) {
                                                    controller.startRecord();
                                                    Fluttertoast.showToast(
                                                      msg: "Record Starting",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          Colors.black,
                                                      textColor: Colors.white,
                                                    );
                                                  },
                                                  onTapUp:
                                                      (TapUpDetails details) {
                                                    controller.stopRecord();
                                                    controller.isAudio.value =
                                                        true;
                                                    Fluttertoast.showToast(
                                                      msg: "Record Stop",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          Colors.black,
                                                      textColor: Colors.white,
                                                    );
                                                  },
                                                  child: Card(
                                                    elevation: 2,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                          color: AppTheme
                                                              .liteWhite),
                                                    ),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.12,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      decoration: BoxDecoration(
                                                          color: AppTheme
                                                              .liteWhite,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color: AppTheme
                                                                    .liteWhite,
                                                                spreadRadius: 0,
                                                                blurRadius: 2)
                                                          ]),
                                                      child: const Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.mic,
                                                            size: 40,
                                                          ),
                                                          Text(
                                                            "Hold",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Obx(
                                                  () => Visibility(
                                                    visible: controller
                                                        .isAudio.value,
                                                    child: Container(
                                                      width: 300,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              AppTheme.bgBlue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: 20),
                                                          StreamBuilder<
                                                                  PlayerState>(
                                                              stream: controller
                                                                  .audioPlayer
                                                                  .playerStateStream,
                                                              builder: (context,
                                                                  snapshot) {
                                                                final playerState =
                                                                    snapshot
                                                                        .data;
                                                                final processingState =
                                                                    playerState
                                                                        ?.processingState;
                                                                final playing =
                                                                    playerState
                                                                        ?.playing;
                                                                if (!(playing ??
                                                                    false)) {
                                                                  return IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .play();
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .play_arrow_rounded,
                                                                        size:
                                                                            30,
                                                                        color: Colors
                                                                            .black,
                                                                      ));
                                                                } else if (processingState !=
                                                                    ProcessingState
                                                                        .completed) {
                                                                  return IconButton(
                                                                      onPressed: controller
                                                                          .audioPlayer
                                                                          .pause,
                                                                      icon: Icon(
                                                                          Icons
                                                                              .pause_rounded,
                                                                          size:
                                                                              30,
                                                                          color:
                                                                              Colors.black));
                                                                }
                                                                return Icon(Icons
                                                                    .play_arrow_rounded);
                                                              }),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            width: 180,
                                                            child:
                                                                StreamBuilder(
                                                                    stream:
                                                                        _positionDataStream,
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      final positionData =
                                                                          snapshot
                                                                              .data;
                                                                      return ProgressBar(
                                                                        progress:
                                                                            positionData?.position ??
                                                                                Duration.zero,
                                                                        buffered:
                                                                            positionData?.bufferedPosition ??
                                                                                Duration.zero,
                                                                        total: positionData?.duration ??
                                                                            Duration.zero,
                                                                        onSeek: controller
                                                                            .audioPlayer
                                                                            .seek,
                                                                      );
                                                                    }),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    left: 20,
                                                    top: 20,
                                                  ),
                                                  child: Text(
                                                    "Reason with Explain",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        letterSpacing: 0.1,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(20),
                                                  // Set the color of the container
                                                  padding: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                      color: AppTheme.bgPink,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  // Adjust the padding as needed
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextField(
                                                        controller: controller
                                                            .reasonController,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    'Enter text here',
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                  // No border
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(20),
                                        child: Button(
                                          widthFactor: 0.86,
                                          heightFactor: 0.06,
                                          onPressed: () {
                                            controller.leaveReject();
                                          },
                                          child: Text(
                                            "Submit",
                                            style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 150,
                    // right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(40)),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          "assets/images/profile_dummy.jpg",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
