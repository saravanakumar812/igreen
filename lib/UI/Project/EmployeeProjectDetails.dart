import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/EmployeeProjectDetailsController.dart';
import '../../Utils/image_picker.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:just_audio/just_audio.dart';
import 'package:intl/intl.dart';

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

class EmployeeProjectDetails extends GetView<EmployeeProjectDetailsController> {
  const EmployeeProjectDetails({super.key});

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          controller.audioPlayer.positionStream,
          controller.audioPlayer.bufferedPositionStream,
          controller.audioPlayer.durationStream,
          (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration!));

  Future<void> startDate(BuildContext context) async {
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
      controller.startDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> endDate(BuildContext context) async {
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
      controller.endDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    EmployeeProjectDetailsController controller =
        Get.put(EmployeeProjectDetailsController());
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
                    width: 50,
                  ),
                  Text(
                    "Project Details",
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
                      width: width * 0.3,
                      height: height * 0.1,
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.grey)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Project Details ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name ",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          controller.userDataProvider.getFactoryProjectData!
                              .customerName
                              .toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Company Name ",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          controller.userDataProvider.getFactoryProjectData!
                              .companyName
                              .toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address ",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          controller.userDataProvider.getFactoryProjectData!
                              .companyAddress
                              .toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mobile No :",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          controller
                              .userDataProvider.getFactoryProjectData!.mobileNum
                              .toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "GST ",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          controller.userDataProvider.getFactoryProjectData!.gST
                              .toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              TextInput(
                // controller: controller.subCategory1Controller,
                height: 100,
                label: "",
                onPressed: () {
                  if (controller.isSelected.value) {
                    controller.isSelected.value = false;
                  } else {
                    controller.isSelected.value = true;
                  }
                },
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Team Updates",
                obscureText: true,
                isReadOnly: true,
                onTextChange: (String) {},
              ),
              Obx(
                () => controller.isLoading.value
                    ? Visibility(
                        visible: controller.isSelected.value,
                        child: Center(child: CircularProgressIndicator()))
                    : controller.completedData!.isNotEmpty
                        ? SingleChildScrollView(
                            child: RefreshIndicator(
                              onRefresh: controller.refreshData,
                              child: Column(
                                children: [
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              10,
                                      child: Obx(
                                        () => ListView.builder(
                                          padding: EdgeInsets.only(bottom: 10),
                                          itemCount:
                                              controller.completedData.length,
                                          itemBuilder: (context, index) {
                                            return updates(context, index);
                                          },
                                        ),
                                      )),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Updates ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
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
                  TextInput(
                    height: 100,
                    label: "Select Type",
                    onPressed: () {
                      if (controller.updateDropDown.value) {
                        controller.updateDropDown.value = false;
                      } else {
                        controller.updateDropDown.value = true;
                      }
                    },
                    controller: controller.updateController,
                    textInputType: TextInputType.number,
                    textColor: Color(0xCC252525),
                    obscureText: true,
                    isReadOnly: true,
                    hintText: "Select Type",
                    onTextChange: (string) {},
                  ),
                  controller.updateValues!.isNotEmpty
                      ? Obx(() => Visibility(
                            visible: controller.updateDropDown.value,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 25,
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
                                      controller.updateValues.length,
                                      (index) {
                                        return Container(
                                          child: Column(
                                            children: [
                                              TextInput(
                                                onPressed: () {
                                                  controller.updateController
                                                          .text =
                                                      controller
                                                          .updateValues[index];
                                                  controller.updateDropDown
                                                      .value = false;
                                                  controller.completeVisible
                                                      .value = false;

                                                  if (controller
                                                          .updateController
                                                          .text ==
                                                      'Complete Update') {
                                                    controller.completeVisible
                                                        .value = true;
                                                  } else {}
                                                },
                                                margin: false,
                                                isSelected: controller
                                                        .updateController
                                                        .text ==
                                                    controller
                                                        .updateValues[index]!,
                                                label: "",
                                                isEntryField: false,
                                                textInputType:
                                                    TextInputType.text,
                                                textColor: Color(0xCC234345),
                                                hintText: controller
                                                    .updateValues[index],
                                                onTextChange: (String) {},
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Visibility(
                                                visible: controller
                                                        .updateValues.length !=
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
                          ))
                      : Center(
                          child: Text('NO DATA',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                        () => Card(
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
                                  controller.imagePathFromData.value,
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
                height: 20,
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
                         //   SizedBox(width: 20),
                            StreamBuilder<PlayerState>(
                                stream: controller.audioPlayer.playerStateStream,
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
                                      progress:
                                          positionData?.position ?? Duration.zero,
                                      buffered: positionData?.bufferedPosition ??
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
              SizedBox(
                height: 20,
              ),
              Obx(
                () => Visibility(
                  visible: controller.completeVisible.value,
                  child: Column(
                    children: [
                      Row(children: [
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          width: (width / 2) - 10,
                          child: TextInput(
                            onPressed: () {
                              startDate(context);
                            },
                            controller: controller.startDateController,
                            height: 100,
                            isReadOnly: true,
                            label: "Start Date",
                            onTextChange: (text) {},
                            textInputType: TextInputType.phone,
                            textColor: Color(0xCC252525),
                            hintText: "Select Start Date",
                            sufficIcon: Icon(
                              Icons.calendar_month,
                            ),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Container(
                          width: (width / 2) - 10,
                          child: TextInput(
                              onPressed: () {
                                endDate(context);
                              },
                              controller: controller.endDateController,
                              height: 100,
                              isReadOnly: true,
                              label: "End Date",
                              onTextChange: (text) {},
                              textInputType: TextInputType.phone,
                              textColor: Color(0xCC252525),
                              hintText: "Select End Date",
                              sufficIcon: Icon(
                                Icons.calendar_month,
                              ),
                              obscureText: true),
                        ),
                      ]),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Button(
                    widthFactor: 0.9,
                    heightFactor: 0.06,
                    onPressed: () {
                      if (controller.updateController.text == 'Daily Update') {
                        controller.factoryUpdates();
                      } else {
                        controller.factoryCompletion();
                      }
                    },
                    child: Text("SUBMIT",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget updates(BuildContext context, int index) {
    EmployeeProjectDetailsController controller =
        Get.put(EmployeeProjectDetailsController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.completedData[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.grey)),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Task Details ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Employee Name ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.employeeName.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Updates ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.projectUpdate.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AssignedStartDate ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.assignedStartDate.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AssignedEndDate :",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.assignedEndDate.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Team CompleteDate ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.endDate.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
