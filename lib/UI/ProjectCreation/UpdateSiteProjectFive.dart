// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:igreen_flutter/UI/projectCreation/UpdateSiteProjectSix.dart';
//
// import '../../Controller/UpdateSiteFiveController.dart';
// import '../../Controller/UpdateSiteFourController.dart';
// import '../../forms/forms.dart';
// import '../../forms/theme.dart';
// import 'UpdateSiteProject_four.dart';
//
// class Updatesiteprojectfive extends GetView<UpdateSiteFiveController> {
//   const  Updatesiteprojectfive({Key? key}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//    /* bool _isChecked1 = false;
//     bool _isChecked2 = false;*/
//     UpdateSiteFiveController controller = Get.put(UpdateSiteFiveController());
//     return Scaffold(
//       backgroundColor: AppTheme.screenBackground,
//       body:SingleChildScrollView(
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
//                         Get.off(const UpdatesiteprojectFour());
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
//                 height: 155,
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
//                             controller: controller.remarkoneController,
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
//                                               child: Text("Browser",
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
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: 398,
//                 height: 600,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4)
//                 ),
//                 child:Column(
//                   children: [
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 12.0,top: 8.0),
//                           child: Text("Our Scope of Work",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff272727)),),
//                         )
//                       ],
//                     ),
//                      SizedBox(
//                       height: 8,
//                     ),
//                      Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Remark Test",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             controller: controller.remarkTwoController,
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
//                       height: 10,
//                     ),
//                     Row(
//
//                       children: [
//                         Row(
//
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//
//                             Padding(
//                               padding: const EdgeInsets.only(left: 3.0),
//                               child: Text('HDD',style: TextStyle(
//                                   color: Color(0xff828282)
//
//                               ),),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           width: 78,
//                         ),
//                         Row(
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 3.0),
//                               child: Text('Escavators Small',style: TextStyle(
//                                   color: Color(0xff828282)
//                               ),),
//                             ),
//                           ],
//                         ),
//
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//
//                       children: [
//                         Row(
//
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                  /* setState(() {
//                                     _isChecked1 = value!;
//                                   });*/
//
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//
//                             Padding(
//                               padding: const EdgeInsets.only(left: 3.0),
//                               child: Text('Hydra Big',style: TextStyle(
//                                   color: Color(0xff828282)
//
//                               ),),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           width: 48,
//                         ),
//                         Row(
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 3.0),
//                               child: Text('Generator',style: TextStyle(
//                                   color: Color(0xff828282)
//                               ),),
//                             ),
//                           ],
//                         ),
//
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//
//                       children: [
//                         Row(
//
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   /* setState(() {
//                                     _isChecked1 = value!;
//                                   });*/
//
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//
//                             Text('Grinding Machine',style: TextStyle(
//
//                                 color: Color(0xff828282)
//
//                             ),),
//                           ],
//                         ),
//
//                         Row(
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 3.0),
//                               child: Text('Rollers Small',style: TextStyle(
//                                   color: Color(0xff828282)
//                               ),),
//                             ),
//                           ],
//                         ),
//
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//
//                       children: [
//                         Row(
//
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   /* setState(() {
//                                     _isChecked1 = value!;
//                                   });*/
//
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//
//                             Text('Drum Stands',style: TextStyle(
//
//                                 color: Color(0xff828282)
//
//                             ),),
//                           ],
//                         ),
//                         SizedBox(
//                           width: 30,
//                         ),
//
//                         Row(
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 3.0),
//                               child: Text('Winch Machine',style: TextStyle(
//                                   color: Color(0xff828282)
//                               ),),
//                             ),
//                           ],
//                         ),
//
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//
//                       children: [
//                         Row(
//
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   /* setState(() {
//                                     _isChecked1 = value!;
//                                   });*/
//
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//
//                             Text('Hydra Small',style: TextStyle(
//
//                                 color: Color(0xff828282)
//
//                             ),),
//                           ],
//                         ),
//                         SizedBox(
//                           width: 36,
//                         ),
//
//                         Row(
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 3.0),
//                               child: Text('Welding Machine',style: TextStyle(
//                                   color: Color(0xff828282)
//                               ),),
//                             ),
//                           ],
//                         ),
//
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//
//                       children: [
//                         Row(
//
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   /* setState(() {
//                                     _isChecked1 = value!;
//                                   });*/
//
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//
//                             Text('Dradels',style: TextStyle(
//
//                                 color: Color(0xff828282)
//
//                             ),),
//                           ],
//                         ),
//                         SizedBox(
//                           width: 64,
//                         ),
//
//                         Row(
//                           children: [
//                             Transform.scale(
//                               scale: 1.5,
//                               child: Checkbox(
//                                 value: false,
//                                 onChanged: (bool? value) {
//                                   // Handle checkbox state change
//                                 },
//                                 side: BorderSide(
//                                   color: Colors.grey.shade400,
//                                   width: 0.6,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 3.0),
//                               child: Text('Winch Machine',style: TextStyle(
//                                   color: Color(0xff828282)
//                               ),),
//                             ),
//                           ],
//                         ),
//
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left:12 ),
//                           child: Text("Others if any",style: TextStyle(
//                               color: Color(0xff828282)
//                           ),),
//                         ),
//
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             controller: controller.othersController,
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
//
//
//
//
//                   ],
//                 ) ,
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
//                           Text("Own Machine or Subcontract",style: TextStyle(fontSize: 14,
//                               fontWeight: FontWeight.w500,
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
//                             width: 85
//                         ),
//                         Text("Own Machine or Subcontract",style: TextStyle(
//                           fontSize: 12,
//                             color: Color(0xff828282)
//                         ),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 170,
//                           child: TextInput2(
//                             controller: controller.remarkThreeController,
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
//                     SizedBox(
//                       height: 8,
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             ),
//             /*SizedBox(
//               height: 15,
//             ),
//             InkWell(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const Updatesiteprojectsix()));
//               },
//               child: Container(
//                 width: 237,
//                 height:44,
//                 decoration: BoxDecoration(
//                   color: AppTheme.secondaryColor,
//                   borderRadius: BorderRadius.circular(4),
//
//                 ),
//                 child: const Center(
//                   child: Text("Next",style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),*/
//
//           ],
//         ),
//       ) ,
//
//     );
//   }
// }
