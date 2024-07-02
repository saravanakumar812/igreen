import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/Controller/UpdateSiteProjectsController.dart';
import 'package:igreen_flutter/UI/projectCreation/UPdate_site_two.dart';
import 'package:igreen_flutter/forms/theme.dart';

import '../../forms/forms.dart';

class UpdateSiteProjectsOne extends GetView<UpdateSiteProjectsController> {
  const UpdateSiteProjectsOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpdateSiteProjectsController controller =
    Get.put(UpdateSiteProjectsController());
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: AppTheme.screenBackground,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/menu.png"),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "UPDATE SITE PROJECTS",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  width: 398,
                  height: 455,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "PROJECT CODE",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff272727)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              "Client",
                              style: TextStyle(color: Color(0xff828282)),
                            ),
                          ),
                          SizedBox(width: 130),
                          Text(
                            "Sub or Own",
                            style: TextStyle(color: Color(0xff828282)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.clientNameController,
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
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.projectTypeController,
                              //height: 70,
                              //label: "Ideas",
                              onPressed: () {},
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "Own",
                              //obscureText: true,

                              onTextChange: (general) {
                                // controller.popUpValue.value = true;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              "MM/YYYY",
                              style: TextStyle(color: Color(0xff828282)),
                            ),
                          ),
                          SizedBox(width: 100),
                          Text(
                            "Serial Num",
                            style: TextStyle(color: Color(0xff828282)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 1, top: 1.0),
                            child: Container(
                              width: 170,
                              child: TextInput2(
                                controller: controller.monthYearController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "Sep/2023",
                                //obscureText: true,

                                onTextChange: (general) {
                                  // controller.popUpValue.value = true;
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.serialNumberController,
                              //height: 70,
                              //label: "Ideas",
                              onPressed: () {},
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "1",
                              //obscureText: true,

                              onTextChange: (general) {
                                // controller.popUpValue.value = true;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              "State",
                              style: TextStyle(color: Color(0xff828282)),
                            ),
                          ),
                          SizedBox(
                            width: 130,
                          ),
                          Text(
                            "District",
                            style: TextStyle(color: Color(0xff828282)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.stateController,

                              onPressed: () {},
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "TN",
                              //obscureText: true,

                              onTextChange: (general) {
                                // controller.popUpValue.value = true;
                              },
                            ),
                          ),
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.districtController,
                              //height: 70,
                              //label: "Ideas",
                              onPressed: () {},
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "Own",
                              //obscureText: true,

                              onTextChange: (general) {
                                // controller.popUpValue.value = true;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              "Area",
                              style: TextStyle(color: Color(0xff828282)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.areaController,
                              //height: 70,
                              //label: "Ideas",
                              onPressed: () {},
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "Thirumangalam",
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
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "PROJECT CODE",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff272727)),
                            ),
                            Obx(() =>
                                Expanded(
                                  child: Text(
                                    controller.projectCode.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: Colors.black54),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  width: 398,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "LAST UPDATE",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff272727)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              "Employee Name",
                              style: TextStyle(color: Color(0xff828282)),
                            ),
                          ),
                          SizedBox(width: 70),
                          Text(
                            "Employee ID",
                            style: TextStyle(color: Color(0xff828282)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.employeeNameController,
                              //height: 70,
                              //label: "Ideas",
                              onPressed: () {},
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "Sathiya",
                              //obscureText: true,

                              onTextChange: (general) {
                                // controller.popUpValue.value = true;
                              },
                            ),
                          ),
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.employeeIdController,
                              //height: 70,
                              //label: "Ideas",
                              onPressed: () {},
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "1",
                              //obscureText: true,

                              onTextChange: (general) {
                                // controller.popUpValue.value = true;
                              },
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              "Last Update Date",
                              style: TextStyle(color: Color(0xff828282)),
                            ),
                          ),
                          SizedBox(width: 60),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.lastUpdateDateController,
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
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  width: 398,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "TENDER TYPE",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff272727)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                "Qualified",
                                style: TextStyle(color: Color(0xff828282)),
                              ),
                            ),
                            SizedBox(width: 110),
                            Text(
                              "Tender Type",
                              style: TextStyle(color: Color(0xff828282)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                controller:
                                controller.tenderTypeQualifiedController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {
                                  controller.qualifiedTender.value =
                                  !controller.qualifiedTender.value;
                                  controller.qualifiedTenderDetails.add('Yes');
                                  controller.qualifiedTenderDetails.add('No');
                                },
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "yes",
                                obscureText: true,

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
                                controller: controller.tenderTypeController,

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
                          ],
                        ),
                        Obx(() =>
                            Visibility(
                              visible: controller.qualifiedTender.value,
                              child: Row(
                                children: [
                                  SingleChildScrollView(
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width /
                                          2 -
                                          25,
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
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: List.generate(
                                              controller.qualifiedTenderDetails
                                                  .length,
                                                  (index) {
                                                var model = controller
                                                    .qualifiedTenderDetails[
                                                index];
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      TextInput(
                                                        onPressed: () {
                                                          controller
                                                              .tenderTypeQualifiedController
                                                              .text = controller
                                                              .qualifiedTenderDetails[
                                                          index];
                                                          if (controller
                                                              .tenderTypeQualifiedController
                                                              .text ==
                                                              'Yes') {
                                                            controller
                                                                .tenderDetails
                                                                .value = true;
                                                          } else {
                                                            controller
                                                                .tenderDetails
                                                                .value = false;
                                                          }

                                                          controller
                                                              .qualifiedTender
                                                              .value = false;
                                                          controller
                                                              .qualifiedTenderDetails
                                                              .clear();
                                                        },
                                                        margin: false,
                                                        isSelected: controller
                                                            .tenderTypeQualifiedController
                                                            .text ==
                                                            controller
                                                                .qualifiedTenderDetails[
                                                            index],
                                                        label: "",
                                                        isEntryField: false,
                                                        textInputType:
                                                        TextInputType.text,
                                                        textColor:
                                                        Color(0xCC234345),
                                                        hintText: model,
                                                        obscureText: true,
                                                        onTextChange:
                                                            (String) {},
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Visibility(
                                                          visible: controller
                                                              .qualifiedTenderDetails
                                                              .length !=
                                                              index + 1,
                                                          child: Container(
                                                            height: 1,
                                                            color:
                                                            AppTheme.grey,
                                                          ))
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                "Tender Amount ",
                                style: TextStyle(color: Color(0xff828282)),
                              ),
                            ),
                            SizedBox(width: 60),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                controller: controller.tenderAmountController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "0",
                                //obscureText: true,

                                onTextChange: (general) {
                                  // controller.popUpValue.value = true;
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Obx(() =>
                  Visibility(
                    visible: controller.tenderDetails.value,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            width: 398,
                            height: 128,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "TENDER SPEC/ENQUIRY SPEC",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Test",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 95),
                                    Text(
                                      "Documents",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller:
                                        controller.tenderSpecController,
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
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 155,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1)),
                                          margin: EdgeInsets.only(
                                              top: 8, left: 2, right: 4),
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
                                                        controller
                                                            .tenderSpecPickFile(
                                                            context);
                                                      },
                                                      child: Container(
                                                        width: 64,
                                                        height: 25,
                                                        margin:
                                                        EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: AppTheme
                                                                .secondaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                4)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                        child: Center(
                                                          child: Text("Browser",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () =>
                                                      controller
                                                          .isFileSelected
                                                          .value &&
                                                          controller
                                                              .tenderFile !=
                                                              null
                                                          ? Row(
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            child:
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                              Axis.horizontal,
                                                              child: Text(
                                                                  controller
                                                                      .tenderFile!
                                                                      .path
                                                                      .split(
                                                                      '/')
                                                                      .last,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                      color: AppTheme
                                                                          .appBlack,
                                                                      fontSize:
                                                                      12,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                          : Expanded(
                                                        child: Text(
                                                            "No file chosen",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                8,
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
                                borderRadius: BorderRadius.circular(4)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Padding(
                                    padding:
                                    EdgeInsets.only(left: 12.0, top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "TENDER DESCRIPTION",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff272727)),
                                        )
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
                                            if (controller
                                                .tenderDescription.value) {
                                              controller.tenderDescription
                                                  .value = false;
                                            } else {
                                              controller.tenderDescription
                                                  .value = true;
                                            }
                                          },
                                          controller: controller
                                              .tenderDescriptionController,
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          obscureText: true,
                                          isReadOnly: true,
                                          hintText: "Tender Description",
                                          onTextChange: (string) {},
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          height: 100,
                                          /* label: "Type",*/
                                          onPressed: () {
                                            if (controller.tenderUnit.value) {
                                              controller.tenderUnit.value =
                                              false;
                                            } else {
                                              controller.tenderUnit.value =
                                              true;
                                            }
                                          },
                                          controller:
                                          controller.tenderUnitController,
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          obscureText: true,
                                          isReadOnly: true,
                                          hintText: "Tender Unit",
                                          onTextChange: (string) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(() =>
                                      Visibility(
                                        visible:
                                        controller.tenderDescription.value,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width /
                                                  2 -
                                                  25,
                                              height: 150,
                                              margin: EdgeInsets.fromLTRB(
                                                  12, 4, 12, 0),
                                              padding: EdgeInsets.fromLTRB(
                                                  6, 4, 6, 6),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                  AppTheme.inputBorderColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                color: Colors
                                                    .white, // Set the desired background color
                                              ),
                                              child: SingleChildScrollView(
                                                child: IntrinsicHeight(
                                                  child: Column(
                                                    children: List.generate(
                                                      controller
                                                          .tenderDescriptionDropDownResponseData
                                                          .length,
                                                          (index) {
                                                        var model = controller
                                                            .tenderDescriptionDropDownResponseData[
                                                        index];
                                                        return Container(
                                                          child: Column(
                                                            children: [
                                                              TextInput(
                                                                onPressed: () {
                                                                  controller
                                                                      .tenderDescriptionController
                                                                      .text =
                                                                  controller
                                                                      .tenderDescriptionDropDownResponseData[
                                                                  index]
                                                                      .descriptions!;
                                                                  controller
                                                                      .tenderDescription
                                                                      .value =
                                                                  false;
                                                                  /* controller.getFactoryDepartmentTeam();
                                                        controller.depId.value = controller
                                                            .clientDepartmentData[index]
                                                            .clientId
                                                            .toString();
                                                        controller.getFactoryEmployee(controller
                                                            .clientDepartmentData[index]
                                                            .clientId);
                                                        controller.staffDetails.text = '';*/
                                                                },
                                                                margin: false,
                                                                isSelected: controller
                                                                    .tenderDescriptionController
                                                                    .text ==
                                                                    controller
                                                                        .tenderDescriptionDropDownResponseData[
                                                                    index]
                                                                        .descriptions,
                                                                label: "",
                                                                isEntryField:
                                                                false,
                                                                textInputType:
                                                                TextInputType
                                                                    .text,
                                                                textColor: Color(
                                                                    0xCC234345),
                                                                hintText: model
                                                                    .descriptions,
                                                                obscureText:
                                                                true,
                                                                onTextChange:
                                                                    (String) {},
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Visibility(
                                                                  visible: controller
                                                                      .tenderDescriptionDropDownResponseData
                                                                      .length !=
                                                                      index + 1,
                                                                  child:
                                                                  Container(
                                                                    height: 1,
                                                                    color:
                                                                    AppTheme
                                                                        .grey,
                                                                  ))
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Obx(() =>
                                      Visibility(
                                        visible: controller.tenderUnit.value,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width /
                                                    2 -
                                                    25,
                                                height: 150,
                                                margin: EdgeInsets.fromLTRB(
                                                    12, 4, 12, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    6, 4, 6, 6),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppTheme
                                                        .inputBorderColor,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  color: Colors
                                                      .white, // Set the desired background color
                                                ),
                                                child: SingleChildScrollView(
                                                  child: IntrinsicHeight(
                                                    child: Column(
                                                      children: List.generate(
                                                        controller
                                                            .tenderUnitDropdownResponse
                                                            .length,
                                                            (index) {
                                                          return Container(
                                                            child: Column(
                                                              children: [
                                                                TextInput(
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .tenderUnitController
                                                                        .text =
                                                                    controller
                                                                        .tenderUnitDropdownResponse[index]
                                                                        .unit!;
                                                                    controller
                                                                        .tenderUnit
                                                                        .value =
                                                                    false;
                                                                  },
                                                                  margin: false,
                                                                  isSelected: controller
                                                                      .tenderUnitController
                                                                      .text ==
                                                                      controller
                                                                          .tenderUnitDropdownResponse[
                                                                      index]
                                                                          .unit,
                                                                  label: "",
                                                                  isEntryField:
                                                                  false,
                                                                  textInputType:
                                                                  TextInputType
                                                                      .text,
                                                                  textColor: Color(
                                                                      0xCC234345),
                                                                  hintText: controller
                                                                      .tenderUnitDropdownResponse[
                                                                  index]
                                                                      .unit,
                                                                  onTextChange:
                                                                      (
                                                                      String) {},
                                                                ),
                                                                SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Visibility(
                                                                  visible: controller
                                                                      .tenderUnitDropdownResponse
                                                                      .length !=
                                                                      index + 1,
                                                                  child:
                                                                  Container(
                                                                    height: 1,
                                                                    color: AppTheme
                                                                        .primaryColor,
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
                                            ],
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Text(
                                          "Quantity",
                                          style: TextStyle(
                                              color: Color(0xff828282)),
                                        ),
                                      ),
                                      SizedBox(width: 100),
                                      Text(
                                        "Rate",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          controller:
                                          controller.quantityController,
                                          onPressed: () {},
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          hintText: "Enter Quantity",
                                          onTextChange: (general) {
                                            // controller.popUpValue.value = true;
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          controller: controller.rateController,
                                          onPressed: () {},
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          hintText: " Enter Rate",
                                          onTextChange: (general) {
                                            // controller.popUpValue.value = true;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 12),
                                          child: Text(
                                            "Amount",
                                            style: TextStyle(
                                                color: Color(0xff828282)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          controller:
                                          controller.amountController,
                                          onPressed: () {},
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          hintText: "Enter Amount",
                                          onTextChange: (general) {},
                                        ),
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
                                        onTap: () {
                                          controller
                                              .getParticularSiteProjectTenderApi();
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 33,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                  AppTheme.secondaryColor)),
                                          child: const Center(
                                              child: Text(
                                                "View",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme
                                                      .secondaryColor,
                                                ),
                                              )),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: 80,
                                          height: 33,
                                          decoration: BoxDecoration(
                                              color: AppTheme.secondaryColor,
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                  AppTheme.secondaryColor)),
                                          child: const Center(
                                              child: Text(
                                                "Add",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.white,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          height:height * 0.3,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                // height: height * 1.5,
                                width: width,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black)),
                                child: SingleChildScrollView(
                                  child: Container(
                                    //height: height* 0.3,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: width * 1.2,
                                          height: 50,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: width / 2.26,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: AppTheme.secondaryColor,
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        //                   <--- right side
                                                        color: Colors.black,
                                                      ),
                                                      right: BorderSide(
                                                        //                   <--- right side
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Project Name',
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: width / 4,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme.secondaryColor,
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            //                   <--- right side
                                                            color: Colors.black,
                                                          ),
                                                          right: BorderSide(
                                                            //                   <--- right side
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                            'Amount',
                                                            style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                            textAlign: TextAlign.center,
                                                          )),
                                                    ),
                                                    Container(
                                                      width: width / 4,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme.secondaryColor,
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            //                   <--- right side
                                                            color: Colors.black,
                                                          ),
                                                          right: BorderSide(
                                                            //                   <--- right side
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                            'Expense',
                                                            style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                            textAlign: TextAlign.center,
                                                          )),
                                                    ),
                                                    Container(
                                                      width: width / 4,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme.secondaryColor,
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            //                   <--- right side
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                            'Status',
                                                            style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                          )),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Obx(
                                              () =>
                                          controller.isLoading.value
                                              ? Container(
                                  
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              height:
                                              MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height ,
                                              child: Center(
                                                  child: CircularProgressIndicator()))
                                              : controller.getSiteProjectTenderData
                                              .isNotEmpty
                                              ? Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height - 210,
                                            child: ListView.builder(
                                              itemCount: controller
                                                  .getSiteProjectTenderData.length,
                                              itemBuilder: (context, index) {
                                                return ProductsListWidgets(
                                                    context, index);
                                              },
                                            ),
                                          )
                                              : Center(
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                        )
                                  
                                  
                                        // Container(
                                        //   child: Column(
                                        //     children: [
                                        //       Container(
                                        //         width: width * 1.2,
                                        //         height: 50,
                                        //         //padding: EdgeInsets.only(left: 10),
                                        //         child: Row(
                                        //           children: [
                                        //             Container(
                                        //               width: width / 2.26,
                                        //               height: 50,
                                        //               decoration: BoxDecoration(
                                        //                 border: Border(
                                        //                   bottom: BorderSide(
                                        //                     color: Colors.black,
                                        //                   ),
                                        //                   right: BorderSide(
                                        //                     color: Colors.black,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               child: Center(
                                        //                 child: Text(
                                        //                   'Sample Project Name 01',
                                        //                   style: GoogleFonts.poppins(
                                        //                       color: Colors.black,
                                        //                       fontSize: 12,
                                        //                       fontWeight:
                                        //                       FontWeight.w400),
                                        //                   textAlign: TextAlign.center,
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //             Row(
                                        //               children: [
                                        //                 Container(
                                        //                   width: width / 4,
                                        //                   height: 50,
                                        //                   decoration: BoxDecoration(
                                        //                     border: Border(
                                        //                       bottom: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                       right: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   child: Center(
                                        //                       child: Text(
                                        //                         "₹0",
                                        //                         style:
                                        //                         GoogleFonts.poppins(
                                        //                             color:
                                        //                             Colors.black,
                                        //                             fontSize: 12,
                                        //                             fontWeight:
                                        //                             FontWeight
                                        //                                 .w400),
                                        //                       )),
                                        //                 ),
                                        //                 Container(
                                        //                   width: width / 4,
                                        //                   height: 50,
                                        //                   decoration: BoxDecoration(
                                        //                     border: Border(
                                        //                       bottom: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                       right: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   child: Center(
                                        //                       child: Text(
                                        //                         '₹0',
                                        //                         style:
                                        //                         GoogleFonts.poppins(
                                        //                             color:
                                        //                             Colors.black,
                                        //                             fontSize: 12,
                                        //                             fontWeight:
                                        //                             FontWeight
                                        //                                 .w400),
                                        //                       )),
                                        //                 ),
                                        //                 Container(
                                        //                   width: width / 4,
                                        //                   height: 50,
                                        //                   decoration: BoxDecoration(
                                        //                     border: Border(
                                        //                       bottom: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                       right: BorderSide(
                                        //                         color: Colors.white,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   child: Center(
                                        //                       child: Text(
                                        //                         "Pending",
                                        //                         style:
                                        //                         GoogleFonts.poppins(
                                        //                             color:
                                        //                             Colors.black,
                                        //                             fontSize: 12,
                                        //                             fontWeight:
                                        //                             FontWeight
                                        //                                 .w400),
                                        //                       )),
                                        //                 ),
                                        //               ],
                                        //             )
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Container(
                                        //   child: Column(
                                        //     children: [
                                        //       Container(
                                        //         width: width * 1.2,
                                        //         height: 50,
                                        //         //padding: EdgeInsets.only(left: 10),
                                        //         child: Row(
                                        //           children: [
                                        //             Container(
                                        //               width: width / 2.26,
                                        //               height: 50,
                                        //               decoration: BoxDecoration(
                                        //                 border: Border(
                                        //                   bottom: BorderSide(
                                        //                     color: Colors.black,
                                        //                   ),
                                        //                   right: BorderSide(
                                        //                     color: Colors.black,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               child: Center(
                                        //                 child: Text(
                                        //                   'Sample Project Name 02',
                                        //                   style: GoogleFonts.poppins(
                                        //                       color: Colors.black,
                                        //                       fontSize: 12,
                                        //                       fontWeight:
                                        //                       FontWeight.w400),
                                        //                   textAlign: TextAlign.center,
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //             Row(
                                        //               children: [
                                        //                 Container(
                                        //                   width: width / 4,
                                        //                   height: 50,
                                        //                   decoration: BoxDecoration(
                                        //                     border: Border(
                                        //                       bottom: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                       right: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   child: Center(
                                        //                       child: Text(
                                        //                         "₹0",
                                        //                         style:
                                        //                         GoogleFonts.poppins(
                                        //                             color:
                                        //                             Colors.black,
                                        //                             fontSize: 12,
                                        //                             fontWeight:
                                        //                             FontWeight
                                        //                                 .w400),
                                        //                       )),
                                        //                 ),
                                        //                 Container(
                                        //                   width: width / 4,
                                        //                   height: 50,
                                        //                   decoration: BoxDecoration(
                                        //                     border: Border(
                                        //                       bottom: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                       right: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   child: Center(
                                        //                       child: Text(
                                        //                         '₹0',
                                        //                         style:
                                        //                         GoogleFonts.poppins(
                                        //                             color:
                                        //                             Colors.black,
                                        //                             fontSize: 12,
                                        //                             fontWeight:
                                        //                             FontWeight
                                        //                                 .w400),
                                        //                       )),
                                        //                 ),
                                        //                 Container(
                                        //                   width: width / 4,
                                        //                   height: 50,
                                        //                   decoration: BoxDecoration(
                                        //                     border: Border(
                                        //                       bottom: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                       right: BorderSide(
                                        //                         color: Colors.white,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   child: Center(
                                        //                       child: Text(
                                        //                         "Pending",
                                        //                         style:
                                        //                         GoogleFonts.poppins(
                                        //                             color:
                                        //                             Colors.black,
                                        //                             fontSize: 12,
                                        //                             fontWeight:
                                        //                             FontWeight
                                        //                                 .w400),
                                        //                       )),
                                        //                 ),
                                        //               ],
                                        //             )
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Container(
                                        //   child: Column(
                                        //     children: [
                                        //       Container(
                                        //         width: width * 1.2,
                                        //         height: 50,
                                        //         //padding: EdgeInsets.only(left: 10),
                                        //         child: Row(
                                        //           children: [
                                        //             Container(
                                        //               width: width / 2.26,
                                        //               height: 50,
                                        //               decoration: BoxDecoration(
                                        //                 border: Border(
                                        //                   right: BorderSide(
                                        //                     color: Colors.black,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               child: Center(
                                        //                 child: Text(
                                        //                   'Sample Project Name 03',
                                        //                   style: GoogleFonts.poppins(
                                        //                       color: Colors.black,
                                        //                       fontSize: 12,
                                        //                       fontWeight:
                                        //                       FontWeight.w400),
                                        //                   textAlign: TextAlign.center,
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //             Row(
                                        //               children: [
                                        //                 Container(
                                        //                   width: width / 4,
                                        //                   height: 50,
                                        //                   decoration: BoxDecoration(
                                        //                     border: Border(
                                        //                       right: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   child: Center(
                                        //                       child: Text(
                                        //                         "₹0",
                                        //                         style:
                                        //                         GoogleFonts.poppins(
                                        //                             color:
                                        //                             Colors.black,
                                        //                             fontSize: 12,
                                        //                             fontWeight:
                                        //                             FontWeight
                                        //                                 .w400),
                                        //                       )),
                                        //                 ),
                                        //                 Container(
                                        //                   width: width / 4,
                                        //                   height: 50,
                                        //                   decoration: BoxDecoration(
                                        //                     border: Border(
                                        //                       right: BorderSide(
                                        //                         color: Colors.black,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   child: Center(
                                        //                       child: Text(
                                        //                         '₹0',
                                        //                         style:
                                        //                         GoogleFonts.poppins(
                                        //                             color:
                                        //                             Colors.black,
                                        //                             fontSize: 12,
                                        //                             fontWeight:
                                        //                             FontWeight
                                        //                                 .w400),
                                        //                       )),
                                        //                 ),
                                        //                 Container(
                                        //                   width: width / 4,
                                        //                   height: 50,
                                        //                   decoration: BoxDecoration(
                                        //                     border: Border(
                                        //                       right: BorderSide(
                                        //                         color: Colors.white,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   child: Center(
                                        //                       child: Text(
                                        //                         "Pending",
                                        //                         style:
                                        //                         GoogleFonts.poppins(
                                        //                             color:
                                        //                             Colors.black,
                                        //                             fontSize: 12,
                                        //                             fontWeight:
                                        //                             FontWeight
                                        //                                 .w400),
                                        //                       )),
                                        //                 ),
                                        //               ],
                                        //             )
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Padding(
                                    padding:
                                    EdgeInsets.only(left: 12.0, top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "ASSIGNED TO",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff272727)),
                                        )
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
                                          controller:
                                          controller.employeeNameController,
                                          onPressed: () {
                                            if (controller.selectPerson.value) {
                                              controller.selectPerson.value =
                                              false;
                                            } else {
                                              controller.selectPerson.value =
                                              true;
                                            }
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
                                  Obx(() =>
                                      Visibility(
                                        visible: controller.selectPerson.value,
                                        child: Container(
                                          height: height * 0.5,
                                          margin:
                                          EdgeInsets.fromLTRB(12, 4, 12, 0),
                                          padding:
                                          EdgeInsets.fromLTRB(6, 4, 6, 6),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppTheme.inputBorderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            color: Colors
                                                .white, // Set the desired background color
                                          ),
                                          child: SingleChildScrollView(
                                            child: IntrinsicHeight(
                                              child: Column(
                                                children: List.generate(
                                                  controller
                                                      .employeeName.length,
                                                      (index) {
                                                    var model = controller
                                                        .employeeName[index];
                                                    return Container(
                                                      child: Column(
                                                        children: [
                                                          TextInput(
                                                            onPressed: () {
                                                              controller
                                                                  .employeeNameController
                                                                  .text =
                                                              controller
                                                                  .employeeName[
                                                              index]
                                                                  .employeeName!;
                                                              controller
                                                                  .selectPerson
                                                                  .value =
                                                              false;
                                                            },
                                                            margin: false,
                                                            isSelected: controller
                                                                .employeeNameController
                                                                .text ==
                                                                controller
                                                                    .employeeName[
                                                                index]
                                                                    .employeeName,
                                                            label: "",
                                                            isEntryField: false,
                                                            textInputType:
                                                            TextInputType
                                                                .text,
                                                            textColor: Color(
                                                                0xCC234345),
                                                            hintText: model
                                                                .employeeName,
                                                            obscureText: true,
                                                            onTextChange:
                                                                (String) {},
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          Visibility(
                                                              visible: controller
                                                                  .employeeName
                                                                  .length !=
                                                                  index + 1,
                                                              child: Container(
                                                                height: 1,
                                                                color: AppTheme
                                                                    .appBlack,
                                                              ))
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 170,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: 80,
                                          height: 33,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                  AppTheme.secondaryColor)),
                                          child: const Center(
                                              child: Text(
                                                "View",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme
                                                      .secondaryColor,
                                                ),
                                              )),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: 80,
                                          height: 33,
                                          decoration: BoxDecoration(
                                              color: AppTheme.secondaryColor,
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                  AppTheme.secondaryColor)),
                                          child: const Center(
                                              child: Text(
                                                "Add",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.white,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "OPENING DATE",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      )
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
                                          controller.openingDate(context);
                                        },
                                        controller:
                                        controller.openingDateController,
                                        height: 100,
                                        isReadOnly: true,
                                        /* label: "Customer requirement Date",*/
                                        onTextChange: (text) {},
                                        textInputType: TextInputType.phone,
                                        textColor: Color(0xCC252525),
                                        hintText: "mm/dd/yyyy",
                                        sufficIcon: Icon(
                                          Icons.calendar_month,
                                          color: AppTheme.secondaryColor,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "CLOSING DATE",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      )
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
                                          controller.closingDate(context);
                                        },
                                        controller:
                                        controller.closingDateController,
                                        height: 100,
                                        isReadOnly: true,
                                        /* label: "Customer requirement Date",*/
                                        onTextChange: (text) {},
                                        textInputType: TextInputType.phone,
                                        textColor: Color(0xCC252525),
                                        hintText: "mm/dd/yyyy",
                                        sufficIcon: Icon(
                                          Icons.calendar_month,
                                          color: AppTheme.secondaryColor,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "BRQ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      )
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1)),
                                          margin: EdgeInsets.only(
                                              top: 8, left: 2, right: 4),
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
                                                        controller.brqPickFile(
                                                            context);
                                                      },
                                                      child: Container(
                                                        width: 64,
                                                        height: 25,
                                                        margin:
                                                        EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: AppTheme
                                                                .secondaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                4)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                        child: Center(
                                                          child: Text("Browser",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () =>
                                                      controller
                                                          .isFileSelected
                                                          .value &&
                                                          controller
                                                              .brqFile !=
                                                              null
                                                          ? Row(
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            child:
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                              Axis.horizontal,
                                                              child: Text(
                                                                  controller
                                                                      .brqFile!
                                                                      .path
                                                                      .split(
                                                                      '/')
                                                                      .last,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                      color: AppTheme
                                                                          .appBlack,
                                                                      fontSize:
                                                                      12,
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
                                                            style: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                8,
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
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "EMD/EMD EXEMPTION",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      )
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
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 155,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1)),
                                          margin: EdgeInsets.only(
                                              top: 8, left: 2, right: 4),
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
                                                        controller.emdPickFile(
                                                            context);
                                                      },
                                                      child: Container(
                                                        width: 64,
                                                        height: 25,
                                                        margin:
                                                        EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: AppTheme
                                                                .secondaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                4)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                        child: Center(
                                                          child: Text("Browser",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () =>
                                                      controller
                                                          .isFileSelected
                                                          .value &&
                                                          controller
                                                              .emdFile !=
                                                              null
                                                          ? Row(
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            child:
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                              Axis.horizontal,
                                                              child: Text(
                                                                  controller
                                                                      .emdFile!
                                                                      .path
                                                                      .split(
                                                                      '/')
                                                                      .last,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                      color: AppTheme
                                                                          .appBlack,
                                                                      fontSize:
                                                                      12,
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
                                                            style: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                8,
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
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            width: 398,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Padding(
                                    padding:
                                    EdgeInsets.only(left: 12.0, top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "TENDER LOST",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff272727)),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Text(
                                          "Remark Test",
                                          style: TextStyle(
                                              color: Color(0xff828282)),
                                        ),
                                      ),
                                      SizedBox(width: 95),
                                      Text(
                                        "Tender Lost",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          controller: controller
                                              .tenderRemarksController,
                                          //height: 70,
                                          //label: "Ideas",
                                          onPressed: () {},
                                          textInputType: TextInputType.text,
                                          textColor: Color(0xCC252525),
                                          hintText: "Tender Lost Remarks",
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
                                          height: 100,
                                          /* label: "Type",*/
                                          onPressed: () {
                                            if (controller
                                                .tenderLostList.value) {
                                              controller.tenderLostList.value =
                                              false;
                                            } else {
                                              controller.tenderLostList.value =
                                              true;
                                            }

                                            controller.tenderLostListDetails
                                                .add('Finance');
                                            controller.tenderLostListDetails
                                                .add('Remarks');
                                          },
                                          controller: controller
                                              .tenderLostDropDownController,
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          obscureText: true,
                                          isReadOnly: true,
                                          hintText: "Finance",
                                          onTextChange: (string) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Obx(() =>
                                          Visibility(
                                            visible:
                                            controller.tenderLostList.value,
                                            child: Row(
                                              children: [
                                                SingleChildScrollView(
                                                  child: Container(
                                                    width:
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        2 -
                                                        25,
                                                    height: 100,
                                                    margin: EdgeInsets.fromLTRB(
                                                        12, 4, 12, 0),
                                                    padding:
                                                    EdgeInsets.fromLTRB(
                                                        6, 4, 6, 6),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppTheme
                                                            .inputBorderColor,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      color: Colors
                                                          .white, // Set the desired background color
                                                    ),
                                                    child:
                                                    SingleChildScrollView(
                                                      child: IntrinsicHeight(
                                                        child: Column(
                                                          children:
                                                          List.generate(
                                                            controller
                                                                .tenderLostListDetails
                                                                .length,
                                                                (index) {
                                                              var model = controller
                                                                  .tenderLostListDetails[
                                                              index];
                                                              return Container(
                                                                child: Column(
                                                                  children: [
                                                                    TextInput(
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .tenderLostDropDownController
                                                                            .text =
                                                                        controller
                                                                            .tenderLostListDetails[
                                                                        index];

                                                                        controller
                                                                            .tenderLostList
                                                                            .value =
                                                                        false;
                                                                        controller
                                                                            .tenderLostListDetails
                                                                            .clear();
                                                                      },
                                                                      margin:
                                                                      false,
                                                                      isSelected: controller
                                                                          .tenderLostDropDownController
                                                                          .text ==
                                                                          controller
                                                                              .tenderLostListDetails[index],
                                                                      label: "",
                                                                      isEntryField:
                                                                      false,
                                                                      textInputType:
                                                                      TextInputType
                                                                          .text,
                                                                      textColor:
                                                                      Color(
                                                                          0xCC234345),
                                                                      hintText:
                                                                      model,
                                                                      obscureText:
                                                                      true,
                                                                      onTextChange:
                                                                          (
                                                                          String) {},
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Visibility(
                                                                        visible: controller
                                                                            .tenderLostListDetails
                                                                            .length !=
                                                                            index +
                                                                                1,
                                                                        child:
                                                                        Container(
                                                                          height:
                                                                          1,
                                                                          color:
                                                                          AppTheme
                                                                              .grey,
                                                                        ))
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Text(
                                          "Competitor Name",
                                          style: TextStyle(
                                              color: Color(0xff828282)),
                                        ),
                                      ),
                                      SizedBox(width: 60),
                                      Text(
                                        "Quote Amount",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          controller: controller
                                              .competitorNameController,

                                          onPressed: () {},
                                          textInputType: TextInputType.text,
                                          textColor: Color(0xCC252525),
                                          hintText: "Competitor Name ",
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
                                          controller:
                                          controller.quoteAmountController,
                                          //height: 70,
                                          //label: "Ideas",
                                          onPressed: () {},
                                          textInputType: TextInputType.text,
                                          textColor: Color(0xCC252525),
                                          hintText: "Quote Amount",
                                          //obscureText: true,

                                          onTextChange: (general) {
                                            // controller.popUpValue.value = true;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 398,
                            height: 155,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "SD DATE WITH AMOUNT/ BANK GAURANTEE/BILL DEDUCTION",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff272727)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Test",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 80),
                                    Text(
                                      "Documents",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller:
                                        controller.billDeductionController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Bill Deduction",
                                        //obscureText: true,

                                        onTextChange: (general) {
                                          // controller.popUpValue.value = true;
                                        },
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 155,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1)),
                                          margin: EdgeInsets.only(
                                              top: 8, left: 2, right: 4),
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
                                                        controller
                                                            .BillDeductionFilePickFile(
                                                            context);
                                                      },
                                                      child: Container(
                                                        width: 64,
                                                        height: 25,
                                                        margin:
                                                        EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: AppTheme
                                                                .secondaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                4)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                        child: Center(
                                                          child: Text("Browser",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () =>
                                                      controller
                                                          .isFileSelected
                                                          .value &&
                                                          controller
                                                              .billDeductionFile !=
                                                              null
                                                          ? Row(
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            child:
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                              Axis.horizontal,
                                                              child: Text(
                                                                  controller
                                                                      .billDeductionFile!
                                                                      .path
                                                                      .split(
                                                                      '/')
                                                                      .last,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                      color: AppTheme
                                                                          .appBlack,
                                                                      fontSize:
                                                                      12,
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
                                                            style: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                8,
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
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            width: 398,
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "BOQ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Test",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 80),
                                    Text(
                                      "Documents",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller:
                                        controller.bqoRemarksController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "BOQ Remark",
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1)),
                                          margin: EdgeInsets.only(
                                              top: 8, left: 2, right: 4),
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
                                                        controller.BOQPickFile(
                                                            context);
                                                      },
                                                      child: Container(
                                                        width: 64,
                                                        height: 25,
                                                        margin:
                                                        EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: AppTheme
                                                                .secondaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                4)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                        child: Center(
                                                          child: Text("Browser",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () =>
                                                      controller
                                                          .isFileSelected
                                                          .value &&
                                                          controller
                                                              .boqFile !=
                                                              null
                                                          ? Row(
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            child:
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                              Axis.horizontal,
                                                              child: Text(
                                                                  controller
                                                                      .boqFile!
                                                                      .path
                                                                      .split(
                                                                      '/')
                                                                      .last,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                      color: AppTheme
                                                                          .appBlack,
                                                                      fontSize:
                                                                      12,
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
                                                            style: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                8,
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
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            width: 398,
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Project Details",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Test",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 80),
                                    Text(
                                      "Documents",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .projectDetailsRemarksController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Project Details Reamrks",
                                        //obscureText: true,

                                        onTextChange: (general) {
                                          // controller.popUpValue.value = true;
                                        },
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 155,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1)),
                                          margin: EdgeInsets.only(
                                              top: 8, left: 2, right: 4),
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
                                                        controller
                                                            .ProjectDetailsPickFile(
                                                            context);
                                                      },
                                                      child: Container(
                                                        width: 64,
                                                        height: 25,
                                                        margin:
                                                        EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: AppTheme
                                                                .secondaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                4)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                        child: Center(
                                                          child: Text("Browser",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () =>
                                                      controller
                                                          .isFileSelected
                                                          .value &&
                                                          controller
                                                              .projectDetailsFile !=
                                                              null
                                                          ? Row(
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            child:
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                              Axis.horizontal,
                                                              child: Text(
                                                                  controller
                                                                      .projectDetailsFile!
                                                                      .path
                                                                      .split(
                                                                      '/')
                                                                      .last,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                      color: AppTheme
                                                                          .appBlack,
                                                                      fontSize:
                                                                      12,
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
                                                            style: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                8,
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
                        SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 398,
                            height: 155,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8.0),
                                      child: Text(
                                        "Work Order / LOA",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Test",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 80),
                                    Text(
                                      "Documents",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .workOrderRemarksController,
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Work LOA Remark",
                                        onTextChange: (general) {
                                          // controller.popUpValue.value = true;
                                        },
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 155,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1)),
                                          margin: EdgeInsets.only(
                                              top: 8, left: 2, right: 4),
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
                                                        controller
                                                            .WorKOrderPickFile(
                                                            context);
                                                      },
                                                      child: Container(
                                                        width: 64,
                                                        height: 25,
                                                        margin:
                                                        EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: AppTheme
                                                                .secondaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                4)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                        child: Center(
                                                          child: Text("Browser",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () =>
                                                      controller
                                                          .isFileSelected
                                                          .value &&
                                                          controller
                                                              .workOrderFile !=
                                                              null
                                                          ? Row(
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            child:
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                              Axis.horizontal,
                                                              child: Text(
                                                                  controller
                                                                      .workOrderFile!
                                                                      .path
                                                                      .split(
                                                                      '/')
                                                                      .last,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                      color: AppTheme
                                                                          .appBlack,
                                                                      fontSize:
                                                                      12,
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
                                                            style: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                8,
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
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 398,
                            height: 155,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8.0),
                                      child: Text(
                                        "Profile Drawing",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Test",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 90),
                                    Text(
                                      "Profile Drawing",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .profileDrawingRemarksController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: " Profile Drawing Remarks",
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
                                        controller:
                                        controller.profileDrawingController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Profile Drawing",
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 398,
                            height: 155,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8.0),
                                      child: Text(
                                        "Agreement",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Test",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 80),
                                    Text(
                                      "Documents",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .agreementRemarksController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Agreement Remark",
                                        //obscureText: true,

                                        onTextChange: (general) {
                                          // controller.popUpValue.value = true;
                                        },
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 155,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1)),
                                          margin: EdgeInsets.only(
                                              top: 8, left: 2, right: 4),
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
                                                        controller
                                                            .AgreementPickFile(
                                                            context);
                                                      },
                                                      child: Container(
                                                        width: 64,
                                                        height: 25,
                                                        margin:
                                                        EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: AppTheme
                                                                .secondaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                4)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                        child: Center(
                                                          child: Text("Browser",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () =>
                                                      controller
                                                          .isFileSelected
                                                          .value &&
                                                          controller
                                                              .agreementFile !=
                                                              null
                                                          ? Row(
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            child:
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                              Axis.horizontal,
                                                              child: Text(
                                                                  controller
                                                                      .agreementFile!
                                                                      .path
                                                                      .split(
                                                                      '/')
                                                                      .last,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                      color: AppTheme
                                                                          .appBlack,
                                                                      fontSize:
                                                                      12,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                          : Expanded(
                                                        child: Text(
                                                            "No file chosen",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                8,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 398,
                            height: 155,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0, top: 8.0),
                                        child: Text(
                                          "Sub Contract",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff272727)),
                                        ),
                                      )
                                    ],
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
                                            if (controller
                                                .subContractList.value) {
                                              controller.subContractList.value =
                                              false;
                                            } else {
                                              controller.subContractList.value =
                                              true;
                                            }

                                            controller.subContractListDetails
                                                .add('Yes');
                                            controller.subContractListDetails
                                                .add('No');
                                          },
                                          controller:
                                          controller.subContractController,
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          obscureText: true,
                                          isReadOnly: true,
                                          hintText: "No",
                                          onTextChange: (string) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(() =>
                                      Visibility(
                                        visible:
                                        controller.subContractList.value,
                                        child: Row(
                                          children: [
                                            SingleChildScrollView(
                                              child: Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width /
                                                    2 -
                                                    25,
                                                margin: EdgeInsets.fromLTRB(
                                                    12, 4, 12, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    6, 4, 6, 6),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppTheme
                                                        .inputBorderColor,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  color: Colors
                                                      .white, // Set the desired background color
                                                ),
                                                child: IntrinsicHeight(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: List.generate(
                                                        controller
                                                            .subContractListDetails
                                                            .length,
                                                            (index) {
                                                          var model = controller
                                                              .subContractListDetails[
                                                          index];
                                                          return Container(
                                                            child: Column(
                                                              children: [
                                                                TextInput(
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .subContractController
                                                                        .text =
                                                                    controller
                                                                        .subContractListDetails[
                                                                    index];
                                                                    if (controller
                                                                        .subContractController
                                                                        .text ==
                                                                        'Yes') {
                                                                      controller
                                                                          .subContractYes
                                                                          .value =
                                                                      true;
                                                                    } else {
                                                                      controller
                                                                          .subContractYes
                                                                          .value =
                                                                      false;
                                                                    }

                                                                    controller
                                                                        .subContractList
                                                                        .value =
                                                                    false;
                                                                    controller
                                                                        .subContractListDetails
                                                                        .clear();
                                                                  },
                                                                  margin: false,
                                                                  isSelected: controller
                                                                      .subContractController
                                                                      .text ==
                                                                      controller
                                                                          .subContractListDetails[
                                                                      index],
                                                                  label: "",
                                                                  isEntryField:
                                                                  false,
                                                                  textInputType:
                                                                  TextInputType
                                                                      .text,
                                                                  textColor: Color(
                                                                      0xCC234345),
                                                                  hintText:
                                                                  model,
                                                                  obscureText:
                                                                  true,
                                                                  onTextChange:
                                                                      (
                                                                      String) {},
                                                                ),
                                                                const SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Visibility(
                                                                    visible: controller
                                                                        .subContractListDetails
                                                                        .length !=
                                                                        index +
                                                                            1,
                                                                    child:
                                                                    Container(
                                                                      height: 1,
                                                                      color: AppTheme
                                                                          .grey,
                                                                    ))
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Obx(() =>
                            Visibility(
                                visible: controller.subContractYes.value,
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Container(
                                    width: 398,
                                    height: 840,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color: Colors
                                                                .grey.shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                        child: Text(
                                                          'SubHDD',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff828282)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color: Colors
                                                                .grey.shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                        child: Text(
                                                          'SubEscavatorsSmall',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff828282)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 50),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            /* setState(() {
                                      _isChecked1 = value!;
                                    });*/

                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color: Colors
                                                                .grey.shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                        child: Text(
                                                          'SubHydraBig',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff828282)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color: Colors
                                                                .grey.shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                        child: Text(
                                                          'SubHydraSmall',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff828282)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            /* setState(() {
                                                                              _isChecked1 = value!;
                                                                            });*/

                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color:
                                                            Colors.grey
                                                                .shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'SubGenerator',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff828282)),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color:
                                                            Colors.grey
                                                                .shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                        child: Text(
                                                          'SubWeldingMachine',
                                                          style: TextStyle(
                                                              color:
                                                              Color(
                                                                  0xff828282)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 13),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            /* setState(() {
                                                                              _isChecked1 = value!;
                                                                            });*/

                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color:
                                                            Colors.grey
                                                                .shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'SubClamp',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff828282)),
                                                      ),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color:
                                                            Colors.grey
                                                                .shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                        child: Text(
                                                          'SubGrindingMachine',
                                                          style: TextStyle(
                                                              color:
                                                              Color(
                                                                  0xff828282)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 58),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            /* setState(() {
                                                                              _isChecked1 = value!;
                                                                            });*/

                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color:
                                                            Colors.grey
                                                                .shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'SubRollersSmall',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff828282)),
                                                      ),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color:
                                                            Colors.grey
                                                                .shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                        child: Text(
                                                          'SubRollersBig',
                                                          style: TextStyle(
                                                              color:
                                                              Color(
                                                                  0xff828282)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 27),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            /* setState(() {
                                                                              _isChecked1 = value!;
                                                                            });*/

                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color:
                                                            Colors.grey
                                                                .shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'SubDrumStands',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff828282)),
                                                      ),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color:
                                                            Colors.grey
                                                                .shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                        child: Text(
                                                          'SubWinchMachine',
                                                          style: TextStyle(
                                                              color:
                                                              Color(
                                                                  0xff828282)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            /* setState(() {
                                                                              _isChecked1 = value!;
                                                                            });*/

                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color:
                                                            Colors.grey
                                                                .shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'SubManPower',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff828282)),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 15,),
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (
                                                              bool? value) {
                                                            // Handle checkbox state change
                                                          },
                                                          side: BorderSide(
                                                            color:
                                                            Colors.grey
                                                                .shade400,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                        child: Text(
                                                          'SubGradles',
                                                          style: TextStyle(
                                                              color:
                                                              Color(
                                                                  0xff828282)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding:
                                          EdgeInsets.only(left: 12.0, top: 8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "SUB CONTRACT NAME",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff272727)),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 12),
                                              child: Text(
                                                "Remark Test",
                                                style: TextStyle(
                                                    color: Color(0xff828282)),
                                              ),
                                            ),
                                            SizedBox(width: 95),
                                            Text(
                                              "Sub Contract Name",
                                              style: TextStyle(
                                                  color: Color(0xff828282)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 170,
                                              child: TextInput2(
                                                controller: controller
                                                    .subContractNameRemarksController,
                                                //height: 70,
                                                //label: "Ideas",
                                                onPressed: () {},
                                                textInputType: TextInputType
                                                    .text,
                                                textColor: Color(0xCC252525),
                                                hintText:
                                                "Sub Contract Name Remarks",
                                                //obscureText: true,

                                                onTextChange: (general) {
                                                  // controller.popUpValue.value = true;
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 170,
                                              child: TextInput2(
                                                height: 100,
                                                /* label: "Type",*/
                                                onPressed: () {},
                                                controller: controller
                                                    .sunContractNameController,
                                                textInputType: TextInputType
                                                    .number,
                                                textColor: Color(0xCC252525),
                                                hintText: "Sub Contract Name",
                                                onTextChange: (string) {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding:
                                          EdgeInsets.only(left: 12.0, top: 8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "SUB CONTRACT ORDER",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff272727)),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 12),
                                              child: Text(
                                                "Remark Test",
                                                style: TextStyle(
                                                    color: Color(0xff828282)),
                                              ),
                                            ),
                                            SizedBox(width: 100),
                                            Text(
                                              "Sub Contract Order",
                                              style: TextStyle(
                                                  color: Color(0xff828282)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 170,
                                              child: TextInput2(
                                                controller: controller
                                                    .subContractOrderRemarkController,

                                                onPressed: () {},
                                                textInputType: TextInputType
                                                    .text,
                                                textColor: Color(0xCC252525),
                                                hintText:
                                                "Sub Contract Order Remarks",
                                                //obscureText: true,

                                                onTextChange: (general) {
                                                  // controller.popUpValue.value = true;
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 170,
                                              child: TextInput2(
                                                controller: controller
                                                    .subContractOrderController,

                                                onPressed: () {},
                                                textInputType: TextInputType
                                                    .text,
                                                textColor: Color(0xCC252525),
                                                hintText: "Sub Contract Order",
                                                //obscureText: true,

                                                onTextChange: (general) {
                                                  // controller.popUpValue.value = true;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding:
                                          EdgeInsets.only(left: 12.0, top: 8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "SCOPE OF WORK IN CASE OF SUB CONTRACT",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff272727)),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 12),
                                              child: Text(
                                                "Remark Test",
                                                style: TextStyle(
                                                    color: Color(0xff828282)),
                                              ),
                                            ),
                                            SizedBox(width: 100),
                                            Expanded(
                                              child: Text(
                                                "Scope of Work in Case of Sub Contract",
                                                style: TextStyle(
                                                    color: Color(0xff828282)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 170,
                                              child: TextInput2(
                                                controller: controller
                                                    .scopeOfWorkSubContractOrderRemarkController,

                                                onPressed: () {},
                                                textInputType: TextInputType
                                                    .text,
                                                textColor: Color(0xCC252525),
                                                hintText:
                                                "Scope of Work in Case of Sub Contract Remarks",
                                                //obscureText: true,

                                                onTextChange: (general) {
                                                  // controller.popUpValue.value = true;
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 170,
                                              child: TextInput2(
                                                controller: controller
                                                    .scopeOfWorkSubContractOrderController,

                                                onPressed: () {},
                                                textInputType: TextInputType
                                                    .text,
                                                textColor: Color(0xCC252525),
                                                hintText: "Sub Contract Order",
                                                //obscureText: true,

                                                onTextChange: (general) {
                                                  // controller.popUpValue.value = true;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ))),

                        const SizedBox(
                          height: 5,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     width: 398,
                        //     height: 155,
                        //
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(4)
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                        //               child: Text("Work Order / LOA",style: TextStyle(fontSize: 14,
                        //                   fontWeight: FontWeight.w400,
                        //                   color: Color(0xff272727)),),
                        //             )
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 8,
                        //         ),
                        //         const Row(
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left:12 ),
                        //               child: Text("Remark Test",style: TextStyle(
                        //                   color: Color(0xff828282)
                        //               ),),
                        //             ),
                        //             SizedBox(
                        //                 width: 80
                        //             ),
                        //             Text("Documents",style: TextStyle(
                        //                 color: Color(0xff828282)
                        //             ),),
                        //           ],
                        //         ),
                        //         Row(
                        //           children: [
                        //             Container(
                        //               width: 170,
                        //               child: TextInput2(
                        //                 controller: controller.remarkoneController,
                        //                 //height: 70,
                        //                 //label: "Ideas",
                        //                 onPressed: () {},
                        //                 textInputType: TextInputType.text,
                        //                 textColor: Color(0xCC252525),
                        //                 hintText: "",
                        //                 //obscureText: true,
                        //
                        //                 onTextChange: (general) {
                        //                   // controller.popUpValue.value = true;
                        //                 },
                        //               ),
                        //               // decoration: BoxDecoration(
                        //               //   color: Colors.white,
                        //               //   border: Border.all(color: Colors.grey.shade400,width: 1),
                        //               //   borderRadius: BorderRadius.circular(4),
                        //               // ),
                        //
                        //             ),
                        //
                        //             Row(
                        //               children: [
                        //                 Container(
                        //                   height: 45,
                        //                   width: 155,
                        //                   decoration: BoxDecoration(
                        //                       borderRadius:
                        //                       BorderRadius.all(Radius.circular(4)),
                        //
                        //                       border:
                        //                       Border.all(color: Colors.grey.shade400,width: 1)),
                        //                   margin:
                        //                   EdgeInsets.only(top: 8, left: 2, right: 4),
                        //                   child: GestureDetector(
                        //                       onTap: () {
                        //                         // pickFile(context);
                        //                       },
                        //                       child: Container(
                        //                         /*margin: EdgeInsets.symmetric(horizontal: 2),*/
                        //                         child: Row(
                        //                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                           children: [
                        //                             GestureDetector(
                        //                               onTap: () {
                        //                                 controller.pickFile(context);
                        //                               },
                        //                               child: Container(
                        //                                 width: 64,
                        //                                 height: 25,
                        //
                        //                                 margin: EdgeInsets.all(10),
                        //                                 decoration: BoxDecoration(
                        //                                     color: AppTheme.secondaryColor,
                        //
                        //                                     borderRadius:
                        //                                     BorderRadius.all(
                        //                                         Radius.circular(4)),
                        //                                     border: Border.all(
                        //                                         color: Colors.grey.shade400
                        //                                     )),
                        //                                 child: Center(
                        //                                   child: Text("Browser",
                        //                                       style: GoogleFonts.poppins(
                        //                                           color:
                        //                                           AppTheme.white,
                        //                                           fontSize: 10,
                        //                                           fontWeight:
                        //                                           FontWeight.w400)),
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                             Obx(
                        //                                   () => controller
                        //                                   .isFileSelected.value &&
                        //                                   controller.file != null
                        //                                   ? Row(
                        //                                 children: [
                        //                                   Container(
                        //                                     width: 60,
                        //                                     child: SingleChildScrollView(
                        //                                       scrollDirection:
                        //                                       Axis.horizontal,
                        //                                       child: Text(
                        //                                           controller
                        //                                               .file!.path
                        //                                               .split('/')
                        //                                               .last,
                        //                                           style: GoogleFonts.poppins(
                        //                                               color: AppTheme
                        //                                                   .appBlack,
                        //                                               fontSize: 12,
                        //                                               fontWeight:
                        //                                               FontWeight
                        //                                                   .w600)),
                        //                                     ),
                        //                                   ),
                        //                                 ],
                        //                               )
                        //                                   : Expanded(
                        //                                 child: Text(
                        //                                     "No file choosen",
                        //                                     style:
                        //                                     GoogleFonts.poppins(
                        //                                         color: Colors
                        //                                             .black,
                        //                                         fontSize: 8,
                        //                                         fontWeight:
                        //                                         FontWeight
                        //                                             .w600)),
                        //                               ),
                        //                             )
                        //                           ],
                        //                         ),
                        //                       )),
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 398,
                            height: 700,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8.0),
                                      child: Text(
                                        "Our Scope of Work",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Test",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .ourSpaceRemarksController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Our Space Remark",
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
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color: Colors
                                                    .grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              'HDD',
                                              style: TextStyle(
                                                  color: Color(
                                                      0xff828282)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color: Colors
                                                    .grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              'EscavatorsSmall',
                                              style: TextStyle(
                                                  color: Color(
                                                      0xff828282)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 50),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                /* setState(() {
                                      _isChecked1 = value!;
                                    });*/

                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color: Colors
                                                    .grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              'HydraBig',
                                              style: TextStyle(
                                                  color: Color(
                                                      0xff828282)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color: Colors
                                                    .grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              'HydraSmall',
                                              style: TextStyle(
                                                  color: Color(
                                                      0xff828282)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                /* setState(() {
                                                                              _isChecked1 = value!;
                                                                            });*/

                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color:
                                                Colors.grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Generator',
                                            style: TextStyle(
                                                color: Color(0xff828282)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color:
                                                Colors.grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              'WeldingMachine',
                                              style: TextStyle(
                                                  color:
                                                  Color(0xff828282)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20, right: 13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                /* setState(() {
                                                                              _isChecked1 = value!;
                                                                            });*/

                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color:
                                                Colors.grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Clamp',
                                            style: TextStyle(
                                                color: Color(0xff828282)),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color:
                                                Colors.grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              'GrindingMachine',
                                              style: TextStyle(
                                                  color:
                                                  Color(0xff828282)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20, right: 58),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                /* setState(() {
                                                                              _isChecked1 = value!;
                                                                            });*/

                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color:
                                                Colors.grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'RollersSmall',
                                            style: TextStyle(
                                                color: Color(0xff828282)),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color:
                                                Colors.grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              'RollersBig',
                                              style: TextStyle(
                                                  color:
                                                  Color(0xff828282)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 27),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                /* setState(() {
                                                                              _isChecked1 = value!;
                                                                            });*/

                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color:
                                                Colors.grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'DrumStands',
                                            style: TextStyle(
                                                color: Color(0xff828282)),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color:
                                                Colors.grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              'WinchMachine',
                                              style: TextStyle(
                                                  color:
                                                  Color(0xff828282)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 75),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                /* setState(() {
                                                                              _isChecked1 = value!;
                                                                            });*/

                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color:
                                                Colors.grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'ManPower',
                                            style: TextStyle(
                                                color: Color(0xff828282)),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (bool? value) {
                                                // Handle checkbox state change
                                              },
                                              side: BorderSide(
                                                color:
                                                Colors.grey.shade400,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              'Gradles',
                                              style: TextStyle(
                                                  color:
                                                  Color(0xff828282)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Others if any",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller.othersController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Others",
                                        //obscureText: true,

                                        onTextChange: (general) {
                                          // controller.popUpValue.value = true;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 398,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Own Machine or Subcontract",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff272727)),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Test",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 85),
                                    Text(
                                      "Own Machine or Subcontract",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .ownMachineOrSubContactRemarksController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Own Machine Or Sub Contract Remarks",
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
                                        height: 100,
                                        controller: controller
                                            .ownMachineOrSubContactController,
                                        /* label: "Type",*/
                                        onPressed: () {
                                          if (controller
                                              .ownMachineOrSubContractList
                                              .value) {
                                            controller
                                                .ownMachineOrSubContractList
                                                .value = false;
                                          } else {
                                            controller
                                                .ownMachineOrSubContractList
                                                .value = true;
                                          }

                                          controller
                                              .ownMachineOrSubContractListDetails
                                              .add('Own Machine');
                                          controller
                                              .ownMachineOrSubContractListDetails
                                              .add('Sub Contract');
                                        },
                                        //  controller: controller.typeController,
                                        textInputType: TextInputType.number,
                                        textColor: Color(0xCC252525),
                                        obscureText: true,
                                        isReadOnly: true,
                                        hintText: "Own Machine Or Sub Contract",
                                        onTextChange: (string) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Obx(() =>
                                        Visibility(
                                          visible:
                                          controller.ownMachineOrSubContractList
                                              .value,
                                          child: Row(
                                            children: [
                                              SingleChildScrollView(
                                                child: Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width /
                                                      2 -
                                                      25,
                                                  height: 60,
                                                  margin: EdgeInsets.fromLTRB(
                                                      12, 4, 12, 0),
                                                  padding: EdgeInsets.fromLTRB(
                                                      6, 4, 6, 6),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppTheme
                                                          .inputBorderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                    color: Colors
                                                        .white, // Set the desired background color
                                                  ),
                                                  child: IntrinsicHeight(
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        children: List.generate(
                                                          controller
                                                              .ownMachineOrSubContractListDetails
                                                              .length,
                                                              (index) {
                                                            var model = controller
                                                                .ownMachineOrSubContractListDetails[
                                                            index];
                                                            return Container(
                                                              child: Column(
                                                                children: [
                                                                  TextInput(
                                                                    onPressed:
                                                                        () {
                                                                      controller
                                                                          .ownMachineOrSubContactController
                                                                          .text =
                                                                      controller
                                                                          .ownMachineOrSubContractListDetails[
                                                                      index];

                                                                      controller
                                                                          .ownMachineOrSubContractList
                                                                          .value =
                                                                      false;
                                                                      controller
                                                                          .ownMachineOrSubContractListDetails
                                                                          .clear();
                                                                    },
                                                                    margin: false,
                                                                    isSelected: controller
                                                                        .ownMachineOrSubContactController
                                                                        .text ==
                                                                        controller
                                                                            .ownMachineOrSubContractListDetails[
                                                                        index],
                                                                    label: "",
                                                                    isEntryField:
                                                                    false,
                                                                    textInputType:
                                                                    TextInputType
                                                                        .text,
                                                                    textColor: Color(
                                                                        0xCC234345),
                                                                    hintText:
                                                                    model,
                                                                    obscureText:
                                                                    true,
                                                                    onTextChange:
                                                                        (
                                                                        String) {},
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  Visibility(
                                                                      visible: controller
                                                                          .ownMachineOrSubContractListDetails
                                                                          .length !=
                                                                          index +
                                                                              1,
                                                                      child:
                                                                      Container(
                                                                        height: 1,
                                                                        color: AppTheme
                                                                            .grey,
                                                                      ))
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 398,
                            height: 180,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8.0),
                                      child: Text(
                                        "Billing Details",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Test",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 80),
                                    Text(
                                      "Documents",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .billingDetailsRemarksController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Billing Remarks",
                                        //obscureText: true,

                                        onTextChange: (general) {
                                          // controller.popUpValue.value = true;
                                        },
                                      ),

                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 155,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1)),
                                          margin: EdgeInsets.only(
                                              top: 8, left: 2, right: 4),
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
                                                        controller
                                                            .BillingPickFile(
                                                            context);
                                                      },
                                                      child: Container(
                                                        width: 64,
                                                        height: 25,
                                                        margin:
                                                        EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: AppTheme
                                                                .secondaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                4)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                        child: Center(
                                                          child: Text(
                                                              "Choose file",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () =>
                                                      controller
                                                          .isFileSelected
                                                          .value &&
                                                          controller
                                                              .billingFile !=
                                                              null
                                                          ? Row(
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            child:
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                              Axis.horizontal,
                                                              child: Text(
                                                                  controller
                                                                      .billingFile!
                                                                      .path
                                                                      .split(
                                                                      '/')
                                                                      .last,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                      color: AppTheme
                                                                          .appBlack,
                                                                      fontSize:
                                                                      12,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                          : Expanded(
                                                        child: Text(
                                                            "No file chosen",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                8,
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
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 09),
                                      child: Container(
                                        width: 133,
                                        height: 27,
                                        child: Center(
                                          child: Text(
                                            "Open Bill Chat Box",
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.secondaryColor,
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            width: 398,
                            height: 144,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Padding(
                                    padding:
                                    EdgeInsets.only(left: 12.0, top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Flow of Bills",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff272727)),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Text(
                                          "Remark Test",
                                          style:
                                          TextStyle(color: Color(0xff828282)),
                                        ),
                                      ),
                                      SizedBox(width: 95),
                                      Text(
                                        "Flow of Bills",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          controller: controller
                                              .remarksFlowOfBillsController,
                                          //height: 70,
                                          //label: "Ideas",
                                          onPressed: () {},
                                          textInputType: TextInputType.text,
                                          textColor: Color(0xCC252525),
                                          hintText: "Remarks Flow Of Bills",
                                          //obscureText: true,

                                          onTextChange: (general) {
                                            // controller.popUpValue.value = true;
                                          },
                                        ),

                                      ),
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          height: 100,
                                          controller:
                                          controller.flowOfBillsController,
                                          /* label: "Type",*/

                                          onPressed: () {
                                            if (controller.flowOfBillsList
                                                .value) {
                                              controller.flowOfBillsList.value =
                                              false;
                                            } else {
                                              controller.flowOfBillsList.value =
                                              true;
                                            }
                                          },
                                          //  controller: controller.typeController,
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          obscureText: true,
                                          isReadOnly: true,
                                          hintText: "Flow of Bills",
                                          onTextChange: (string) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Obx(() =>
                                          Visibility(
                                            visible:
                                            controller.flowOfBillsList.value,
                                            child: Row(
                                              children: [
                                                SingleChildScrollView(
                                                  child: Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        2 -
                                                        25,
                                                    height: 100,
                                                    margin: EdgeInsets.fromLTRB(
                                                        12, 4, 12, 0),
                                                    padding: EdgeInsets
                                                        .fromLTRB(
                                                        6, 4, 6, 6),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppTheme
                                                            .inputBorderColor,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                      color: Colors
                                                          .white, // Set the desired background color
                                                    ),
                                                    child: IntrinsicHeight(
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          children: List
                                                              .generate(
                                                            controller
                                                                .flowOfBillDropdownResponse
                                                                .length,
                                                                (index) {
                                                              var model = controller
                                                                  .flowOfBillDropdownResponse[
                                                              index];
                                                              return Container(
                                                                child: Column(
                                                                  children: [
                                                                    TextInput(
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .flowOfBillsController
                                                                            .text =
                                                                        controller
                                                                            .flowOfBillDropdownResponse[
                                                                        index]
                                                                            .flowOfBill!;

                                                                        controller
                                                                            .flowOfBillsList
                                                                            .value =
                                                                        false;
                                                                        controller
                                                                            .flowOfBillDropdownResponse
                                                                            .clear();
                                                                      },
                                                                      margin: false,
                                                                      isSelected: controller
                                                                          .flowOfBillsController
                                                                          .text ==
                                                                          controller
                                                                              .flowOfBillDropdownResponse[
                                                                          index]
                                                                              .flowOfBill,
                                                                      label: "",
                                                                      isEntryField:
                                                                      false,
                                                                      textInputType:
                                                                      TextInputType
                                                                          .text,
                                                                      textColor: Color(
                                                                          0xCC234345),
                                                                      hintText:
                                                                      model
                                                                          .flowOfBill,
                                                                      obscureText:
                                                                      true,
                                                                      onTextChange:
                                                                          (
                                                                          String) {},
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Visibility(
                                                                        visible: controller
                                                                            .flowOfBillDropdownResponse
                                                                            .length !=
                                                                            index +
                                                                                1,
                                                                        child:
                                                                        Container(
                                                                          height: 1,
                                                                          color: AppTheme
                                                                              .grey,
                                                                        ))
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],),

                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            width: 398,
                            height: 288,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Padding(
                                    padding:
                                    EdgeInsets.only(left: 12.0, top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Payment Received",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff272727)),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Text(
                                          "Remark Test",
                                          style:
                                          TextStyle(color: Color(0xff828282)),
                                        ),
                                      ),
                                      SizedBox(width: 95),
                                      Text(
                                        "Payment Received",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          controller: controller
                                              .paymentReceivedRemarksController,
                                          //height: 70,
                                          //label: "Ideas",
                                          onPressed: () {},
                                          textInputType: TextInputType.text,
                                          textColor: Color(0xCC252525),
                                          hintText: "Payment Received Remarks",
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
                                          controller: controller
                                              .paymentReceivedController,
                                          //height: 70,
                                          //label: "Ideas",
                                          onPressed: () {},
                                          textInputType: TextInputType.text,
                                          textColor: Color(0xCC252525),
                                          hintText: "Payment Received",
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
                                  SizedBox(
                                    height: 8,
                                  ),
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Text(
                                          "Deduction Type",
                                          style:
                                          TextStyle(color: Color(0xff828282)),
                                        ),
                                      ),
                                      SizedBox(width: 72),
                                      Text(
                                        "Deduction amount",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          height: 100,
                                          controller:
                                          controller.deductionTypeController,
                                          /* label: "Type",*/
                                          onPressed: () {
                                            if (controller.deductionTypeList
                                                .value) {
                                              controller.deductionTypeList
                                                  .value = false;
                                            } else {
                                              controller.deductionTypeList
                                                  .value = true;
                                            }
                                          },
                                          //  controller: controller.typeController,
                                          textInputType: TextInputType.number,
                                          textColor: Color(0xCC252525),
                                          obscureText: true,
                                          isReadOnly: true,
                                          hintText: "Deduction Type",

                                          onTextChange: (string) {},
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        child: TextInput2(
                                          controller: controller
                                              .deductionAmountController,
                                          //height: 70,
                                          //label: "Ideas",
                                          onPressed: () {},
                                          textInputType: TextInputType.text,
                                          textColor: Color(0xCC252525),
                                          hintText: "Deduction Amount",
                                          //obscureText: true,

                                          onTextChange: (general) {
                                            // controller.popUpValue.value = true;
                                          },
                                        ),

                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Obx(() =>
                                          Visibility(
                                            visible:
                                            controller.deductionTypeList.value,
                                            child: Row(
                                              children: [
                                                SingleChildScrollView(
                                                  child: Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        2 -
                                                        25,
                                                    height: 100,
                                                    margin: EdgeInsets.fromLTRB(
                                                        12, 4, 12, 0),
                                                    padding: EdgeInsets
                                                        .fromLTRB(
                                                        6, 4, 6, 6),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppTheme
                                                            .inputBorderColor,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                      color: Colors
                                                          .white, // Set the desired background color
                                                    ),
                                                    child: IntrinsicHeight(
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          children: List
                                                              .generate(
                                                            controller
                                                                .deductionDropDownResponseModel
                                                                .length,
                                                                (index) {
                                                              var model = controller
                                                                  .deductionDropDownResponseModel[
                                                              index];
                                                              return Container(
                                                                child: Column(
                                                                  children: [
                                                                    TextInput(
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .deductionTypeController
                                                                            .text =
                                                                        controller
                                                                            .deductionDropDownResponseModel[
                                                                        index]
                                                                            .deductionName!;

                                                                        controller
                                                                            .deductionTypeList
                                                                            .value =
                                                                        false;
                                                                      },
                                                                      margin: false,
                                                                      isSelected: controller
                                                                          .deductionTypeController
                                                                          .text ==
                                                                          controller
                                                                              .deductionDropDownResponseModel[
                                                                          index]
                                                                              .deductionName,
                                                                      label: "",
                                                                      isEntryField:
                                                                      false,
                                                                      textInputType:
                                                                      TextInputType
                                                                          .text,
                                                                      textColor: Color(
                                                                          0xCC234345),
                                                                      hintText:
                                                                      model
                                                                          .deductionName,
                                                                      obscureText:
                                                                      true,
                                                                      onTextChange:
                                                                          (
                                                                          String) {},
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Visibility(
                                                                        visible: controller
                                                                            .deductionDropDownResponseModel
                                                                            .length !=
                                                                            index +
                                                                                1,
                                                                        child:
                                                                        Container(
                                                                          height: 1,
                                                                          color: AppTheme
                                                                              .grey,
                                                                        ))
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(right: 9.0),
                                          child: Container(
                                            width: 80,
                                            height: 33,
                                            decoration: BoxDecoration(
                                                color: AppTheme.secondaryColor,
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                    AppTheme.secondaryColor)),
                                            child: const Center(
                                                child: Text(
                                                  "Add",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme.white,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            width: 398,
                            height: 270,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "EMD Retention Receivable Data",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Text",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 90),
                                    Text(
                                      "Amount",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .emdRetentionRemarksController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Emd Retention Remarks",
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
                                        controller: controller
                                            .emdRetentionAmountController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "EMD Retention Amount ",
                                        //obscureText: true,

                                        onTextChange: (general) {
                                          // controller.popUpValue.value = true;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "EMD/SD Retention",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff828282)),
                                      )
                                    ],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Receivable Data",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 75),
                                    Text(
                                      "EMD Documents",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 165,
                                      child: TextInput2(
                                        onPressed: () {
                                          controller.emdRetentionDate(context);
                                        },
                                        controller: controller
                                            .emdRetentionReceivableDataDateController,
                                        height: 100,
                                        isReadOnly: true,
                                        /* label: "Customer requirement Date",*/
                                        onTextChange: (text) {},
                                        textInputType: TextInputType.phone,
                                        textColor: Color(0xCC252525),
                                        hintText: "mm/dd/yyyy",
                                        sufficIcon: Icon(
                                          Icons.calendar_month,
                                          color: AppTheme.secondaryColor,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 45,
                                      width: 155,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 1)),
                                      margin: EdgeInsets.only(
                                          top: 8, left: 2, right: 4),
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
                                                    controller
                                                        .EmdRetentionPickFile(
                                                        context);
                                                  },
                                                  child: Container(
                                                    width: 64,
                                                    height: 25,
                                                    margin: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        color: AppTheme
                                                            .secondaryColor,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4)),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .shade400)),
                                                    child: Center(
                                                      child: Text("Choose file",
                                                          style: GoogleFonts
                                                              .poppins(
                                                              color: AppTheme
                                                                  .white,
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400)),
                                                    ),
                                                  ),
                                                ),
                                                Obx(
                                                      () =>
                                                  controller
                                                      .isFileSelected
                                                      .value &&
                                                      controller
                                                          .emdRetentionFile !=
                                                          null
                                                      ? Row(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        child:
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                          Axis.horizontal,
                                                          child: Text(
                                                              controller
                                                                  .emdRetentionFile!
                                                                  .path
                                                                  .split(
                                                                  '/')
                                                                  .last,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .appBlack,
                                                                  fontSize:
                                                                  12,
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
                                                        style: GoogleFonts
                                                            .poppins(
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
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            width: 398,
                            height: 270,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "SD Retention Receivable Data",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Text",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 90),
                                    Text(
                                      "Amount",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .sdRetentionRemarksController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Sd Retention Remarks",
                                        //obscureText: true,

                                        onTextChange: (general) {
                                          // controller.popUpValue.value = true;
                                        },
                                      ),

                                    ),
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .sdRetentionAmountController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Sd Retention Amount",
                                        //obscureText: true,

                                        onTextChange: (general) {
                                          // controller.popUpValue.value = true;
                                        },
                                      ),

                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "EMD/SD Retention",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff828282)),
                                      )
                                    ],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Receivable Data",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 75),
                                    Text(
                                      "EMD Documents",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 165,
                                      child: TextInput2(
                                        onPressed: () {
                                          controller.sdRetentionDate(context);
                                        },
                                        controller: controller
                                            .sdRetentionReceivableDataDateController,
                                        height: 100,
                                        isReadOnly: true,
                                        /* label: "Customer requirement Date",*/
                                        onTextChange: (text) {},
                                        textInputType: TextInputType.phone,
                                        textColor: Color(0xCC252525),
                                        hintText: "mm/dd/yyyy",
                                        sufficIcon: Icon(
                                          Icons.calendar_month,
                                          color: AppTheme.secondaryColor,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 45,
                                      width: 155,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 1)),
                                      margin: EdgeInsets.only(
                                          top: 8, left: 2, right: 4),
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
                                                    controller
                                                        .SdRetentionPickFile(
                                                        context);
                                                  },
                                                  child: Container(
                                                    width: 64,
                                                    height: 25,
                                                    margin: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        color: AppTheme
                                                            .secondaryColor,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4)),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .shade400)),
                                                    child: Center(
                                                      child: Text("Choose file",
                                                          style: GoogleFonts
                                                              .poppins(
                                                              color: AppTheme
                                                                  .white,
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400)),
                                                    ),
                                                  ),
                                                ),
                                                Obx(
                                                      () =>
                                                  controller
                                                      .isFileSelected
                                                      .value &&
                                                      controller
                                                          .sdRetentionFile !=
                                                          null
                                                      ? Row(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        child:
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                          Axis.horizontal,
                                                          child: Text(
                                                              controller
                                                                  .sdRetentionFile!
                                                                  .path
                                                                  .split(
                                                                  '/')
                                                                  .last,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .appBlack,
                                                                  fontSize:
                                                                  12,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                      : Expanded(
                                                    child: Text(
                                                        "No file chosen",
                                                        style: GoogleFonts
                                                            .poppins(
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
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            width: 398,
                            height: 270,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Other Retention Receivable Data",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff272727)),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Remark Text",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 90),
                                    Text(
                                      "Amount",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: TextInput2(
                                        controller: controller
                                            .othersRetentionRemarksController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Others Remarks",
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
                                        controller: controller
                                            .othersRetentionAmountController,
                                        //height: 70,
                                        //label: "Ideas",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Others Amount",
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
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 12.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "EMD/SD Retention",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff828282)),
                                      )
                                    ],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Receivable Data",
                                        style:
                                        TextStyle(color: Color(0xff828282)),
                                      ),
                                    ),
                                    SizedBox(width: 75),
                                    Text(
                                      "EMD Documents",
                                      style:
                                      TextStyle(color: Color(0xff828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 165,
                                      child: TextInput2(
                                        onPressed: () {
                                          controller.othersRetentionDate(
                                              context);
                                        },
                                        controller: controller
                                            .othersRetentionReceivableDataDateController,
                                        height: 100,
                                        isReadOnly: true,
                                        /* label: "Customer requirement Date",*/
                                        onTextChange: (text) {},
                                        textInputType: TextInputType.phone,
                                        textColor: Color(0xCC252525),
                                        hintText: "mm/dd/yyyy",
                                        sufficIcon: Icon(
                                          Icons.calendar_month,
                                          color: AppTheme.secondaryColor,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 45,
                                      width: 155,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 1)),
                                      margin: EdgeInsets.only(
                                          top: 8, left: 2, right: 4),
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
                                                    controller
                                                        .OtherRetentionPickFile(
                                                        context);
                                                  },
                                                  child: Container(
                                                    width: 64,
                                                    height: 25,
                                                    margin: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        color: AppTheme
                                                            .secondaryColor,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4)),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .shade400)),
                                                    child: Center(
                                                      child: Text("Choose file",
                                                          style: GoogleFonts
                                                              .poppins(
                                                              color: AppTheme
                                                                  .white,
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400)),
                                                    ),
                                                  ),
                                                ),
                                                Obx(
                                                      () =>
                                                  controller
                                                      .isFileSelected
                                                      .value &&
                                                      controller
                                                          .otherRetentionFile !=
                                                          null
                                                      ? Row(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        child:
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                          Axis.horizontal,
                                                          child: Text(
                                                              controller
                                                                  .otherRetentionFile!
                                                                  .path
                                                                  .split(
                                                                  '/')
                                                                  .last,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  color: AppTheme
                                                                      .appBlack,
                                                                  fontSize:
                                                                  12,
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
                                                        style: GoogleFonts
                                                            .poppins(
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
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 147,
                                height: 44,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: 1,
                                        color: AppTheme.secondaryColor)),
                                child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.secondaryColor,
                                      ),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 147,
                                height: 44,
                                decoration: BoxDecoration(
                                    color: AppTheme.secondaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: 1,
                                        color: AppTheme.secondaryColor)),
                                child: const Center(
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.white,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget ProductsListWidgets(BuildContext context, int superIndex) {
    UpdateSiteProjectsController controller = Get.put(
        UpdateSiteProjectsController());
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Column(
        children: List.generate(
            controller.getSiteProjectTenderData[superIndex].siteProjectTenders!.length,
                (subIndex){
          return InkWell(
            onTap: (){

            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: width * 1.2,
                      height: 50,
                      //padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Container(
                            width: width / 2.26,
                            height: 50,
                            decoration: superIndex ==
                                controller
                                    .getSiteProjectTenderData
                                    .length -
                                    1
                                ? BoxDecoration(
                              border:
                              Border(
                                right:
                                BorderSide(
                                  color: Colors
                                      .black,
                                ),
                              ),
                            )
                                : BoxDecoration(
                              border:
                              Border(
                                bottom:
                                BorderSide(
                                  color: Colors
                                      .black,
                                ),
                                right:
                                BorderSide(
                                  color: Colors
                                      .black,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                controller
                                    .getSiteProjectTenderData[
                                superIndex]
                                    .descriptions
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    color: Colors
                                        .black,
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight
                                        .w400),
                                textAlign:
                                TextAlign
                                    .center,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: width / 4,
                                height: 50,
                                decoration: superIndex ==
                                    controller
                                        .getSiteProjectTenderData
                                        .length -
                                        1
                                    ? BoxDecoration(
                                  border:
                                  Border(
                                    right:
                                    BorderSide(
                                      color:
                                      Colors.black,
                                    ),
                                  ),
                                )
                                    : BoxDecoration(
                                  border:
                                  Border(
                                    bottom:
                                    BorderSide(
                                      color:
                                      Colors.black,
                                    ),
                                    right:
                                    BorderSide(
                                      color:
                                      Colors.black,
                                    ),
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                      "₹ ${controller.getSiteProjectTenderData[superIndex].unit.toString()}",
                                      style: GoogleFonts.poppins(
                                          color: Colors
                                              .black,
                                          fontSize:
                                          12,
                                          fontWeight:
                                          FontWeight
                                              .w400),
                                    )),
                              ),
                              Container(
                                width: width / 4,
                                height: 50,
                                decoration: superIndex ==
                                    controller
                                        .getSiteProjectTenderData
                                        .length -
                                        1
                                    ? BoxDecoration(
                                  border:
                                  Border(
                                    right:
                                    BorderSide(
                                      color:
                                      Colors.black,
                                    ),
                                  ),
                                )
                                    : BoxDecoration(
                                  border:
                                  Border(
                                    bottom:
                                    BorderSide(
                                      color:
                                      Colors.black,
                                    ),
                                    right:
                                    BorderSide(
                                      color:
                                      Colors.black,
                                    ),
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                      '₹ ${controller.getSiteProjectTenderData[superIndex].amount.toString()}',
                                      style: GoogleFonts.poppins(
                                          color: Colors
                                              .black,
                                          fontSize:
                                          12,
                                          fontWeight:
                                          FontWeight
                                              .w400),
                                    )),
                              ),
                              Container(
                                width: width / 4,
                                height: 50,
                                decoration: superIndex ==
                                    controller
                                        .getSiteProjectTenderData
                                        .length -
                                        1
                                    ? BoxDecoration(
                                  border:
                                  Border(
                                    right:
                                    BorderSide(
                                      color:
                                      Colors.white,
                                    ),
                                  ),
                                )
                                    : BoxDecoration(
                                  border:
                                  Border(
                                    bottom:
                                    BorderSide(
                                      color:
                                      Colors.black,
                                    ),
                                  ),
                                ),
                                // color: Colors.orange,
                                child: Center(
                                    child: Text(
                                      controller.getSiteProjectTenderData[superIndex].siteProjectTenders![subIndex].qty.toString(),
                                      // "₹ ${controller.projectView[index].tenderAmount.toString()}",
                                      style: GoogleFonts.poppins(
                                          color: Colors
                                              .black,
                                          fontSize:
                                          12,
                                          fontWeight:
                                          FontWeight
                                              .w400),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
    }));
  }
}


