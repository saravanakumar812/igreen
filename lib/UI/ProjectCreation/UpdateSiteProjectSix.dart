// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../Controller/UpdateSiteSixController.dart';
// import '../../forms/forms.dart';
// import '../../forms/theme.dart';
// import 'UpdateSiteProjectFive.dart';
//
// class Updatesiteprojectsix extends GetView<UpdateSiteSixController> {
//   const Updatesiteprojectsix({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     UpdateSiteSixController controller = Get.put(UpdateSiteSixController());
//
//     return  Scaffold(
//       backgroundColor: AppTheme.screenBackground,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding:  EdgeInsets.all(8.0),
//                   child: InkWell(
//                       onTap: (){
//                         Get.off(const Updatesiteprojectfive());
//                       },
//
//                       child: Image.asset("assets/images/backarrow.png")),
//                 ),
//                 Padding(
//                   padding:  EdgeInsets.all(8.0),
//                   child: Image.asset("assets/images/menu.png"),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text("UPDATE SITE PROJECTS",style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16,
//                       color: Colors.black
//                   ),),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: 398,
//                 height: 180,
//
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4)
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 12.0,top: 8.0),
//                           child: Text("Work Order / LOA",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff272727)),),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Remark Test",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//                         SizedBox(
//                             width: 80
//                         ),
//                         Text("Documents",style: TextStyle(
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//
//                         Row(
//                           children: [
//                             Container(
//                               height: 45,
//                               width: 155,
//                               decoration: BoxDecoration(
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(4)),
//
//                                   border:
//                                   Border.all(color: Colors.grey.shade400,width: 1)),
//                               margin:
//                               EdgeInsets.only(top: 8, left: 2, right: 4),
//                               child: GestureDetector(
//                                   onTap: () {
//                                     // pickFile(context);
//                                   },
//                                   child: Container(
//                                     /*margin: EdgeInsets.symmetric(horizontal: 2),*/
//                                     child: Row(
//                                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             controller.pickFile(context);
//                                           },
//                                           child: Container(
//                                             width: 64,
//                                             height: 25,
//
//                                             margin: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                                 color: AppTheme.secondaryColor,
//
//                                                 borderRadius:
//                                                 BorderRadius.all(
//                                                     Radius.circular(4)),
//                                                 border: Border.all(
//                                                     color: Colors.grey.shade400
//                                                 )),
//                                             child: Center(
//                                               child: Text("Choose file",
//                                                   style: GoogleFonts.poppins(
//                                                       color:
//                                                       AppTheme.white,
//                                                       fontSize: 10,
//                                                       fontWeight:
//                                                       FontWeight.w400)),
//                                             ),
//                                           ),
//                                         ),
//                                         Obx(
//                                               () => controller
//                                               .isFileSelected.value &&
//                                               controller.file != null
//                                               ? Row(
//                                             children: [
//                                               Container(
//                                                 width: 60,
//                                                 child: SingleChildScrollView(
//                                                   scrollDirection:
//                                                   Axis.horizontal,
//                                                   child: Text(
//                                                       controller
//                                                           .file!.path
//                                                           .split('/')
//                                                           .last,
//                                                       style: GoogleFonts.poppins(
//                                                           color: AppTheme
//                                                               .appBlack,
//                                                           fontSize: 12,
//                                                           fontWeight:
//                                                           FontWeight
//                                                               .w600)),
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                               : Expanded(
//                                             child: Text(
//                                                 "No file choosen",
//                                                 style:
//                                                 GoogleFonts.poppins(
//                                                     color: Colors
//                                                         .black,
//                                                     fontSize: 8,
//                                                     fontWeight:
//                                                     FontWeight
//                                                         .w600)),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 09),
//                           child: Container(
//                             width: 133,
//                             height: 27,
//                             child: Center(
//                               child: Text(
//                                 "Open Bill Chat Box",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                             decoration: BoxDecoration(
//                               color: AppTheme.secondaryColor,
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(9.0),
//               child: Container(
//                 width: 398,
//                 height: 144,
//
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4)
//                 ),
//                 child: Column(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 12.0,top: 8.0),
//                       child: Row(
//                         children: [
//                           Text("Flow of Bills",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff272727)),)
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Remark Test",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//                         SizedBox(
//                             width: 95
//                         ),
//                         Text("Flow of Bills",style: TextStyle(
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//
//                         Container(
//                           width: 170,
//
//
//                           child: TextInput2(
//                             height: 100,
//                             /* label: "Type",*/
//                             onPressed: () {
//                               // if (controller.rendList.value) {
//                               //   controller.rendList.value = false;
//                               // } else {
//                               //   controller.rendList.value = true;
//                               // }
//                               // controller.rendDetails.clear();
//                               // controller.rendDetails.add('Factory');
//                               // controller.rendDetails.add('Field');
//                             },
//                             //  controller: controller.typeController,
//                             textInputType: TextInputType.number,
//                             textColor: Color(0xCC252525),
//                             obscureText: true,
//                             isReadOnly: true,
//                             hintText: "",
//                             onTextChange: (string) {},
//                           ),
//
//
//                         ),
//                       ],
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(9.0),
//               child: Container(
//                 width: 398,
//                 height: 288,
//
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4)
//                 ),
//                 child: Column(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 12.0,top: 8.0),
//                       child: Row(
//                         children: [
//                           Text("Payment Received",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff272727)),)
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Remark Test",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//                         SizedBox(
//                             width: 95
//                         ),
//                         Text("Payment Received",style: TextStyle(
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Deduction Type",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//                         SizedBox(
//                             width: 72
//                         ),
//                         Text("Deduction amount",style: TextStyle(
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 170,
//
//
//                           child: TextInput2(
//                             height: 100,
//                             /* label: "Type",*/
//                             onPressed: () {
//                               // if (controller.rendList.value) {
//                               //   controller.rendList.value = false;
//                               // } else {
//                               //   controller.rendList.value = true;
//                               // }
//                               // controller.rendDetails.clear();
//                               // controller.rendDetails.add('Factory');
//                               // controller.rendDetails.add('Field');
//                             },
//                             //  controller: controller.typeController,
//                             textInputType: TextInputType.number,
//                             textColor: Color(0xCC252525),
//                             obscureText: true,
//                             isReadOnly: true,
//                             hintText: "",
//                             onTextChange: (string) {},
//                           ),
//
//
//                         ),
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         InkWell(
//                           onTap: (){},
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 9.0),
//                             child: Container(
//                               width: 80,
//                               height: 33,
//                               decoration: BoxDecoration(
//                                   color: AppTheme.secondaryColor,
//                                   borderRadius: BorderRadius.circular(4),
//                                   border: Border.all(width: 1,color: AppTheme.secondaryColor)
//                               ),
//                               child: const Center(child: Text("Add",style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppTheme.white,
//
//
//                               ),)),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(9.0),
//               child: Container(
//                 width: 398,
//                 height: 270,
//
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4)
//                 ),
//                 child: Column(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 12.0,top: 8.0),
//                       child: Row(
//                         children: [
//                           Text("EMD Retention Receivable Data",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff272727)),)
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Remark Text",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//                         SizedBox(
//                             width: 90
//                         ),
//                         Text("Amount",style: TextStyle(
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//
//
//
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//                       ],
//                     ),
//
//                     const Padding(
//                       padding: EdgeInsets.only(left: 12.0,top: 8.0),
//                       child: Row(
//                         children: [
//                           Text("EMD/SD Rentention",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff828282)),)
//                         ],
//                       ),
//                     ),
//
//                     const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Receivable Data",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//                         SizedBox(
//                             width: 75
//                         ),
//                         Text("EMD Documents",style: TextStyle(
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 165,
//                           child: TextInput2(
//                             onPressed: () {
//                               controller.ClosingDate(context);
//                             },
//                             controller: controller.ClosingDateController,
//                             height: 100,
//                             isReadOnly: true,
//                             /* label: "Customer requirement Date",*/
//                             onTextChange: (text) {},
//                             textInputType: TextInputType.phone,
//                             textColor: Color(0xCC252525),
//                             hintText: "mm/dd/yyyy",
//                             sufficIcon: Icon(
//                               Icons.calendar_month,color: AppTheme.secondaryColor,
//                             ),
//                             obscureText: true,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//
//                         Container(
//                           height: 45,
//                           width: 155,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(4)),
//
//                               border:
//                               Border.all(color: Colors.grey.shade400,width: 1)),
//                           margin:
//                           EdgeInsets.only(top: 8, left: 2, right: 4),
//                           child: GestureDetector(
//                               onTap: () {
//                                 // pickFile(context);
//                               },
//                               child: Container(
//                                 /*margin: EdgeInsets.symmetric(horizontal: 2),*/
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         controller.pickFile(context);
//                                       },
//                                       child: Container(
//                                         width: 64,
//                                         height: 25,
//
//                                         margin: EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             color: AppTheme.secondaryColor,
//
//                                             borderRadius:
//                                             BorderRadius.all(
//                                                 Radius.circular(4)),
//                                             border: Border.all(
//                                                 color: Colors.grey.shade400
//                                             )),
//                                         child: Center(
//                                           child: Text("Choose file",
//                                               style: GoogleFonts.poppins(
//                                                   color:
//                                                   AppTheme.white,
//                                                   fontSize: 10,
//                                                   fontWeight:
//                                                   FontWeight.w400)),
//                                         ),
//                                       ),
//                                     ),
//                                     Obx(
//                                           () => controller
//                                           .isFileSelected.value &&
//                                           controller.file != null
//                                           ? Row(
//                                         children: [
//                                           Container(
//                                             width: 60,
//                                             child: SingleChildScrollView(
//                                               scrollDirection:
//                                               Axis.horizontal,
//                                               child: Text(
//                                                   controller
//                                                       .file!.path
//                                                       .split('/')
//                                                       .last,
//                                                   style: GoogleFonts.poppins(
//                                                       color: AppTheme
//                                                           .appBlack,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                       FontWeight
//                                                           .w600)),
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                           : Expanded(
//                                         child: Text(
//                                             "No file choosen",
//                                             style:
//                                             GoogleFonts.poppins(
//                                                 color: Colors
//                                                     .black,
//                                                 fontSize: 8,
//                                                 fontWeight:
//                                                 FontWeight
//                                                     .w600)),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               )),
//                         ),
//                       ],
//                     ),
//
//
//
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(9.0),
//               child: Container(
//                 width: 398,
//                 height: 270,
//
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4)
//                 ),
//                 child: Column(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 12.0,top: 8.0),
//                       child: Row(
//                         children: [
//                           Text("SD Retention Receivable Data",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff272727)),)
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Remark Text",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//                         SizedBox(
//                             width: 90
//                         ),
//                         Text("Amount",style: TextStyle(
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//
//
//
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//                       ],
//                     ),
//
//                     const Padding(
//                       padding: EdgeInsets.only(left: 12.0,top: 8.0),
//                       child: Row(
//                         children: [
//                           Text("EMD/SD Rentention",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff828282)),)
//                         ],
//                       ),
//                     ),
//
//                     const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Receivable Data",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//                         SizedBox(
//                             width: 75
//                         ),
//                         Text("EMD Documents",style: TextStyle(
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 165,
//                           child: TextInput2(
//                             onPressed: () {
//                               controller.ClosingDate(context);
//                             },
//                             controller: controller.ClosingDateController,
//                             height: 100,
//                             isReadOnly: true,
//                             /* label: "Customer requirement Date",*/
//                             onTextChange: (text) {},
//                             textInputType: TextInputType.phone,
//                             textColor: Color(0xCC252525),
//                             hintText: "mm/dd/yyyy",
//                             sufficIcon: Icon(
//                               Icons.calendar_month,color: AppTheme.secondaryColor,
//                             ),
//                             obscureText: true,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//
//                         Container(
//                           height: 45,
//                           width: 155,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(4)),
//
//                               border:
//                               Border.all(color: Colors.grey.shade400,width: 1)),
//                           margin:
//                           EdgeInsets.only(top: 8, left: 2, right: 4),
//                           child: GestureDetector(
//                               onTap: () {
//                                 // pickFile(context);
//                               },
//                               child: Container(
//                                 /*margin: EdgeInsets.symmetric(horizontal: 2),*/
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         controller.pickFile(context);
//                                       },
//                                       child: Container(
//                                         width: 64,
//                                         height: 25,
//
//                                         margin: EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             color: AppTheme.secondaryColor,
//
//                                             borderRadius:
//                                             BorderRadius.all(
//                                                 Radius.circular(4)),
//                                             border: Border.all(
//                                                 color: Colors.grey.shade400
//                                             )),
//                                         child: Center(
//                                           child: Text("Choose file",
//                                               style: GoogleFonts.poppins(
//                                                   color:
//                                                   AppTheme.white,
//                                                   fontSize: 10,
//                                                   fontWeight:
//                                                   FontWeight.w400)),
//                                         ),
//                                       ),
//                                     ),
//                                     Obx(
//                                           () => controller
//                                           .isFileSelected.value &&
//                                           controller.file != null
//                                           ? Row(
//                                         children: [
//                                           Container(
//                                             width: 60,
//                                             child: SingleChildScrollView(
//                                               scrollDirection:
//                                               Axis.horizontal,
//                                               child: Text(
//                                                   controller
//                                                       .file!.path
//                                                       .split('/')
//                                                       .last,
//                                                   style: GoogleFonts.poppins(
//                                                       color: AppTheme
//                                                           .appBlack,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                       FontWeight
//                                                           .w600)),
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                           : Expanded(
//                                         child: Text(
//                                             "No file choosen",
//                                             style:
//                                             GoogleFonts.poppins(
//                                                 color: Colors
//                                                     .black,
//                                                 fontSize: 8,
//                                                 fontWeight:
//                                                 FontWeight
//                                                     .w600)),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               )),
//                         ),
//                       ],
//                     ),
//
//
//
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(9.0),
//               child: Container(
//                 width: 398,
//                 height: 270,
//
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4)
//                 ),
//                 child: Column(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 12.0,top: 8.0),
//                       child: Row(
//                         children: [
//                           Text("Other Retention Receivable Data",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff272727)),)
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Remark Text",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//                         SizedBox(
//                             width: 90
//                         ),
//                         Text("Amount",style: TextStyle(
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//
//
//
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             // controller: controller.ideasController,
//                             //height: 70,
//                             //label: "Ideas",
//                             onPressed: () {},
//                             textInputType: TextInputType.text,
//                             textColor: Color(0xCC252525),
//                             hintText: "",
//                             //obscureText: true,
//
//                             onTextChange: (general) {
//                               // controller.popUpValue.value = true;
//                             },
//                           ),
//                           // decoration: BoxDecoration(
//                           //   color: Colors.white,
//                           //   border: Border.all(color: Colors.grey.shade400,width: 1),
//                           //   borderRadius: BorderRadius.circular(4),
//                           // ),
//
//                         ),
//                       ],
//                     ),
//
//                     const Padding(
//                       padding: EdgeInsets.only(left: 12.0,top: 8.0),
//                       child: Row(
//                         children: [
//                           Text("EMD/SD Rentention",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff828282)),)
//                         ],
//                       ),
//                     ),
//
//                     const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Receivable Data",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//                         SizedBox(
//                             width: 75
//                         ),
//                         Text("EMD Documents",style: TextStyle(
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 165,
//                           child: TextInput2(
//                             onPressed: () {
//                               controller.ClosingDate(context);
//                             },
//                             controller: controller.ClosingDateController,
//                             height: 100,
//                             isReadOnly: true,
//                             /* label: "Customer requirement Date",*/
//                             onTextChange: (text) {},
//                             textInputType: TextInputType.phone,
//                             textColor: Color(0xCC252525),
//                             hintText: "mm/dd/yyyy",
//                             sufficIcon: Icon(
//                               Icons.calendar_month,color: AppTheme.secondaryColor,
//                             ),
//                             obscureText: true,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//
//                         Container(
//                           height: 45,
//                           width: 155,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(4)),
//
//                               border:
//                               Border.all(color: Colors.grey.shade400,width: 1)),
//                           margin:
//                           EdgeInsets.only(top: 8, left: 2, right: 4),
//                           child: GestureDetector(
//                               onTap: () {
//                                 // pickFile(context);
//                               },
//                               child: Container(
//                                 /*margin: EdgeInsets.symmetric(horizontal: 2),*/
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         controller.pickFile(context);
//                                       },
//                                       child: Container(
//                                         width: 64,
//                                         height: 25,
//
//                                         margin: EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             color: AppTheme.secondaryColor,
//
//                                             borderRadius:
//                                             BorderRadius.all(
//                                                 Radius.circular(4)),
//                                             border: Border.all(
//                                                 color: Colors.grey.shade400
//                                             )),
//                                         child: Center(
//                                           child: Text("Choose file",
//                                               style: GoogleFonts.poppins(
//                                                   color:
//                                                   AppTheme.white,
//                                                   fontSize: 10,
//                                                   fontWeight:
//                                                   FontWeight.w400)),
//                                         ),
//                                       ),
//                                     ),
//                                     Obx(
//                                           () => controller
//                                           .isFileSelected.value &&
//                                           controller.file != null
//                                           ? Row(
//                                         children: [
//                                           Container(
//                                             width: 60,
//                                             child: SingleChildScrollView(
//                                               scrollDirection:
//                                               Axis.horizontal,
//                                               child: Text(
//                                                   controller
//                                                       .file!.path
//                                                       .split('/')
//                                                       .last,
//                                                   style: GoogleFonts.poppins(
//                                                       color: AppTheme
//                                                           .appBlack,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                       FontWeight
//                                                           .w600)),
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                           : Expanded(
//                                         child: Text(
//                                             "No file choosen",
//                                             style:
//                                             GoogleFonts.poppins(
//                                                 color: Colors
//                                                     .black,
//                                                 fontSize: 8,
//                                                 fontWeight:
//                                                 FontWeight
//                                                     .w600)),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               )),
//                         ),
//                       ],
//                     ),
//
//
//
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//
//                 InkWell(
//                   onTap: (){},
//                   child: Container(
//                     width: 147,
//                     height: 44,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                         border: Border.all(width: 1,color: AppTheme.secondaryColor)
//                     ),
//                     child: const Center(child: Text("Cancel",style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: AppTheme.secondaryColor,
//
//                     ),)),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 InkWell(
//                   onTap: (){},
//                   child: Container(
//                     width: 147,
//                     height: 44,
//                     decoration: BoxDecoration(
//                         color: AppTheme.secondaryColor,
//                         borderRadius: BorderRadius.circular(4),
//                         border: Border.all(width: 1,color: AppTheme.secondaryColor)
//                     ),
//                     child: const Center(child: Text("Update",style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: AppTheme.white,
//
//
//                     ),)),
//                   ),
//                 ),
//
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
