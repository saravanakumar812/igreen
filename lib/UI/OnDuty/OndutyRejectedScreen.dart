import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../forms/theme.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:just_audio/just_audio.dart';
import '../../Controller/OndutyRejectScreenController.dart';
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

class OnDutyRejectedScreen extends GetView<OnDutyRejectScreenController> {
  const OnDutyRejectedScreen({super.key});

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
    OnDutyRejectScreenController controller =
        Get.put(OnDutyRejectScreenController());

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
                        'OnDuty Rejected',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      InkWell(
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
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                top: 20,
                                              ),
                                              child: Text(
                                                "Starting Date :",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                top: 20,
                                              ),
                                              child: Text(
                                                "${controller.userDataProvider.getOnDutyRejectData!.startingDate.toString() ?? 0}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                top: 20,
                                              ),
                                              child: Text(
                                                "Closing Date :",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                top: 20,
                                              ),
                                              child: Text(
                                                "${controller.userDataProvider.getOnDutyRejectData!.endingDate.toString() ?? 0}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                top: 20,
                                              ),
                                              child: Text(
                                                "Remarks :",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                top: 20,
                                              ),
                                              child: Text(
                                                "${controller.userDataProvider.getOnDutyRejectData!.remarks.toString() ?? 0}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
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
                                        controller.userDataProvider.getOnDutyRejectData!.audioFile!.isNotEmpty ?
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
                                                        .audioPlayer
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
                                                              controller.play();
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
                                                            onPressed:
                                                                controller
                                                                    .audioPlayer
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
                                                          _positionDataStream,
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
                                                              .audioPlayer.seek,
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ) : Center(
                                          child: Container(
                                            child: Text(
                                              'NO DATA',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ]),
                                            controller
                                                .userDataProvider
                                                .getOnDutyRejectData!
                                                .images!.isNotEmpty ?
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 5),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 5),
                                                    child: Image.network(
                                                      ApiUrl.baseUrl +
                                                          "ideas/" +
                                                          controller
                                                              .userDataProvider
                                                              .getOnDutyRejectData!
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
                                            ) : Container(
                                              child:  Text(
                                              'NO DATA',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
