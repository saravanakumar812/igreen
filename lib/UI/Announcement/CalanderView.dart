import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:igreen_flutter/Controller/CalenderController.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../forms/theme.dart';

class CalenderView extends GetView<CalenderController> {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final DateRangePickerController controllerDate =
    DateRangePickerController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    CalenderController controller = Get.put(CalenderController());

    return SafeArea(
        child: Scaffold(
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
                      "Calender ",
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
       //    body:CalendarDatePicker2(
       //      config: CalendarDatePicker2Config(),
       //      value: controller.leaveDateTime,9
       // //     onValueChanged: (List<DateTime?> dates) => controller.leaveDateTime = dates,
       //    )));

          body: SingleChildScrollView(
              child: Column(
                  children: [

                    Card(
                      margin: const EdgeInsets.all(30),
                      elevation: 10,
                      child: Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: SfDateRangePicker(
                          selectionColor: AppTheme.screenBackground,
                          selectionTextStyle:
                          const TextStyle(fontSize: 15, color: Colors.black),
                          rangeTextStyle: const TextStyle(overflow: TextOverflow.ellipsis),
                          viewSpacing: 20,
                          view: DateRangePickerView.month,

                          headerHeight: 100,
                          monthViewSettings: DateRangePickerMonthViewSettings(
                            specialDates: controller.leaveDateTime,
                          ),
                          monthCellStyle: const DateRangePickerMonthCellStyle(
                            cellDecoration: BoxDecoration(shape: BoxShape.circle),
                            textStyle: TextStyle(fontSize: 15, color: Colors.black),
                            todayTextStyle: TextStyle(fontSize: 15, color: Colors.green),
                            weekendTextStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                            specialDatesTextStyle:
                            TextStyle(fontSize: 15, color: Colors.red),
                          ),
                          //cellBuilder:cellBuilder ,
                        ),
                      ),
                      // Container(
                      //   width: width,
                      //   height: 52,
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Container(
                      //             width: width * 0.7,
                      //             height: 50,
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Container(
                      //                   child:Text(
                      //                     '10 July 2023',
                      //                     style: TextStyle(
                      //                         fontSize: 16,
                      //                         color: Colors.black,
                      //                         fontWeight: FontWeight.bold),
                      //                   ),
                      //                 ),Container(
                      //                   child: Row(
                      //                     children: [
                      //                     Text(
                      //                     'In 10.00PM',
                      //                     style: TextStyle(
                      //                         fontSize: 12,
                      //                         color: Colors.black,
                      //                         fontWeight: FontWeight.bold),
                      //                   ),
                      //
                      //
                      //
                      //                       SizedBox(
                      //                         width: 20,
                      //                       ),
                      //
                      //                   Text(
                      //                     'Out 10.00PM',
                      //                     style: TextStyle(
                      //                         fontSize: 12,
                      //                         color: Colors.black,
                      //                         fontWeight: FontWeight.bold),
                      //                   ),
                      //
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //           Container(
                      //             width: width * 0.26,
                      //             height: 50,
                      //             child:   Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               crossAxisAlignment: CrossAxisAlignment.center,
                      //               children: [
                      //                 Container(
                      //                   child: Text(
                      //             'Hours',
                      //               style: TextStyle(
                      //                   fontSize: 12,
                      //                   color: Colors.black,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //
                      //                 ),
                      //               ],
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //       Container(
                      //         height: 2,
                      //         width: width,
                      //         color: Colors.grey.withOpacity(0.8),
                      //       ),
                      //     ],
                      //   ),
                      // )


                    )   ]))));





          // body:  Obx((){
          //   return controller.imageFile.value.path.isEmpty ?
          //   Column(
          //     children: [
          //       TextButton(onPressed: (){
          //         controller.pickedGalleryImage();
          //       }, child:Text("pick Gallery image",  style: TextStyle(
          //           fontSize: 15,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.black),)),
          //       SizedBox(height: 20,),
          //       TextButton(onPressed: (){
          //         controller.pickedCameraImage();
          //       }, child:Text("pick camera image", style: TextStyle(
          //           fontSize: 15,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.black),))
          //     ],
          //   ) : Container(
          //       child: ProImageEditor.file(File(controller.imageFile.value.path),
          //         onImageEditingComplete: (imageBytes) async{
          //           //     save image
          //         },
          //       ));
          // })




  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:local_auth/local_auth.dart';
//
// class FingerprintAuth extends StatefulWidget {
//   const FingerprintAuth({Key? key}) : super(key: key);
//
//   @override
//   _FingerprintAuthState createState() => _FingerprintAuthState();
// }
//
// class _FingerprintAuthState extends State<FingerprintAuth> {
//   final auth = LocalAuthentication();
//   String authorized = " not authorized";
//   bool canCheckBiometric = false;
//   late List<BiometricType> availableBiometric;
//   bool _isAuthenticating = false;
//
//   Future<void> _authenticate() async {
//     bool authenticated = false;
//
//     try {
//       authenticated = await auth.authenticateWithBiometrics(
//           localizedReason: "Scan your finger to authenticate",
//           useErrorDialogs: true,
//           stickyAuth: true);
//     } on PlatformException catch (e) {
//       print(e);
//     }
//
//     setState(() {
//       authorized =
//       authenticated ? "Authorized success" : "Failed to authenticate";
//       print(authorized);
//
//         Fluttertoast.showToast(
//           msg: authorized,
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.black,
//           textColor: Colors.white,
//         );
//         // Get.offNamed(AppRoutes.WagesSummaryScreen.toName);
//
//     });
//   }
//
//   Future<void> _checkBiometric() async {
//     bool canCheckBiometric = false;
//
//     try {
//       canCheckBiometric = await auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       print(e);
//     }
//
//     if (!mounted) return;
//
//     setState(() {
//       canCheckBiometric = canCheckBiometric;
//     });
//   }
//
//   Future _getAvailableBiometric() async {
//     List<BiometricType> availableBiometric = [];
//
//     try {
//       availableBiometric = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       print(e);
//     }
//
//     setState(() {
//       availableBiometric = availableBiometric;
//     });
//   }
//
//   @override
//   void initState() {
//     _checkBiometric();
//     _getAvailableBiometric();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey.shade600,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Center(
//               child: Text(
//                 "Login",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 48.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: 50.0),
//               child: Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.symmetric(vertical: 15.0),
//                     child: const Text(
//                       "Authenticate using your fingerprint instead of your password",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white, height: 1.5),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(vertical: 15.0),
//                     width: double.infinity,
//                     child: FloatingActionButton(
//                       onPressed: _authenticate,
//                       elevation: 0.0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       child: const Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 24.0, vertical: 14.0),
//                         child: Text(
//                           "Authenticate",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Container(
//                     child:  ElevatedButton(
//                       onPressed: _authenticate,
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           // Text(_isAuthenticating
//                           //     ? 'Cancel'
//                           //     : 'Authenticate: biometrics only'),
//                           const Icon(Icons.fingerprint),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }







