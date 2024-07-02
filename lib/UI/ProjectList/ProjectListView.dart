import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/AppTab.dart';
import '../../Components/HorizontalScrollView.dart';
import '../../Controller/ProjectListViewController.dart';
import '../../api_config/ApiUrl.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';

class ProjectListView extends GetView<ProjectListViewController> {
  const ProjectListView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ProjectListViewController controller = Get.put(ProjectListViewController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.appColor,
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
                    width: 60,
                  ),
                  Text(
                    "Project List",
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
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => HorizontalScrollView(
                          children: List.generate(
                            controller.listValues.length,
                            (index) {
                              var model = controller.listValues[index];
                              return AppTab(
                                  title: model.value,
                                  isSelected:
                                      controller.selectedTabIndex.value ==
                                          index,
                                  onClick: () {
                                    controller.updateCurrentTabIndex(index);
                                  }

                                  //
                                  );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                  },
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.20,
                                width:
                                MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: AppTheme.liteBrown,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppTheme.liteBlue3,
                                          spreadRadius: 0,
                                          blurRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [

                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.1,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                5, 2, 5, 2),
                                            child: SvgPicture.asset(
                                                "assets/images/approved.svg",
                                                height: 15,
                                                width: 15,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.white,
                                                    BlendMode.srcIn),
                                                semanticsLabel:
                                                'A red up arrow'),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                5, 2, 5, 2),
                                            child: const Text(
                                              "Overall Total",
                                              style: TextStyle(
                                                color: AppTheme.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: Row(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          child: const Text(
                                            "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppTheme.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          child:  Obx(() =>  Text(
                                            controller
                                                .overallTotal
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppTheme.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            ),
                                          ),
                                        ),
                                      ],),
                                    )

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 50,)
                    ,                      Column(
                          children: [

                            GestureDetector(
                              onTap: () {
                                 },
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.20,
                                width:
                                MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: AppTheme.liteBlue3,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppTheme.liteBrown,
                                          spreadRadius: 0,
                                          blurRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [

                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.1,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                5, 2, 5, 2),
                                            child: SvgPicture.asset(
                                                "assets/images/approved.svg",
                                                height: 15,
                                                width: 15,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.white,
                                                    BlendMode.srcIn),
                                                semanticsLabel:
                                                'A red up arrow'),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                5, 2, 5, 2),
                                            child: const Text(
                                              "Overall expense",
                                              style: TextStyle(
                                                color: AppTheme.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: Row(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppTheme.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          child:  Obx(() =>   Text(
                                            controller
                                                .overallExpense
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppTheme.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        ),
                                      ],),
                                    )

                                  ],
                                ),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.85,
                        child: TextInput1(
                          controller: controller.projectCodeController,

                          height: 100,
                          label: "Select Project Code",
                          onPressed: () {
                            if (controller.isSub1.value) {
                              controller.isSub1.value = false;
                            } else {
                              controller.isSub1.value = true;
                            }
                          },
                          // isReadOnly: true,
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Select Project Code",
                          obscureText: true,
                          onTextChange: (text) {
                            controller.filterSearchResults(text);
                          },
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(right: 10, top: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppTheme.tabOrange),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                controller.projectCodeController.clear();
                                controller.projectViewData("");
                              },
                              icon: Icon(
                                Icons.clear,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Obx(() => Visibility(
                        visible: controller.isSub1.value,
                        child: Container(
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
                                controller.filterDemoCarList.length,
                                (index) {
                                  var model =
                                      controller.filterDemoCarList[index];
                                  return Container(
                                    child: Column(
                                      children: [
                                        TextInput1(
                                          onPressed: () {
                                            controller.projectCodeController
                                                    .text =
                                                controller
                                                    .filterDemoCarList[index]
                                                    .projectCode!;
                                            // controller.selectedSub1Index.value =
                                            //     index;

                                            controller.projectViewData(
                                                controller
                                                    .filterDemoCarList[index]
                                                    .projectCode
                                                    .toString());

                                            controller.isSub1.value = false;
                                          },
                                          margin: false,
                                          isReadOnly: true,
                                          isSelected: controller
                                                  .projectCodeController.text ==
                                              controller
                                                  .filterDemoCarList[index]
                                                  .projectCode,
                                          label: "",
                                          isEntryField: false,
                                          textInputType: TextInputType.text,
                                          textColor: Color(0xCC234345),
                                          hintText: model.projectCode,
                                          obscureText: true,
                                          onTextChange: (String) {},
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Visibility(
                                            visible: controller
                                                    .filterDemoCarList.length !=
                                                index + 1,
                                            child: Container(
                                              height: 1,
                                              color: AppTheme.appBlack,
                                            ))
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      // height: height * 1.5,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
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
                                            fontWeight: FontWeight.w600),
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
                                            fontWeight: FontWeight.w600),
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
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Obx(
                            () => controller.isLoading.value
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height - 10,
                                    child: Center(
                                        child: CircularProgressIndicator()))
                                : controller.projectView.isNotEmpty
                                    ? Container(
                                        // height: MediaQuery.of(context).size.height,
                                        child: IntrinsicHeight(
                                            child: Column(
                                        children: List.generate(
                                          controller.projectView.length,
                                          (index) {
                                            var model =
                                                controller.projectView[index];


                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                    (_) async {
                                                      if (index == 0) {
                                                        controller.overallExpense.value =
                                                        0;
                                                        controller.overallTotal.value = 0;
                                                      }
                                              controller.overallExpense.value +=
                                                  int.parse(model.expenseAmount
                                                      .toString());
                                              controller.overallTotal.value +=
                                                  int.parse(model.tenderAmount
                                                      .toString());
                                            });

                                            return InkWell(
                                              onTap: (){
                                                // controller.userDataProvider.setProjectCode(controller
                                                //     .projectData[
                                                // index]
                                                //     .projectCode
                                                //     .toString());
                                              },
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
                                                            decoration: index ==
                                                                    controller
                                                                            .projectView
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
                                                                    .projectView[
                                                                        index]
                                                                    .projectCode
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
                                                                decoration: index ==
                                                                    controller
                                                                        .projectView
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
                                                                      "₹ ${controller.projectView[index].tenderAmount.toString()}",
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
                                                                decoration: index ==
                                                                        controller
                                                                                .projectView
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
                                                                  '₹ ${controller.projectView[index].expenseAmount.toString()}',
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
                                                                decoration: index ==
                                                                        controller
                                                                                .projectView
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
                                                                  "Pending",
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
                                            );
                                          },
                                        ),
                                      )))
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
