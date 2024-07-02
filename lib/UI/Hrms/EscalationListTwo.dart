import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/forms/forms.dart';
import '../../../../forms/theme.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:just_audio/just_audio.dart';

import '../../Controller/EscalationTwoController.dart';
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

class EscalationListTwo extends GetView<EscalationTwoController> {
  const EscalationListTwo({super.key});

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          controller.audioPlayer.positionStream,
          controller.audioPlayer.bufferedPositionStream,
          controller.audioPlayer.durationStream,
          (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration!));
  Stream<PositionData> get _positionDataStreamOne =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          controller.audioPlayerOne.positionStream,
          controller.audioPlayerOne.bufferedPositionStream,
          controller.audioPlayerOne.durationStream,
              (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration!));
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    EscalationTwoController controller = Get.put(EscalationTwoController());

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
                        'Escalation List',
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
                                builder: (context) => EscalationListTwo()),
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
                                          "Message",
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
                                              .getEscalationValues!.messages
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        child: Text(
                                          "Voice",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      controller.userDataProvider
                                          .getEscalationValues!.audioFile!.isNotEmpty ?
                                      Padding(
                                        padding: EdgeInsets.only(left: 25),
                                        child: Container(
                                          width: 300,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: AppTheme.bgBlue,
                                              borderRadius:
                                              BorderRadius.circular(15)),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 20),
                                              StreamBuilder<PlayerState>(
                                                  stream: controller
                                                      .audioPlayerOne
                                                      .playerStateStream,
                                                  builder:
                                                      (context, snapshot) {
                                                    final playerState =
                                                        snapshot.data;
                                                    final processingState =
                                                        playerState
                                                            ?.processingState;
                                                    final playing =
                                                        playerState?.playing;
                                                    if (!(playing ?? false)) {
                                                      return IconButton(
                                                          onPressed: () {
                                                            controller
                                                                .playOne();
                                                            print("true");
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .play_arrow_rounded,
                                                            size: 30,
                                                            color:
                                                            Colors.black,
                                                          ));
                                                    } else if (processingState !=
                                                        ProcessingState
                                                            .completed) {
                                                      return IconButton(
                                                          onPressed: controller
                                                              .audioPlayerOne
                                                              .pause,
                                                          icon: Icon(
                                                              Icons
                                                                  .pause_rounded,
                                                              size: 30,
                                                              color: Colors
                                                                  .black));
                                                    }
                                                    return Icon(Icons
                                                        .play_arrow_rounded);
                                                  }),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Container(
                                                margin:
                                                EdgeInsets.only(top: 15),
                                                width: 180,
                                                child: StreamBuilder(
                                                    stream:
                                                    _positionDataStreamOne,
                                                    builder:
                                                        (context, snapshot) {
                                                      final positionData =
                                                          snapshot.data;
                                                      return ProgressBar(
                                                        progress: positionData
                                                            ?.position ??
                                                            Duration.zero,
                                                        buffered: positionData
                                                            ?.bufferedPosition ??
                                                            Duration.zero,
                                                        total: positionData
                                                            ?.duration ??
                                                            Duration.zero,
                                                        onSeek: controller
                                                            .audioPlayerOne
                                                            .seek,
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ) : Container(),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, top: 10),
                                        height: 2,
                                        width: width,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Row(children: [
                                            SizedBox(width: 15),
                                            Text(
                                              "Picture",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ]),
                                          controller
                                              .userDataProvider
                                              .getEscalationValues!
                                              .images!.isNotEmpty ?     Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white),
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  child: Image.network(
                                                    ApiUrl.baseUrl +
                                                        "escalation/" +
                                                        controller
                                                            .userDataProvider
                                                            .getEscalationValues!
                                                            .images
                                                            .toString(),
                                                    fit: BoxFit.contain,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ) : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
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
                                                // controller.escalationRespond();
                                              },
                                              child: Text(
                                                "Response",
                                                style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
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
                                                    child: Column(
                                                      children: [
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
                                                            color: Colors.grey[300],
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
                                                Container(
                                                  margin: EdgeInsets.all(20),
                                                  child: Button(
                                                    widthFactor: 0.86,
                                                    heightFactor: 0.06,
                                                    onPressed: () {
                                                      controller
                                                          .escalationApproval();
                                                    },
                                                    child: Text(
                                                      "Submit",
                                                      style: GoogleFonts.lato(
                                                          color: Colors.white,
                                                          //letterSpacing: 0.1,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
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
                        backgroundImage: NetworkImage(
                          ApiUrl.baseUrl +
                              "escalation/" +
                              controller.userDataProvider.getEscalationValues!
                                  .profileImage
                                  .toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
