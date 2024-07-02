import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/GriVanceCreateScreenController.dart';
import '../../Utils/image_picker.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
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

class GriVanceCreateScreen extends GetView<GriVanceCreateScreenController> {
  const GriVanceCreateScreen({super.key});

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
    GriVanceCreateScreenController controller =
        Get.put(GriVanceCreateScreenController());
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
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Text(
                    'Escalation Create',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
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
                label: "Select Employee",
                onPressed: () {
                  if (controller.selectPerson.value) {
                    controller.selectPerson.value = false;
                  } else {
                    controller.selectPerson.value = true;
                  }
                },
                controller: controller.selectPersonController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Select Employee ",
                obscureText: true,
                isReadOnly: true,
                onTextChange: (String) {},
              ),
              Obx(() => Visibility(
                    visible: controller.selectPerson.value,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                      padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.inputBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        //color: Colors.white, // Set the desired background
                      ),
                      // height: height * 9.190,
                      child: IntrinsicHeight(
                        child: Column(
                          children: List.generate(
                            controller.userData.length,
                            (index) {
                              return Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Obx(
                                      () => Row(
                                        children: [
                                          Container(
                                            width: width * 0.5,
                                            child: TextInput(
                                              onPressed: () {
                                                controller
                                                        .selectPersonController
                                                        .text =
                                                    controller.userData[index]
                                                        .employeeName!;
                                                controller.selectPerson.value =
                                                    false;
                                              },
                                              margin: false,
                                              isSelected: controller
                                                      .selectPersonController
                                                      .text ==
                                                  controller.userData[index]
                                                      .employeeName,
                                              label: "",
                                              isEntryField: false,
                                              textInputType: TextInputType.text,
                                              textColor: Color(0xCC234345),
                                              hintText: controller
                                                  .userData[index].employeeName,
                                              obscureText: true,
                                              onTextChange: (String) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Visibility(
                                        visible: controller.userData.length !=
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
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text('Message',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                    () => Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: AppTheme.liteWhite),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: controller.pickImageSelected.value
                              ? null
                              : Border.all(color: AppTheme.liteWhite, width: 3),
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
                                      controller.pickImageSelected.value = true;
                                      // controller.clearImage();
                                    }
                                    Get.back();
                                  },
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                if (controller.itemImagePick.value != null &&
                                    controller.itemImagePick.value.imagePath !=
                                        null)
                                  Image.file(
                                    controller.itemImagePick!.value!.imagePath,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                if (controller.itemImagePick.value == null ||
                                    controller.itemImagePick.value.imagePath ==
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
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Obx(
                () => Visibility(
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
                      controller.addEscalationForm();
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
