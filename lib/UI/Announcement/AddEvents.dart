import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:igreen_flutter/forms/theme.dart';

import '../../Controller/AddEventsController.dart';

class AddEvents extends GetView<AddEventController> {
  const AddEvents({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                        "Add Events ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                        width: width * 0.3,
                        height: height * 0.1,
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
                                                "Title :",
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
                                                "${controller.userDataProvider.getEventData!.title.toString() ?? 0}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Container(
                                        //       margin: EdgeInsets.only(
                                        //         left: 20,
                                        //         top: 20,
                                        //       ),
                                        //       child: Text(
                                        //         "Employee Name:",
                                        //         style: GoogleFonts.poppins(
                                        //             color: Colors.black,
                                        //             fontSize: 15,
                                        //             fontWeight:
                                        //                 FontWeight.w600),
                                        //       ),
                                        //     ),
                                        //     Container(
                                        //       margin: EdgeInsets.only(
                                        //         left: 20,
                                        //         top: 20,
                                        //       ),
                                        //       child: Text(
                                        //         "${controller.userDataProvider.getEventData!.employeeName.toString() ?? 0}",
                                        //         style: GoogleFonts.poppins(
                                        //             color: Colors.black,
                                        //             fontSize: 15,
                                        //             fontWeight:
                                        //                 FontWeight.w500),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                top: 20,
                                              ),
                                              child: Text(
                                                "Description :",
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
                                                "${controller.userDataProvider.getEventData!.descriptions.toString() ?? 0}",
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
                                                "${controller.userDataProvider.getEventData!.startdate.toString() ?? 0}",
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
                                                "${controller.userDataProvider.getEventData!.enddate.toString() ?? 0}",
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
                                                "Start Time :",
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
                                                "${controller.userDataProvider.getEventData!.startTime.toString() ?? 0}",
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
                                                "End Time:",
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
                                                "${controller.userDataProvider.getEventData!.endTime.toString() ?? 0}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
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
}

Widget reviewList(BuildContext context, int index) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  AddEventController controller = Get.put(AddEventController());
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.bgPink,
        ),
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "Message",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            letterSpacing: 0.1,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        //top: 20,
                      ),
                      child: Text(
                        controller.eventData[index].descriptions.toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            letterSpacing: 0.1,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      height: 2,
                      width: width,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      "Date",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          letterSpacing: 0.1,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      //top: 20,
                    ),
                    child: Text(
                      controller.eventData[index].startdate.toString(),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          letterSpacing: 0.1,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ]),
      )
    ],
  );
}
