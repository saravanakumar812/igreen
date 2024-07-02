import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/routes/app_routes.dart';

import '../../Controller/FinanceHomeController.dart';
import '../../forms/theme.dart';

class FinanceHome extends GetView<FinanceHomeController> {
  const FinanceHome({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    FinanceHomeController controller = Get.put(FinanceHomeController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.profileColor,
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
                    width: MediaQuery.of(context).size.height * 0.11,
                  ),
                  Text(
                    'Finance Home',
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
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: AppTheme.redShade1),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.paySlip.toName);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          color: AppTheme.redShade1,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.redShade1,
                              spreadRadius: 0,
                              blurRadius: 2,
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/payslip.png",
                            fit: BoxFit.contain,
                            width: width * 0.2,
                            height: height * 0.05,
                          ),
                          Text(
                            "PaySlip",
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
                    Get.toNamed(AppRoutes.salaryScreen.toName);
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppTheme.corrosion),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          color: AppTheme.corrosion,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppTheme.corrosion,
                                spreadRadius: 0,
                                blurRadius: 2)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/salary.png",
                            fit: BoxFit.contain,
                            width: width * 0.2,
                            height: height * 0.05,
                          ),
                          Text(
                            "Salary",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                letterSpacing: 0.1,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: AppTheme.liteBlue97),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.earningScreen.toName);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          color: AppTheme.liteBlue97,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.liteBlue97,
                              spreadRadius: 0,
                              blurRadius: 2,
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/earning.png",
                            fit: BoxFit.contain,
                            width: width * 0.2,
                            height: height * 0.05,
                          ),
                          Text(
                            "Earning",
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
            ),
          ],
        ),
      ),
    );
  }
}
