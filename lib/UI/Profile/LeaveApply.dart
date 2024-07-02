import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/LeaveApplyController.dart';
import '../../Utils/image_picker.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:just_audio/just_audio.dart';

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

class LeaveApply extends GetView<LeaveApplyController> {
  const LeaveApply({super.key});

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
      controller.fromDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> selectDateTwo(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
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
      controller.toDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    LeaveApplyController controller = Get.put(LeaveApplyController());
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
                    'Leave Apply',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextInput(
                height: 100,
                label: "Select Type",
                onPressed: () {
                  if (controller.leaveReasonDropDown.value) {
                    controller.leaveReasonDropDown.value = false;
                  } else {
                    controller.leaveReasonDropDown.value = true;
                  }
                },
                controller: controller.leaveTypeController,
                textInputType: TextInputType.number,
                textColor: Color(0xCC252525),
                obscureText: true,
                isReadOnly: true,
                hintText: "Select Type",
                onTextChange: (string) {},
              ),
              Obx(() => Visibility(
                    visible: controller.leaveReasonDropDown.value,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                        padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color:
                              Colors.white, // Set the desired background color
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: List.generate(
                              controller.reason.length,
                              (index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      TextInput(
                                        onPressed: () {
                                          controller.leaveTypeController.text =
                                              controller.reason[index];
                                          controller.leaveReasonDropDown.value =
                                              false;
                                        },
                                        margin: false,
                                        isSelected: controller
                                                .leaveTypeController.text ==
                                            controller.reason[index]!,
                                        label: "",
                                        isEntryField: false,
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC234345),
                                        hintText: controller.reason[index],
                                        onTextChange: (String) {},
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Visibility(
                                        visible: controller.reason.length !=
                                            index + 1,
                                        child: Container(
                                          height: 1,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
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
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text('Reason With Explain',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: TextField(
                  maxLines: 3,
                  controller: controller.messageController,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.grey),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Enter Your Message',
                    labelText: 'Message',
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: AppTheme.grey // Choose the desired alignment
                        ),
                    labelStyle: TextStyle(
                        fontSize: 14,
                        color: AppTheme.grey // Choose the desired alignment
                        ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: (width / 2) - 10,
                  child: TextInput(
                    onPressed: () {
                      selectDate(context);
                    },
                    controller: controller.fromDateController,
                    height: 100,
                    isReadOnly: true,
                    label: "From Date",
                    onTextChange: (text) {},
                    textInputType: TextInputType.phone,
                    textColor: Color(0xCC252525),
                    hintText: "Select From Date",
                    sufficIcon: Icon(
                      Icons.calendar_month,
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
                Container(
                  width: (width / 2) - 10,
                  child: TextInput(
                      onPressed: () {
                        selectDateTwo(context);
                      },
                      controller: controller.toDateController,
                      height: 100,
                      isReadOnly: true,
                      label: "To Date",
                      onTextChange: (text) {},
                      textInputType: TextInputType.phone,
                      textColor: Color(0xCC252525),
                      hintText: "Select To Date",
                      sufficIcon: Icon(
                        Icons.calendar_month,
                      ),
                      obscureText: true),
                ),
              ]),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: AppTheme.liteWhite),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.3,
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
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Obx(
                () => Visibility(
                  visible: controller.isAudio.value,
                  child:   Column(

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
              SizedBox(
                height: 30,
              ),
              Center(
                child: Button(
                    widthFactor: 0.9,
                    heightFactor: 0.06,
                    onPressed: () {
                      controller.applyLeave();
                    },
                    child: Text('Submit',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w600))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
