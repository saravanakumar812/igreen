import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/Controller/AnnouncementController.dart';
import 'package:igreen_flutter/UI/Announcement/Events.dart';
import '../../forms/theme.dart';
import 'CalanderView.dart';
import 'Reminder.dart';

class AnnouncementPage extends GetView<AnnouncementController> {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AnnouncementController controller = Get.put(AnnouncementController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.liteWhite,
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
                          Get.back();
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
                    "Announcement ",
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
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              LeaveEas(context),
              SizedBox(
                height: 30,
              ),
              // FeedBacks(context),
              // SizedBox(
              //   height: 30,
              // ),
              AttendanceHis(context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget LeaveEas(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  AnnouncementController controller = Get.put(AnnouncementController());

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      GestureDetector(
        onTap: () {
          Get.to(Events());
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppTheme.lite),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
                color: AppTheme.lite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: AppTheme.lite, spreadRadius: 0, blurRadius: 2)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/icons8_todo_list_48.png",
                  fit: BoxFit.contain,
                  width: width * 0.3,
                  height: height * 0.07,
                ),
                Text(
                  " Events",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      letterSpacing: 0.1,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.to(Reminder());
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppTheme.lightOrange),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
                color: AppTheme.lightOrange,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: AppTheme.lightOrange,
                      spreadRadius: 0,
                      blurRadius: 2)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/escalation.png",
                  fit: BoxFit.contain,
                  width: width * 0.3,
                  height: height * 0.07,
                ),
                Text(
                  "Reminder",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      letterSpacing: 0.1,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget AttendanceHis(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      GestureDetector(
        onTap: () {
          Get.to(CalenderView());
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // side: BorderSide(color: AppTheme.lite),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
                color: AppTheme.lite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: AppTheme.lite, spreadRadius: 0, blurRadius: 2)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/leave_history.JPG",
                  fit: BoxFit.contain,
                  width: width * 0.3,
                  height: height * 0.07,
                ),
                Text(
                  "Calender",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      letterSpacing: 0.1,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
