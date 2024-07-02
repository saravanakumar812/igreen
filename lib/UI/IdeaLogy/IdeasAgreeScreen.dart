import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../forms/theme.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:just_audio/just_audio.dart';
import '../../Controller/IdeasAgreeScreenController.dart';
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

class IdeasAgreeScreen extends GetView<IdeasAgreeScreenController> {
  const IdeasAgreeScreen({super.key});

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
    IdeasAgreeScreenController controller =
        Get.put(IdeasAgreeScreenController());

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
                        width: 40,
                      ),
                      Text(
                        ' IdeaLogy Agree screen',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      InkWell(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => EscalationListTwo()),
                        //   );
                        // },
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
                                                "Ideas :",
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
                                                "${controller.userDataProvider.getIdeaLogyEmployeeData!.ideas.toString() ?? 0}",
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
                                                "Employee Name:",
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
                                                "${controller.userDataProvider.getIdeaLogyEmployeeData!.employeeName.toString() ?? 0}",
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
                                      controller.userDataProvider
                                            .getIdeaLogyEmployeeData!.audioFile!.isNotEmpty ?
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
                                          child: Container(child: Text(
                                          'NO DATA',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontFamily: 'lato',
                                              fontWeight: FontWeight.w600),
                                                                                ),),
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
                                                .getIdeaLogyEmployeeData!
                                                .images!.isNotEmpty ?                 Column(
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
                                                              .getIdeaLogyEmployeeData!
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
                                            ) :Container(
                                              child: Text(
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller.userDataProvider
                                                    .setCurrentStatus('Agree');

                                                controller.addAgreeIdeas();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 5),
                                                width: width * 0.18,
                                                height: height * 0.045,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 179, 176, 176),
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                    child: Text(
                                                  "Agree ",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      letterSpacing: 0.1,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.userDataProvider
                                                    .setCurrentStatus(
                                                        'Dis Agree');
                                                controller.addAgreeIdeas();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 5,
                                                    left: 15,
                                                    right: 15),
                                                width: width * 0.2,
                                                height: height * 0.045,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 179, 176, 176),
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                    child: Text(
                                                  "Dis Agree",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      letterSpacing: 0.1,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
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
