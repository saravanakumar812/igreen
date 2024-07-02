
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/NonProjectListControllerScreen.dart';
import '../../forms/theme.dart';
import 'package:rxdart/rxdart.dart' as rx;
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
class NonProjectListScreen extends GetView<NonProjectListControllerScreen> {
  const NonProjectListScreen({super.key});
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
    NonProjectListControllerScreen controller =
        Get.put(NonProjectListControllerScreen());
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
                          Get.toNamed(
                            AppRoutes.home.toName
                          );
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
                    width: 120,
                  ),
                  Text(
                    'Task',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back();
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
        body: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.taskData!.isNotEmpty
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: controller.refreshData,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height - 100,
                              child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 10),
                                itemCount: controller.taskData.length,
                                itemBuilder: (context, index) {
                                  return taskList(context, index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 100),
                            Image.asset(
                              "assets/images/noData.png",
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  Widget taskList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    NonProjectListControllerScreen controller =
        Get.put(NonProjectListControllerScreen());
    var model = controller.taskData[index];
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        onTap: (){
          controller.userDataProvider.setTaskView(
              controller.taskData[index]);
          Get.offNamed(AppRoutes.taskView.toName);
        },
        leading:  Container(
          //margin: EdgeInsets.only(top: 10, left: 20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(20)),
          child: const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
              "assets/images/profile_dummy.jpg",
            ),
          ),
        ),
        title: Column(
          children: [
           
            Container(
              width: width * 0.7,
              margin: EdgeInsets.only(left: 10, bottom: 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Name :',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 250,
                          child: Text(
                            model.names.toString() ?? "",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Description :',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          model.descriptions.toString() ?? "",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   width: width * 0.7,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       SizedBox(height: 20),
                  //       Text(
                  //         'StarTime :',
                  //         style: GoogleFonts.poppins(
                  //             color: Colors.black,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w600),
                  //       ),
                  //       SizedBox(
                  //         width: 8,
                  //       ),
                  //       Text(
                  //         model.startdate.toString() ?? "",
                  //         style: TextStyle(
                  //             fontSize: 12,
                  //             fontWeight: FontWeight.w500,
                  //             color: Colors.black),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   width: width * 0.7,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       SizedBox(height: 20),
                  //       Text(
                  //         'EndTime :',
                  //         style: GoogleFonts.poppins(
                  //             color: Colors.black,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w600),
                  //       ),
                  //       SizedBox(
                  //         width: 8,
                  //       ),
                  //       Text(
                  //         model.enddate.toString() ?? "",
                  //         style: TextStyle(
                  //             fontSize: 12,
                  //             fontWeight: FontWeight.w500,
                  //             color: Colors.black),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Container(
                    width: width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'TaskStatus :',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          model.taskStatus.toString() ?? "",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Button2(
                  //       widthFactor: 0.28,
                  //       heightFactor: 0.04,
                  //       onPressed: () {
                  //         controller.taskIdValue.value = index;
                  //         controller.updateStartedTask("Started");
                  //       },
                  //       child: Text(
                  //         "Started",
                  //         style: GoogleFonts.lato(
                  //             color: Colors.white,
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.w500),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Button(
                  //       widthFactor: 0.28,
                  //       heightFactor: 0.04,
                  //       onPressed: () {
                  //         controller.taskIdValue.value = index;
                  //         // controller.updateTask("Completed");
                  //
                  //         showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return AlertDialog(
                  //               title: Text(
                  //                 '',
                  //                 style: GoogleFonts.poppins(
                  //                     color: Colors.black,
                  //                     fontSize: 15,
                  //                     fontWeight: FontWeight.w600),
                  //               ),
                  //               actions: [
                  //
                  //                 TextInput(
                  //                   height: 100,
                  //                   label: "Remarks",
                  //                   onPressed: () {
                  //
                  //
                  //                   },
                  //                   controller: controller.remarksController,
                  //                   textInputType: TextInputType.text,
                  //                   textColor: Color(0xCC252525),
                  //                   hintText: "Enter Remarks",
                  //                   onTextChange: (String) {
                  //                     // controller.popUpValue.value = true;
                  //                   },
                  //                 ),
                  //                 Obx(
                  //                       () => Visibility(
                  //                     visible: true,
                  //                     child: Row(
                  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                       children: [
                  //                         Card(
                  //                           elevation: 2,
                  //                           shape: RoundedRectangleBorder(
                  //                             borderRadius: BorderRadius.circular(10),
                  //                             side: BorderSide(color: AppTheme.liteWhite),
                  //                           ),
                  //                           child: Container(
                  //                             height: MediaQuery.of(context).size.height * 0.12,
                  //                             width: MediaQuery.of(context).size.width * 0.3,
                  //                             decoration: BoxDecoration(
                  //                               borderRadius: BorderRadius.circular(10),
                  //                               border: controller.pickImageSelected.value
                  //                                   ? null
                  //                                   : Border.all(
                  //                                   color: AppTheme.liteWhite, width: 3),
                  //                             ),
                  //                             child: Material(
                  //                               color: AppTheme.liteWhite,
                  //                               child: InkWell(
                  //                                 onTap: () {
                  //                                   Get.to(
                  //                                     ImagePick(
                  //                                       isMultiple: true,
                  //                                       title: "Profile ",
                  //                                       onClose: () => Get.back(),
                  //                                       onSave: (List<PickedImage> images) {
                  //                                         if (images.isNotEmpty) {
                  //                                           controller.itemImagePick.value =
                  //                                           images[0];
                  //                                           controller.pickImageSelected.value =
                  //                                           true;
                  //                                         }
                  //                                         Get.back();
                  //                                       },
                  //                                     ),
                  //                                   );
                  //                                 },
                  //                                 child: Stack(
                  //                                   children: [
                  //                                     if (controller.itemImagePick.value !=
                  //                                         null && controller.itemImagePick.value.imagePath !=
                  //                                         null)
                  //                                       Image.file(
                  //                                         controller
                  //                                             .itemImagePick!.value!.imagePath,
                  //                                         width: 150,
                  //                                         height: 150,
                  //                                         fit: BoxFit.cover,
                  //                                       ),
                  //                                     if (controller.itemImagePick.value ==
                  //                                         null || controller.itemImagePick.value.imagePath ==
                  //                                         null)
                  //                                       const Center(
                  //                                         child: Column(
                  //                                           mainAxisAlignment:
                  //                                           MainAxisAlignment.center,
                  //                                           children: [
                  //                                             Icon(
                  //                                               Icons.image,
                  //                                               size: 50,
                  //                                             ),
                  //                                             Text(
                  //                                               "Bill",
                  //                                               style: TextStyle(
                  //                                                   fontSize: 15,
                  //                                                   fontWeight: FontWeight.w600,
                  //                                                   color: Colors.black),
                  //                                             ),
                  //                                           ],
                  //                                         ),
                  //                                       ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         GestureDetector(
                  //                           onTapDown: (TapDownDetails details) {
                  //                             controller.startRecord();
                  //                             Fluttertoast.showToast(
                  //                               msg: "Record Starting",
                  //                               toastLength: Toast.LENGTH_SHORT,
                  //                               gravity: ToastGravity.BOTTOM,
                  //                               backgroundColor: Colors.black,
                  //                               textColor: Colors.white,
                  //                             );
                  //                           },
                  //                           onTapUp: (TapUpDetails details) {
                  //                             controller.stopRecord();
                  //                             controller.isAudio.value = true;
                  //                             Fluttertoast.showToast(
                  //                               msg: "Record Stop",
                  //                               toastLength: Toast.LENGTH_SHORT,
                  //                               gravity: ToastGravity.BOTTOM,
                  //                               backgroundColor: Colors.black,
                  //                               textColor: Colors.white,
                  //                             );
                  //                           },
                  //                           child: Card(
                  //                             elevation: 2,
                  //                             shape: RoundedRectangleBorder(
                  //                               borderRadius: BorderRadius.circular(10),
                  //                               side: BorderSide(color: AppTheme.liteWhite),
                  //                             ),
                  //                             child: Container(
                  //                               height: MediaQuery.of(context).size.height * 0.12,
                  //                               width: MediaQuery.of(context).size.width * 0.3,
                  //                               decoration: BoxDecoration(
                  //                                   color: AppTheme.liteWhite,
                  //                                   borderRadius: BorderRadius.circular(10),
                  //                                   boxShadow: const [
                  //                                     BoxShadow(
                  //                                         color: AppTheme.liteWhite,
                  //                                         spreadRadius: 0,
                  //                                         blurRadius: 2)
                  //                                   ]),
                  //                               child: const Column(
                  //                                 mainAxisAlignment: MainAxisAlignment.center,
                  //                                 children: [
                  //                                   Icon(
                  //                                     Icons.mic,
                  //                                     size: 40,
                  //                                   ),
                  //                                   Text(
                  //                                     "Hold",
                  //                                     style: TextStyle(
                  //                                         fontSize: 15,
                  //                                         fontWeight: FontWeight.w600,
                  //                                         color: Colors.black),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 20,
                  //                 ),
                  //                 Obx(
                  //                       () => Visibility(
                  //                     visible: controller.isAudio.value,
                  //                     child: Container(
                  //                       width: 275,
                  //                       height: 70,
                  //                       decoration: BoxDecoration(
                  //                           color: AppTheme.bgBlue,
                  //                           borderRadius: BorderRadius.circular(15)),
                  //                       child: Row(
                  //                         children: [
                  //                           SizedBox(width: 15),
                  //                           StreamBuilder<PlayerState>(
                  //                               stream: controller.audioPlayer.playerStateStream,
                  //                               builder: (context, snapshot) {
                  //                                 final playerState = snapshot.data;
                  //                                 final processingState =
                  //                                     playerState?.processingState;
                  //                                 final playing = playerState?.playing;
                  //                                 if (!(playing ?? false)) {
                  //                                   return IconButton(
                  //                                       onPressed: () {
                  //                                         controller.play();
                  //                                       },
                  //                                       icon: Icon(
                  //                                         Icons.play_arrow_rounded,
                  //                                         size: 30,
                  //                                         color: Colors.black,
                  //                                       ));
                  //                                 } else if (processingState !=
                  //                                     ProcessingState.completed) {
                  //                                   return IconButton(
                  //                                       onPressed: controller.audioPlayer.pause,
                  //                                       icon: Icon(Icons.pause_rounded,
                  //                                           size: 30, color: Colors.black));
                  //                                 }
                  //                                 return Icon(Icons.play_arrow_rounded);
                  //                               }),
                  //                           SizedBox(
                  //                             width: 20,
                  //                           ),
                  //                           Container(
                  //                             margin: EdgeInsets.only(top: 15),
                  //                             width: 165,
                  //                             child: StreamBuilder(
                  //                                 stream: _positionDataStream,
                  //                                 builder: (context, snapshot) {
                  //                                   final positionData = snapshot.data;
                  //                                   return ProgressBar(
                  //                                     progress:
                  //                                     positionData?.position ?? Duration.zero,
                  //                                     buffered: positionData?.bufferedPosition ??
                  //                                         Duration.zero,
                  //                                     total:
                  //                                     positionData?.duration ?? Duration.zero,
                  //                                     onSeek: controller.audioPlayer.seek,
                  //                                   );
                  //                                 }),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Button2(
                  //                       widthFactor: 0.28,
                  //                       heightFactor: 0.04,
                  //                       onPressed: () {
                  //                         Get.back();
                  //                       },
                  //                       child: Text(
                  //                         "Cancel",
                  //                         style: GoogleFonts.lato(
                  //                             color: Colors.white,
                  //                             fontSize: 10,
                  //                             fontWeight:
                  //                             FontWeight.w500),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       width: 10,
                  //                     ),
                  //                     Button(
                  //                       widthFactor: 0.28,
                  //                       heightFactor: 0.04,
                  //                       onPressed: () {
                  //                         controller.updateCompleteTask("Completed");
                  //                         Get.back();
                  //                       },
                  //                       child: Text(
                  //                         "Yes",
                  //                         style: GoogleFonts.lato(
                  //                             color: Colors.white,
                  //                             fontSize: 10,
                  //                             fontWeight:
                  //                             FontWeight.w500),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             );
                  //           },
                  //         );
                  //       },
                  //       child: Text(
                  //         "Completed",
                  //         style: GoogleFonts.lato(
                  //             color: Colors.white,
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.w500),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
