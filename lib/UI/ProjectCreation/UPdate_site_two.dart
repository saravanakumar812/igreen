import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/UI/projectCreation/UPdate_site_three.dart';

import '../../Controller/UpdateSiteTwoController.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import 'UPdate_Site_Projects.dart';

class UPdateSiteTwo extends GetView<UpdateSiteTwoController> {
  const  UPdateSiteTwo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    UpdateSiteTwoController controller = Get.put(UpdateSiteTwoController());
    return Scaffold(
      backgroundColor: AppTheme.screenBackground,
      body: SingleChildScrollView(
        child: Center(
            child:Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Get.off(const UpdateSiteProjectsOne());
                        },

                          child: Image.asset("assets/images/backarrow.png")),
                    ),
                    Padding(
                      padding:  const EdgeInsets.all(8.0),
                      child: Image.asset("assets/images/menu.png"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("UPDATE SITE PROJECTS",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    width: 398,
                    height: 128,

                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Row(
                            children: [
                              Text("TENDER SPEC/ENQUIRY SPEC",style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff272727)),)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left:12 ),
                              child: Text("Remark Test",style: TextStyle(
                                  color: Color(0xff828282)
                              ),),
                            ),
                            SizedBox(
                                width: 95
                            ),
                            Text("Documents",style: TextStyle(
                                color: Color(0xff828282)
                            ),),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                // controller: controller.ideasController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "Test Project",
                                //obscureText: true,

                                onTextChange: (general) {
                                  // controller.popUpValue.value = true;
                                },
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(color: Colors.grey.shade400,width: 1),
                              //   borderRadius: BorderRadius.circular(4),
                              // ),

                            ),

                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 155,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),

                                      border:
                                      Border.all(color: Colors.grey.shade400,width: 1)),
                                  margin:
                                  EdgeInsets.only(top: 8, left: 2, right: 4),
                                  child: GestureDetector(
                                      onTap: () {
                                        // pickFile(context);
                                      },
                                      child: Container(
                                        /*margin: EdgeInsets.symmetric(horizontal: 2),*/
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller.pickFile(context);
                                              },
                                              child: Container(
                                                width: 64,
                                                height: 25,

                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: AppTheme.secondaryColor,

                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4)),
                                                    border: Border.all(
                                                        color: Colors.grey.shade400
                                                    )),
                                                child: Center(
                                                  child: Text("Browser",
                                                      style: GoogleFonts.poppins(
                                                          color:
                                                          AppTheme.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w400)),
                                                ),
                                              ),
                                            ),
                                            Obx(
                                                  () => controller
                                                  .isFileSelected.value &&
                                                  controller.file != null
                                                  ? Row(
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    child: SingleChildScrollView(
                                                      scrollDirection:
                                                      Axis.horizontal,
                                                      child: Text(
                                                          controller
                                                              .file!.path
                                                              .split('/')
                                                              .last,
                                                          style: GoogleFonts.poppins(
                                                              color: AppTheme
                                                                  .appBlack,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600)),
                                                    ),
                                                  ),
                                                ],
                                              )
                                                  : Expanded(
                                                child: Text(
                                                    "No file choosen",
                                                    style:
                                                    GoogleFonts.poppins(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight
                                                            .w600)),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    width: 398,
                    height: 377,

                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Row(
                            children: [
                              Text("TENDER DESCRIPTION",style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff272727)),)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        Row(
                          children: [
                            Container(
                              width: 170,


                              child: TextInput2(
                                height: 100,
                                /* label: "Type",*/
                                onPressed: () {
                                  // if (controller.rendList.value) {
                                  //   controller.rendList.value = false;
                                  // } else {
                                  //   controller.rendList.value = true;
                                  // }
                                  // controller.rendDetails.clear();
                                  // controller.rendDetails.add('Factory');
                                  // controller.rendDetails.add('Field');
                                },
                                //  controller: controller.typeController,
                                textInputType: TextInputType.number,
                                textColor: Color(0xCC252525),
                                obscureText: true,
                                isReadOnly: true,
                                hintText: "Description",
                                onTextChange: (string) {},
                              ),


                            ),


                            Container(
                              width: 170,


                              child: TextInput2(
                                height: 100,
                                /* label: "Type",*/
                                onPressed: () {
                                  // if (controller.rendList.value) {
                                  //   controller.rendList.value = false;
                                  // } else {
                                  //   controller.rendList.value = true;
                                  // }
                                  // controller.rendDetails.clear();
                                  // controller.rendDetails.add('Factory');
                                  // controller.rendDetails.add('Field');
                                },
                                //  controller: controller.typeController,
                                textInputType: TextInputType.number,
                                textColor: Color(0xCC252525),
                                obscureText: true,
                                isReadOnly: true,
                                hintText: "Unit",
                                onTextChange: (string) {},
                              ),


                            ),
                          ],
                        ),
                       SizedBox(
                         height: 10,
                       ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left:12 ),
                              child: Text("Quantity",style: TextStyle(
                                  color: Color(0xff828282)
                              ),),
                            ),
                            SizedBox(
                                width: 100
                            ),
                            Text("Quantity",style: TextStyle(
                                color: Color(0xff828282)
                            ),),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                // controller: controller.ideasController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "14-06-2024",
                                //obscureText: true,

                                onTextChange: (general) {
                                  // controller.popUpValue.value = true;
                                },
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(color: Colors.grey.shade400,width: 1),
                              //   borderRadius: BorderRadius.circular(4),
                              // ),

                            ),

                            Container(
                              width: 170,
                              child: TextInput2(
                                // controller: controller.ideasController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "14-06-2024",
                                //obscureText: true,

                                onTextChange: (general) {
                                  // controller.popUpValue.value = true;
                                },
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(color: Colors.grey.shade400,width: 1),
                              //   borderRadius: BorderRadius.circular(4),
                              // ),

                            ),
                          ],
                        ),

                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left:12 ),
                              child: Text("Quantity",style: TextStyle(
                                  color: Color(0xff828282)
                              ),),
                            ),

                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                // controller: controller.ideasController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "14-06-2024",
                                //obscureText: true,

                                onTextChange: (general) {
                                  // controller.popUpValue.value = true;
                                },
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(color: Colors.grey.shade400,width: 1),
                              //   borderRadius: BorderRadius.circular(4),
                              // ),

                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 170,
                            ),
                            InkWell(
                              onTap: (){},
                              child: Container(
                                width: 80,
                                height: 33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 1,color: AppTheme.secondaryColor)
                                ),
                                child: const Center(child: Text("View",style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.secondaryColor,

                                ),)),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: (){},
                              child: Container(
                                width: 80,
                                height: 33,
                                decoration: BoxDecoration(
                                  color: AppTheme.secondaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(width: 1,color: AppTheme.secondaryColor)
                                ),
                                child: const Center(child: Text("Add",style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.white,


                                ),)),
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    width: 398,
                    height: 150,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Row(
                            children: [
                              Text("ASSIGNED TO",style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff272727)),)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 170,


                              child: TextInput2(
                                height: 100,
                                /* label: "Type",*/
                                onPressed: () {
                                  // if (controller.rendList.value) {
                                  //   controller.rendList.value = false;
                                  // } else {
                                  //   controller.rendList.value = true;
                                  // }
                                  // controller.rendDetails.clear();
                                  // controller.rendDetails.add('Factory');
                                  // controller.rendDetails.add('Field');
                                },
                                //  controller: controller.typeController,
                                textInputType: TextInputType.number,
                                textColor: Color(0xCC252525),
                                obscureText: true,
                                isReadOnly: true,
                                hintText: "Employee Name",
                                onTextChange: (string) {},
                              ),


                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 170,
                            ),
                            InkWell(
                              onTap: (){},
                              child: Container(
                                width: 80,
                                height: 33,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(width: 1,color: AppTheme.secondaryColor)
                                ),
                                child: const Center(child: Text("View",style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.secondaryColor,

                                ),)),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: (){},
                              child: Container(
                                width: 80,
                                height: 33,
                                decoration: BoxDecoration(
                                    color: AppTheme.secondaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(width: 1,color: AppTheme.secondaryColor)
                                ),
                                child: const Center(child: Text("Add",style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.white,


                                ),)),
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    width: 398,
                    height: 440,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Row(
                            children: [
                              Text("OPENING DATE",style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff272727)),)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                // controller: controller.ideasController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "Remark Test",
                                //obscureText: true,

                                onTextChange: (general) {
                                  // controller.popUpValue.value = true;
                                },
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(color: Colors.grey.shade400,width: 1),
                              //   borderRadius: BorderRadius.circular(4),
                              // ),

                            ),



                            Container(
                              width: 165,
                              child: TextInput2(
                                onPressed: () {
                                  controller.OpeningDate(context);
                                },
                                 controller: controller.OpeningDateController,
                                height: 100,
                                isReadOnly: true,
                                /* label: "Customer requirement Date",*/
                                onTextChange: (text) {},
                                textInputType: TextInputType.phone,
                                textColor: Color(0xCC252525),
                                hintText: "mm/dd/yyyy",
                                sufficIcon: Icon(
                                  Icons.calendar_month,color: AppTheme.secondaryColor,
                                ),
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),

                        const Padding(
                          padding: EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Row(
                            children: [
                              Text("CLOSING DATE",style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff272727)),)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                // controller: controller.ideasController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "Open",
                                //obscureText: true,

                                onTextChange: (general) {
                                  // controller.popUpValue.value = true;
                                },
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(color: Colors.grey.shade400,width: 1),
                              //   borderRadius: BorderRadius.circular(4),
                              // ),

                            ),

                            Container(
                              width: 165,
                              child: TextInput2(
                                onPressed: () {
                                controller.ClosingDate(context);
                                },
                                 controller: controller.ClosingDateController,
                                height: 100,
                                isReadOnly: true,
                                /* label: "Customer requirement Date",*/
                                onTextChange: (text) {},
                                textInputType: TextInputType.phone,
                                textColor: Color(0xCC252525),
                                hintText: "mm/dd/yyyy",
                                sufficIcon: Icon(
                                  Icons.calendar_month,color: AppTheme.secondaryColor,
                                ),
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),

                        const Padding(
                          padding: EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Row(
                            children: [
                              Text("BQR",style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff272727)),)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),


                        Row(
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                // controller: controller.ideasController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "Open",
                                //obscureText: true,

                                onTextChange: (general) {
                                  // controller.popUpValue.value = true;
                                },
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(color: Colors.grey.shade400,width: 1),
                              //   borderRadius: BorderRadius.circular(4),
                              // ),

                            ),


                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 155,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),

                                      border:
                                      Border.all(color: Colors.grey.shade400,width: 1)),
                                  margin:
                                  EdgeInsets.only(top: 8, left: 2, right: 4),
                                  child: GestureDetector(
                                      onTap: () {
                                        // pickFile(context);
                                      },
                                      child: Container(
                                        /*margin: EdgeInsets.symmetric(horizontal: 2),*/
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller.pickFile(context);
                                              },
                                              child: Container(
                                                width: 64,
                                                height: 25,

                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: AppTheme.secondaryColor,

                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4)),
                                                    border: Border.all(
                                                        color: Colors.grey.shade400
                                                    )),
                                                child: Center(
                                                  child: Text("Browser",
                                                      style: GoogleFonts.poppins(
                                                          color:
                                                          AppTheme.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w400)),
                                                ),
                                              ),
                                            ),
                                            Obx(
                                                  () => controller
                                                  .isFileSelected.value &&
                                                  controller.file != null
                                                  ? Row(
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    child: SingleChildScrollView(
                                                      scrollDirection:
                                                      Axis.horizontal,
                                                      child: Text(
                                                          controller
                                                              .file!.path
                                                              .split('/')
                                                              .last,
                                                          style: GoogleFonts.poppins(
                                                              color: AppTheme
                                                                  .appBlack,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600)),
                                                    ),
                                                  ),
                                                ],
                                              )
                                                  : Expanded(
                                                child: Text(
                                                    "No file choosen",
                                                    style:
                                                    GoogleFonts.poppins(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight
                                                            .w600)),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const Padding(
                          padding: EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Row(
                            children: [
                              Text("EMD/EMD EXEMPTION",style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff272727)),)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                // controller: controller.ideasController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "Open",
                                //obscureText: true,

                                onTextChange: (general) {
                                  // controller.popUpValue.value = true;
                                },
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(color: Colors.grey.shade400,width: 1),
                              //   borderRadius: BorderRadius.circular(4),
                              // ),

                            ),

                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 155,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),

                                      border:
                                      Border.all(color: Colors.grey.shade400,width: 1)),
                                  margin:
                                  EdgeInsets.only(top: 8, left: 2, right: 4),
                                  child: GestureDetector(
                                      onTap: () {
                                        // pickFile(context);
                                      },
                                      child: Container(
                                        /*margin: EdgeInsets.symmetric(horizontal: 2),*/
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller.pickFile(context);
                                              },
                                              child: Container(
                                                width: 64,
                                                height: 25,

                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: AppTheme.secondaryColor,

                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4)),
                                                    border: Border.all(
                                                        color: Colors.grey.shade400
                                                    )),
                                                child: Center(
                                                  child: Text("Browser",
                                                      style: GoogleFonts.poppins(
                                                          color:
                                                          AppTheme.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w400)),
                                                ),
                                              ),
                                            ),
                                            Obx(
                                                  () => controller
                                                  .isFileSelected.value &&
                                                  controller.file != null
                                                  ? Row(
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    child: SingleChildScrollView(
                                                      scrollDirection:
                                                      Axis.horizontal,
                                                      child: Text(
                                                          controller
                                                              .file!.path
                                                              .split('/')
                                                              .last,
                                                          style: GoogleFonts.poppins(
                                                              color: AppTheme
                                                                  .appBlack,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600)),
                                                    ),
                                                  ),
                                                ],
                                              )
                                                  : Expanded(
                                                child: Text(
                                                    "No file choosen",
                                                    style:
                                                    GoogleFonts.poppins(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 8,
                                                        fontWeight:
                                                        FontWeight
                                                            .w600)),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const UpdateSiteThree()));
                  },
                  child: Container(
                    width: 237,
                    height:44,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(4),

                    ),
                    child: const Center(
                      child: Text("Next",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),),
                    ),
                  ),

                ),
                SizedBox(
                  height: 15,
                ),
              ],
            )
        ),
      ),
    );
  }
}
