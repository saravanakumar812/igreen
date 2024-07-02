import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:igreen_flutter/forms/theme.dart';
import 'package:igreen_flutter/routes/app_routes.dart';
import 'package:just_audio/just_audio.dart';

import '../../Controller/AddEventsController.dart';
import '../../Controller/TaskViewController.dart';
import '../../Utils/image_picker.dart';
import '../../forms/forms.dart';
import 'package:rxdart/rxdart.dart' as rx;

import 'NonProjectListScreen.dart';

class PositionData {
  const PositionData(this.position,
      this.bufferedPosition,
      this.duration,);

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class TaskView extends GetView<TaskViewController> {
  const TaskView({super.key});

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          controller.audioPlayer.positionStream,
          controller.audioPlayer.bufferedPositionStream,
          controller.audioPlayer.durationStream,
              (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration!));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    TaskViewController controller = Get.put(TaskViewController());
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
                              Get.to(
                                  NonProjectListScreen()
                              );
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
                      const Text(
                        "Task View",
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
                                                "Name :",
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
                                                "${controller.userDataProvider
                                                    .getTaskViewData!.names
                                                    .toString() ?? 0}",
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
                                                "Descriptions:",
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
                                                "${controller.userDataProvider
                                                    .getTaskViewData!
                                                    .descriptions.toString() ??
                                                    0}",
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
                                                "Department :",
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
                                                "${controller.userDataProvider
                                                    .getTaskViewData!.department
                                                    .toString() ?? 0}",
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
                                                "Start Date :",
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
                                                "${controller.userDataProvider
                                                    .getTaskViewData!.startdate
                                                    .toString() ?? 0}",
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
                                                "End Date :",
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
                                                "${controller.userDataProvider
                                                    .getTaskViewData!.enddate
                                                    .toString() ?? 0}",
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
                                                "Expected Time :",
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
                                                "${controller.userDataProvider
                                                    .getTaskViewData!
                                                    .expectedCompletionDate
                                                    .toString() ?? 0}",
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
                                                "Resources:",
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
                                                "${controller.userDataProvider
                                                    .getTaskViewData!.resources
                                                    .toString() ?? 0}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            Button2(
                                              widthFactor: 0.3,
                                              heightFactor: 0.05,
                                              onPressed: () {
                                                //controller.taskIdValue.value = index;
                                                controller.updateStartedTask(
                                                    "Started");
                                              },
                                              child: Text(
                                                "Started",
                                                style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight
                                                        .w500),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Button(
                                              widthFactor: 0.3,
                                              heightFactor: 0.05,
                                              onPressed: () {
                                                //controller.taskIdValue.value = index;
                                                //controller.updateTask("Completed");

                                                // showDialog(
                                                // //  barrierColor: AppTheme.appColor,
                                                //   context: context,
                                                //   builder: (context) {
                                                //     return Theme(
                                                //       data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.orange),
                                                //       child:  AlertDialog(
                                                //       backgroundColor: AppTheme.appColor,
                                                //       title: Text(
                                                //         '',
                                                //         style: GoogleFonts.poppins(
                                                //             color: Colors.black,
                                                //             fontSize: 15,
                                                //             fontWeight: FontWeight.w600),
                                                //       ),
                                                //       actions: [
                                                //
                                                //         TextInput(
                                                //           height: 100,
                                                //           label: "Remarks",
                                                //           onPressed: () {
                                                //
                                                //
                                                //           },
                                                //           controller: controller.remarksController,
                                                //           textInputType: TextInputType.text,
                                                //           textColor: Color(0xCC252525),
                                                //           hintText: "Enter Remarks",
                                                //           onTextChange: (String) {
                                                //             // controller.popUpValue.value = true;
                                                //           },
                                                //         ),
                                                //         Obx(
                                                //               () => Visibility(
                                                //             visible: true,
                                                //             child: Row(
                                                //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                //               children: [
                                                //                 Card(
                                                //                   elevation: 2,
                                                //                   shape: RoundedRectangleBorder(
                                                //                     borderRadius: BorderRadius.circular(10),
                                                //                     side: BorderSide(color: AppTheme.liteWhite),
                                                //                   ),
                                                //                   child: Container(
                                                //                     height: MediaQuery.of(context).size.height * 0.12,
                                                //                     width: MediaQuery.of(context).size.width * 0.3,
                                                //                     decoration: BoxDecoration(
                                                //                       borderRadius: BorderRadius.circular(10),
                                                //                       border: controller.pickImageSelected.value
                                                //                           ? null
                                                //                           : Border.all(
                                                //                           color: AppTheme.liteWhite, width: 3),
                                                //                     ),
                                                //                     child: Material(
                                                //                       color: AppTheme.liteWhite,
                                                //                       child: InkWell(
                                                //                         onTap: () {
                                                //                           Get.to(
                                                //                             ImagePick(
                                                //                               isMultiple: true,
                                                //                               title: "Profile ",
                                                //                               onClose: () => Get.back(),
                                                //                               onSave: (List<PickedImage> images) {
                                                //                                 if (images.isNotEmpty) {
                                                //                                   controller.itemImagePick.value =
                                                //                                   images[0];
                                                //                                   controller.pickImageSelected.value =
                                                //                                   true;
                                                //                                 }
                                                //                                 Get.back();
                                                //                               },
                                                //                             ),
                                                //                           );
                                                //                         },
                                                //                         child: Stack(
                                                //                           children: [
                                                //                             if (controller.itemImagePick.value !=
                                                //                                 null && controller.itemImagePick.value.imagePath !=
                                                //                                 null)
                                                //                               Image.file(
                                                //                                 controller
                                                //                                     .itemImagePick!.value!.imagePath,
                                                //                                 width: 150,
                                                //                                 height: 150,
                                                //                                 fit: BoxFit.cover,
                                                //                               ),
                                                //                             if (controller.itemImagePick.value ==
                                                //                                 null || controller.itemImagePick.value.imagePath ==
                                                //                                 null)
                                                //                               const Center(
                                                //                                 child: Column(
                                                //                                   mainAxisAlignment:
                                                //                                   MainAxisAlignment.center,
                                                //                                   children: [
                                                //                                     Icon(
                                                //                                       Icons.image,
                                                //                                       size: 50,
                                                //                                     ),
                                                //                                     Text(
                                                //                                       "Bill",
                                                //                                       style: TextStyle(
                                                //                                           fontSize: 15,
                                                //                                           fontWeight: FontWeight.w600,
                                                //                                           color: Colors.black),
                                                //                                     ),
                                                //                                   ],
                                                //                                 ),
                                                //                               ),
                                                //                           ],
                                                //                         ),
                                                //                       ),
                                                //                     ),
                                                //                   ),
                                                //                 ),
                                                //                 GestureDetector(
                                                //                   onTapDown: (TapDownDetails details) {
                                                //                     controller.startRecord();
                                                //                     Fluttertoast.showToast(
                                                //                       msg: "Record Starting",
                                                //                       toastLength: Toast.LENGTH_SHORT,
                                                //                       gravity: ToastGravity.BOTTOM,
                                                //                       backgroundColor: Colors.black,
                                                //                       textColor: Colors.white,
                                                //                     );
                                                //                   },
                                                //                   onTapUp: (TapUpDetails details) {
                                                //                     controller.stopRecord();
                                                //                     controller.isAudio.value = true;
                                                //                     Fluttertoast.showToast(
                                                //                       msg: "Record Stop",
                                                //                       toastLength: Toast.LENGTH_SHORT,
                                                //                       gravity: ToastGravity.BOTTOM,
                                                //                       backgroundColor: Colors.black,
                                                //                       textColor: Colors.white,
                                                //                     );
                                                //                   },
                                                //                   child: Card(
                                                //                     elevation: 2,
                                                //                     shape: RoundedRectangleBorder(
                                                //                       borderRadius: BorderRadius.circular(10),
                                                //                       side: BorderSide(color: AppTheme.liteWhite),
                                                //                     ),
                                                //                     child: Container(
                                                //                       height: MediaQuery.of(context).size.height * 0.12,
                                                //                       width: MediaQuery.of(context).size.width * 0.3,
                                                //                       decoration: BoxDecoration(
                                                //                           color: AppTheme.liteWhite,
                                                //                           borderRadius: BorderRadius.circular(10),
                                                //                           boxShadow: const [
                                                //                             BoxShadow(
                                                //                                 color: AppTheme.liteWhite,
                                                //                                 spreadRadius: 0,
                                                //                                 blurRadius: 2)
                                                //                           ]),
                                                //                       child: const Column(
                                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                                //                         children: [
                                                //                           Icon(
                                                //                             Icons.mic,
                                                //                             size: 40,
                                                //                           ),
                                                //                           Text(
                                                //                             "Hold",
                                                //                             style: TextStyle(
                                                //                                 fontSize: 15,
                                                //                                 fontWeight: FontWeight.w600,
                                                //                                 color: Colors.black),
                                                //                           ),
                                                //                         ],
                                                //                       ),
                                                //                     ),
                                                //                   ),
                                                //                 ),
                                                //               ],
                                                //             ),
                                                //           ),
                                                //         ),
                                                //         SizedBox(
                                                //           height: 20,
                                                //         ),
                                                //         Obx(
                                                //               () => Visibility(
                                                //             visible: controller.isAudio.value,
                                                //             child: Column(
                                                //               children: [
                                                //                 Container(
                                                //                   child: Row(
                                                //                     //crossAxisAlignment: CrossAxisAlignment.center,
                                                //                     mainAxisAlignment: MainAxisAlignment.end,
                                                //                     children: [
                                                //                       Padding(
                                                //                         padding: const EdgeInsets.only(right: 10),
                                                //                         child: Container(
                                                //                           width: 20,
                                                //                           height: 20,
                                                //                           decoration: BoxDecoration(
                                                //                               color: AppTheme.white,
                                                //                               borderRadius: BorderRadius.circular(15)),
                                                //                           child: Center(
                                                //                               child: GestureDetector(
                                                //                                 onTap: () {
                                                //                                   controller.deleteOldData();
                                                //                                 },
                                                //                                 child: Image.asset(
                                                //                                   "assets/images/closed.png",
                                                //                                   fit: BoxFit.contain,
                                                //                                   width: width * 0.3,
                                                //                                   height: height * 0.1,
                                                //                                 ),
                                                //                               )),
                                                //                         ),
                                                //                       )
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //                 Container(
                                                //                   width: MediaQuery.of(context).size.width - 120,
                                                //                   height: 60,
                                                //                   padding: const EdgeInsets.symmetric(horizontal: 10),
                                                //                   margin: const EdgeInsets.only(bottom: 10),
                                                //                   decoration: BoxDecoration(
                                                //                     borderRadius: BorderRadius.circular(8),
                                                //                     color: Colors.white,
                                                //                   ),
                                                //                   child: Row(
                                                //                     children: [
                                                //                       //SizedBox(width: 15),
                                                //                       StreamBuilder<PlayerState>(
                                                //                           stream: controller.audioPlayer.playerStateStream,
                                                //                           builder: (context, snapshot) {
                                                //                             final playerState = snapshot.data;
                                                //                             final processingState =
                                                //                                 playerState?.processingState;
                                                //                             final playing = playerState?.playing;
                                                //                             if (!(playing ?? false)) {
                                                //                               return IconButton(
                                                //                                   onPressed: () {
                                                //                                     controller.play();
                                                //                                   },
                                                //                                   icon: Icon(
                                                //                                     Icons.play_arrow_rounded,
                                                //                                     size: 30,
                                                //                                     color: Colors.black,
                                                //                                   ));
                                                //                             } else if (processingState !=
                                                //                                 ProcessingState.completed) {
                                                //                               return IconButton(
                                                //                                   onPressed: controller.audioPlayer.pause,
                                                //                                   icon: Icon(Icons.pause_rounded,
                                                //                                       size: 30, color: Colors.black));
                                                //                             }
                                                //                             return Icon(Icons.play_arrow_rounded);
                                                //                           }),
                                                //                       SizedBox(
                                                //                         width: 20,
                                                //                       ),
                                                //                       Container(
                                                //                         margin: EdgeInsets.only(top: 15),
                                                //                         width: 165,
                                                //                         child: StreamBuilder(
                                                //                             stream: _positionDataStream,
                                                //                             builder: (context, snapshot) {
                                                //                               final positionData = snapshot.data;
                                                //                               return ProgressBar(
                                                //                                 progress:
                                                //                                 positionData?.position ?? Duration.zero,
                                                //                                 buffered: positionData?.bufferedPosition ??
                                                //                                     Duration.zero,
                                                //                                 total:
                                                //                                 positionData?.duration ?? Duration.zero,
                                                //                                 onSeek: controller.audioPlayer.seek,
                                                //                               );
                                                //                             }),
                                                //                       ),
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //               ],
                                                //             ),
                                                //           ),
                                                //         ),
                                                //         Row(
                                                //           mainAxisAlignment:
                                                //           MainAxisAlignment.spaceBetween,
                                                //           children: [
                                                //             Button2(
                                                //               widthFactor: 0.28,
                                                //               heightFactor: 0.04,
                                                //               onPressed: () {
                                                //                 Get.back();
                                                //               },
                                                //               child: Text(
                                                //                 "Cancel",
                                                //                 style: GoogleFonts.lato(
                                                //                     color: Colors.white,
                                                //                     fontSize: 10,
                                                //                     fontWeight:
                                                //                     FontWeight.w500),
                                                //               ),
                                                //             ),
                                                //             SizedBox(
                                                //               width: 10,
                                                //             ),
                                                //             Button(
                                                //               widthFactor: 0.28,
                                                //               heightFactor: 0.04,
                                                //               onPressed: () {
                                                //                 controller.updateCompleteTask("Completed");
                                                //                 // Get.back();
                                                //               },
                                                //               child: Text(
                                                //                 "Yes",
                                                //                 style: GoogleFonts.lato(
                                                //                     color: Colors.white,
                                                //                     fontSize: 10,
                                                //                     fontWeight:
                                                //                     FontWeight.w500),
                                                //               ),
                                                //             ),
                                                //           ],
                                                //         ),
                                                //       ],
                                                //     ),
                                                //
                                                //
                                                //
                                                //     );
                                                //   },
                                                // );

                                                showDialogBox(context);
                                              },
                                              child: Text(
                                                "Completed",
                                                style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight
                                                        .w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),


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
            )


        ));
  }

  void showDialogBox(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      TaskViewController controller = Get.put(TaskViewController());
      double width = MediaQuery
          .of(context)
          .size
          .width;
      double height = MediaQuery
          .of(context)
          .size
          .height;
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          '',
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        actions: [

          Container(
            margin: EdgeInsets.fromLTRB(12, 14, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  child: TextFormField(
                      style: TextStyle(
                          letterSpacing: 0.2,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      controller: controller.remarksController,
                      decoration: InputDecoration(
                        fillColor: AppTheme.screenBackground,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical:10.0
                                ),
                        label: Text('Remarks'),
                        labelStyle: TextStyle(
                            color:  AppTheme.labelColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),

                        hintText: "Enter Remarks",
                        hintStyle: TextStyle(
                          color: AppTheme.labelColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.5),
                          borderSide: BorderSide( color: Color(0x4d252525),width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.5),
                          borderSide:  BorderSide(
                              color: Color(0x4d252525), width: 1.0),
                        ),



                      )
                  ),
                )
              ],
            ),
          ),

          // TextInput(
          //   height: 100,
          //   label: "Remarks",
          //   onPressed: () {
          //     },
          //   controller: controller.remarksController,
          //   textInputType: TextInputType.text,
          //   textColor: Color(0xCC252525),
          //   hintText: "Enter Remarks",
          //   onTextChange: (String) {
          //     // controller.popUpValue.value = true;
          //   },
          // ),
          Obx(
                () =>
                Visibility(
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
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.12,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.3,
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
                                    title: "Profile ",
                                    onClose: () => Get.back(),
                                    onSave: (List<PickedImage> images) {
                                      if (images.isNotEmpty) {
                                        controller.itemImagePick.value =
                                        images[0];
                                        controller.pickImageSelected.value =
                                        true;
                                      }
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  if (controller.itemImagePick.value !=
                                      null && controller.itemImagePick.value
                                      .imagePath !=
                                      null)
                                    Image.file(
                                      controller
                                          .itemImagePick!.value!.imagePath,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  if (controller.itemImagePick.value ==
                                      null || controller.itemImagePick.value
                                      .imagePath ==
                                      null)
                                    const Center(
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
                                                fontWeight: FontWeight.w600,
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
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.12,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.3,
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
                () =>
                Visibility(
                  visible: controller.isAudio.value,
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 120,
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            //SizedBox(width: 15),
                            StreamBuilder<PlayerState>(
                                stream: controller.audioPlayer
                                    .playerStateStream,
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
                              width: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              width: 165,
                              child: StreamBuilder(
                                  stream: _positionDataStream,
                                  builder: (context, snapshot) {
                                    final positionData = snapshot.data;
                                    return ProgressBar(
                                      progress:
                                      positionData?.position ?? Duration.zero,
                                      buffered: positionData
                                          ?.bufferedPosition ??
                                          Duration.zero,
                                      total:
                                      positionData?.duration ?? Duration.zero,
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
                  controller.updateCompleteTask("Completed");
                  // Get.back();
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
  }
}

// void showDialog(BuildContext context) {
//  return showDialog(
//      context,
//     builder: (BuildContext context) {
//       return  AlertDialog(
//         backgroundColor: AppTheme.appColor,
//         title: Text(
//           '',
//           style: GoogleFonts.poppins(
//               color: Colors.black,
//               fontSize: 15,
//               fontWeight: FontWeight.w600),
//         ),
//         actions: [
//
//           TextInput(
//             height: 100,
//             label: "Remarks",
//             onPressed: () {
//
//
//             },
//             controller: controller.remarksController,
//             textInputType: TextInputType.text,
//             textColor: Color(0xCC252525),
//             hintText: "Enter Remarks",
//             onTextChange: (String) {
//               // controller.popUpValue.value = true;
//             },
//           ),
//           Obx(
//                 () => Visibility(
//               visible: true,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       side: BorderSide(color: AppTheme.liteWhite),
//                     ),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.12,
//                       width: MediaQuery.of(context).size.width * 0.3,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: controller.pickImageSelected.value
//                             ? null
//                             : Border.all(
//                             color: AppTheme.liteWhite, width: 3),
//                       ),
//                       child: Material(
//                         color: AppTheme.liteWhite,
//                         child: InkWell(
//                           onTap: () {
//                             Get.to(
//                               ImagePick(
//                                 isMultiple: true,
//                                 title: "Profile ",
//                                 onClose: () => Get.back(),
//                                 onSave: (List<PickedImage> images) {
//                                   if (images.isNotEmpty) {
//                                     controller.itemImagePick.value =
//                                     images[0];
//                                     controller.pickImageSelected.value =
//                                     true;
//                                   }
//                                   Get.back();
//                                 },
//                               ),
//                             );
//                           },
//                           child: Stack(
//                             children: [
//                               if (controller.itemImagePick.value !=
//                                   null && controller.itemImagePick.value.imagePath !=
//                                   null)
//                                 Image.file(
//                                   controller
//                                       .itemImagePick!.value!.imagePath,
//                                   width: 150,
//                                   height: 150,
//                                   fit: BoxFit.cover,
//                                 ),
//                               if (controller.itemImagePick.value ==
//                                   null || controller.itemImagePick.value.imagePath ==
//                                   null)
//                                 const Center(
//                                   child: Column(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       Icon(
//                                         Icons.image,
//                                         size: 50,
//                                       ),
//                                       Text(
//                                         "Bill",
//                                         style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTapDown: (TapDownDetails details) {
//                       controller.startRecord();
//                       Fluttertoast.showToast(
//                         msg: "Record Starting",
//                         toastLength: Toast.LENGTH_SHORT,
//                         gravity: ToastGravity.BOTTOM,
//                         backgroundColor: Colors.black,
//                         textColor: Colors.white,
//                       );
//                     },
//                     onTapUp: (TapUpDetails details) {
//                       controller.stopRecord();
//                       controller.isAudio.value = true;
//                       Fluttertoast.showToast(
//                         msg: "Record Stop",
//                         toastLength: Toast.LENGTH_SHORT,
//                         gravity: ToastGravity.BOTTOM,
//                         backgroundColor: Colors.black,
//                         textColor: Colors.white,
//                       );
//                     },
//                     child: Card(
//                       elevation: 2,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         side: BorderSide(color: AppTheme.liteWhite),
//                       ),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.12,
//                         width: MediaQuery.of(context).size.width * 0.3,
//                         decoration: BoxDecoration(
//                             color: AppTheme.liteWhite,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: const [
//                               BoxShadow(
//                                   color: AppTheme.liteWhite,
//                                   spreadRadius: 0,
//                                   blurRadius: 2)
//                             ]),
//                         child: const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.mic,
//                               size: 40,
//                             ),
//                             Text(
//                               "Hold",
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Obx(
//                 () => Visibility(
//               visible: controller.isAudio.value,
//               child: Column(
//                 children: [
//                   Container(
//                     child: Row(
//                       //crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 10),
//                           child: Container(
//                             width: 20,
//                             height: 20,
//                             decoration: BoxDecoration(
//                                 color: AppTheme.white,
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: Center(
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     controller.deleteOldData();
//                                   },
//                                   child: Image.asset(
//                                     "assets/images/closed.png",
//                                     fit: BoxFit.contain,
//                                     width: width * 0.3,
//                                     height: height * 0.1,
//                                   ),
//                                 )),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width - 120,
//                     height: 60,
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     margin: const EdgeInsets.only(bottom: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.white,
//                     ),
//                     child: Row(
//                       children: [
//                         //SizedBox(width: 15),
//                         StreamBuilder<PlayerState>(
//                             stream: controller.audioPlayer.playerStateStream,
//                             builder: (context, snapshot) {
//                               final playerState = snapshot.data;
//                               final processingState =
//                                   playerState?.processingState;
//                               final playing = playerState?.playing;
//                               if (!(playing ?? false)) {
//                                 return IconButton(
//                                     onPressed: () {
//                                       controller.play();
//                                     },
//                                     icon: Icon(
//                                       Icons.play_arrow_rounded,
//                                       size: 30,
//                                       color: Colors.black,
//                                     ));
//                               } else if (processingState !=
//                                   ProcessingState.completed) {
//                                 return IconButton(
//                                     onPressed: controller.audioPlayer.pause,
//                                     icon: Icon(Icons.pause_rounded,
//                                         size: 30, color: Colors.black));
//                               }
//                               return Icon(Icons.play_arrow_rounded);
//                             }),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: 15),
//                           width: 165,
//                           child: StreamBuilder(
//                               stream: _positionDataStream,
//                               builder: (context, snapshot) {
//                                 final positionData = snapshot.data;
//                                 return ProgressBar(
//                                   progress:
//                                   positionData?.position ?? Duration.zero,
//                                   buffered: positionData?.bufferedPosition ??
//                                       Duration.zero,
//                                   total:
//                                   positionData?.duration ?? Duration.zero,
//                                   onSeek: controller.audioPlayer.seek,
//                                 );
//                               }),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment:
//             MainAxisAlignment.spaceBetween,
//             children: [
//               Button2(
//                 widthFactor: 0.28,
//                 heightFactor: 0.04,
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: Text(
//                   "Cancel",
//                   style: GoogleFonts.lato(
//                       color: Colors.white,
//                       fontSize: 10,
//                       fontWeight:
//                       FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Button(
//                 widthFactor: 0.28,
//                 heightFactor: 0.04,
//                 onPressed: () {
//                   controller.updateCompleteTask("Completed");
//                   // Get.back();
//                 },
//                 child: Text(
//                   "Yes",
//                   style: GoogleFonts.lato(
//                       color: Colors.white,
//                       fontSize: 10,
//                       fontWeight:
//                       FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     },
//   );
// }

class TextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final bool isCapsNumeric;
  final double? height;
  final double? contentPaddingV;
  final String? hintText;
  final String? errorText;
  final String? imagePath;
  final bool obscureText;
  final bool margin;

  final bool isEntryField;
  final bool withImage;
  final bool isSelected;
  final bool isMistake;
  final bool isCapital;
  final bool demoCar;
  final int? MaxLength;
  final bool isReadOnly;
  final bool enableInteractiveSelection;
  final Color textColor;
  final TextInputType? textInputType;
  final VoidCallback? onPressed;
  final String? icon;
  final void Function(String) onTextChange;
  final Icon? sufficIcon;
  final FocusNode? focusNode;

  final Color hintTextColor;
  final Color labelTextColor;

  const TextField({
    required this.label,
    required this.onTextChange,
    this.obscureText = false,
    this.isReadOnly = false,
    this.withImage = false,
    this.isCapsNumeric = false,
    this.isEntryField = true,
    this.isSelected = false,
    this.isMistake = false,
    this.isCapital = false,
    this.demoCar = false,
    this.MaxLength,
    this.imagePath,
    this.margin = true,
    this.enableInteractiveSelection = true,
    this.controller,
    this.contentPaddingV,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.height,
    this.hintText,
    this.errorText,
    this.onPressed,
    this.textInputType,
    this.icon,
    this.sufficIcon,
    this.textColor = AppTheme.textColor,
    this.hintTextColor = AppTheme.labelColor90,
    this.labelTextColor = AppTheme.borderLightGrey,
    this.focusNode,
  });

  @override
  State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(12, 14, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              // borderRadius:
              // const BorderRadius.all(Radius.circular(4.0)),
              // color: AppTheme.appColor,
              child: TextFormField(
                  focusNode: widget.focusNode,
                  autofocus: false,
                  autocorrect: false,
                  enableSuggestions: false,
                  onTap: widget.onPressed,
                  enableInteractiveSelection:
                  widget.enableInteractiveSelection,
                  readOnly: widget.isReadOnly ? true : false,
                  keyboardType: widget.textInputType,
                  // textInputAction: TextInputAction.done,
                  textCapitalization: widget.isCapital
                      ? TextCapitalization.characters
                      : TextCapitalization.words,
                  minLines:
                  widget.textInputType == TextInputType.multiline
                      ? 3
                      : 1,
                  maxLines:
                  widget.textInputType == TextInputType.multiline
                      ? 3
                      : 1,
                  inputFormatters: widget.isCapsNumeric
                      ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp("[0-9A-Z]")),
                  ]
                      : widget.textInputType! == TextInputType.number ||
                      widget.textInputType! == TextInputType.phone
                      ? [
                    FilteringTextInputFormatter.deny(
                        RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                    LengthLimitingTextInputFormatter(10)
                  ]
                      : [
                    FilteringTextInputFormatter.deny(
                        RegExp(r'#')),
                    // FilteringTextInputFormatter.allow("[a-zA-Z0-9\s]"),

                    // Disallow suggestions WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9\s]")),
                  ],
                  maxLength: widget.MaxLength,
                  onChanged: widget.onTextChange,
                  controller: widget.controller,
                  style: TextStyle(
                      letterSpacing: 0.2,
                      color: widget.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  decoration: InputDecoration(
                    fillColor: AppTheme.screenBackground,
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: widget.label,
                    counter: Offstage(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(
                        color: widget.controller.isNull
                            ? AppTheme.textColor
                            : widget.controller!.value.text.isEmpty
                            ? AppTheme.textColor
                            : AppTheme.labelColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: AppTheme.labelColor,
                    ),
                    errorText: widget.errorText,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: widget.contentPaddingV.isNull
                            ? 10.0
                            : widget.contentPaddingV!),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.5),
                      borderSide: BorderSide(width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.5),
                      borderSide: widget.isMistake
                          ? BorderSide(
                          color: Colors.deepOrangeAccent, width: 1.0)
                          : BorderSide(
                          color: Color(0x4d252525), width: 1.0),
                    ),
                    suffixIcon: widget.obscureText
                        ? IconButton(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15.0),
                      color: Color(0xff252525),
                      onPressed: widget.onPressed,
                      icon: widget.sufficIcon == null
                          ? const Icon(Icons.keyboard_arrow_down)
                          : widget.sufficIcon!,
                    )
                        : null,
                  )
              ),
            )
          ],
        )
    );
  }
}




