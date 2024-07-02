import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/Controller/AttendanceScreenController.dart';
import 'package:igreen_flutter/forms/theme.dart';
import 'package:intl/intl.dart';
import 'GpsLocationScreen.dart';

class AttendanceScreen extends GetView<AttendanceScreeController> {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AttendanceScreeController controller = Get.put(AttendanceScreeController());
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
          title: Text(
            "Attendance",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ) ,
          centerTitle: true,
          actions: [
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
              width: width * 0.3,
              height: height * 0.1,
            ),
          ],
          // flexibleSpace: Container(
          //   height: 80,
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(0.0),
          //       bottomRight: Radius.circular(0.0),
          //     ),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Container(
          //         child: InkWell(
          //             onTap: () {
          //               Get.back();
          //             },
          //             child: const Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 15),
          //               child: Column(
          //                 children: [
          //                   SizedBox(
          //                     height: 23,
          //                   ),
          //                   Icon(
          //                     Icons.arrow_back,
          //                     color: Colors.black,
          //                   ),
          //                 ],
          //               ),
          //             )),
          //       ),
          //       SizedBox(
          //         width: MediaQuery.of(context).size.width * 0.21,
          //       ),
          //       Text(
          //         "Attendance",
          //         style: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.w600,
          //             color: Colors.black),
          //       ),
          //       Spacer(),
          //       Image.asset(
          //         "assets/images/logo.png",
          //         fit: BoxFit.contain,
          //         width: width * 0.3,
          //         height: height * 0.1,
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
      body: Obx(
            () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: LiveTimeDisplay(),
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 90),
                      width: 160,
                      height: 160,
                      child: CircularProgressIndicator(
                        value: 1.0, // Sets the progress value (0.0 to 1.0)
                        //backgroundColor: Colors.white, // Sets the background color
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ), // Sets the progress color
                        strokeWidth: 17.0,
                      ),
                    ),
                    Positioned(
                        top: 95,
                        left: 5,
                        child: GestureDetector(
                          onTap: () {
                            controller.attendance();
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: (controller.statusValues == null ||
                                    controller.statusValues!
                                        .status ==
                                        null ||
                                    controller
                                        .statusValues!
                                        .status!
                                        .isEmpty ||
                                    controller.statusValues!
                                        .status ==
                                        "Check Out")
                                    ? AppTheme.secondaryColor
                                    : AppTheme.buttonBlueColor,
                                borderRadius: BorderRadius.circular(150)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 33,
                                ),
                                Center(
                                    child: Icon(Icons.fingerprint,
                                        color: AppTheme.litePink, size: 84)),
                                (controller.statusValues == null ||
                                    controller.statusValues!
                                        .status ==
                                        null ||
                                    controller
                                        .statusValues!
                                        .status!
                                        .isEmpty ||
                                    controller.statusValues!
                                        .status ==
                                        "Check Out")
                                    ?
                                const Text(
                                  "Check in",
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 0.1,
                                      fontSize: 17,
                                      fontWeight:
                                      FontWeight.w500),
                                )
                                    : const Text(
                                  "Check out",
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 0.1,
                                      fontSize: 17,
                                      fontWeight:
                                      FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
                //  LocationDisplay(),
              ],
            ),
      ),
    ));
  }
}

class LiveTimeDisplay extends StatefulWidget {
  @override
  _LiveTimeDisplayState createState() => _LiveTimeDisplayState();
}

class _LiveTimeDisplayState extends State<LiveTimeDisplay> {
  late Timer _timer;
  late String _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = _formatTime(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), _updateTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    setState(() {
      _currentTime = _formatTime(DateTime.now());
    });
  }

  String _formatTime(DateTime time) {
    return DateFormat('h:mm:ss a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTime,
      style: GoogleFonts.poppins(
          color: Colors.black,
          letterSpacing: 0.1,
          fontSize: 25,
          fontWeight: FontWeight.w500),
    );
  }
}
