import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/UI/projectCreation/UPdate_Site_Projects.dart';
import 'package:igreen_flutter/model/DistrictResponseModel.dart';

import '../../Controller/projectCreationController.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import 'ProjectCodeDetails.dart';

class ProjectCreation extends GetView<ProjectCreationController> {
  const ProjectCreation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProjectCreationController controller = Get.put(ProjectCreationController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "GENERAL CODE",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 145,
                            child: TextInput2(
                              height: 100,
                              /* label: "Type",*/
                              controller: controller.generalCodeEmployeeName,
                              onPressed: () {
                                if (controller.generalEmployee.value) {
                                  controller.generalEmployee.value = false;
                                } else {
                                  controller.generalEmployee.value = true;
                                }
                                // controller.rendDetails.clear();
                                // controller.rendDetails.add('Factory');
                                // controller.rendDetails.add('Field');
                              },
                              //  controller: controller.typeController,
                              textInputType: TextInputType.number,
                              textColor: Color(0xCC252525),
                              obscureText: true,
                              isReadOnly: true,
                              hintText: "Employee name*",
                              onTextChange: (string) {},
                            ),
                          ),
                          Container(
                            width: 145,
                            child: TextInput2(
                              height: 100,
                              /* label: "Type",*/
                              controller: controller.generalCodeClientName,
                              onPressed: () {
                                if (controller.generalClientName.value) {
                                  controller.generalClientName.value = false;
                                } else {
                                  controller.generalClientName.value = true;
                                }
                                // controller.rendDetails.clear();
                                // controller.rendDetails.add('Factory');
                                // controller.rendDetails.add('Field');
                              },
                              //  controller: controller.typeController,
                              textInputType: TextInputType.number,
                              textColor: Color(0xCC252525),
                              obscureText: true,
                              isReadOnly: true,
                              hintText: "Client*",
                              onTextChange: (string) {},
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                              showDialog(
                                context: context,
                                // Ensure that context is valid
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                    ),
                                    content: Container(
                                      child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              TextInput(
                                                height: 100,
                                                label: "Client Name*",
                                                onPressed: () {},
                                                controller: controller
                                                    .addGeneralCodeClientName,
                                                textInputType:
                                                TextInputType.text,
                                                textColor: Color(0xCC252525),
                                                hintText: "Enter Client Name",
                                                onTextChange: (string) {

                                                },
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Center(
                                                child: Button(
                                                    widthFactor: 0.8,
                                                    heightFactor: 0.06,
                                                    onPressed: () {
                                                     controller.addGeneralCodeClientNameCall();

                                                    },
                                                    child: const Text("Add",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600))),
                                              ),
                                            ],
                                          )),
                                    ),
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              maxRadius: 12,
                              backgroundColor: AppTheme.secondaryColor,
                              child: Icon(
                                Icons.add,
                                size: 20,
                                weight: 28,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Obx(() => Visibility(
                           visible: controller.generalEmployee.value,
                           child: Container(
                             width: width/2,
                             height: height*0.5,
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
                             child: SingleChildScrollView(
                               child: IntrinsicHeight(
                                 child: Column(
                                   children: List.generate(
                                     controller.employeeName.length,
                                         (index) {
                                       var model =
                                       controller.employeeName[index];
                                       return Container(
                                         child: Column(
                                           children: [
                                             TextInput(
                                               onPressed: () {
                                                 controller
                                                     .generalCodeEmployeeName
                                                     .text =
                                                 controller
                                                     .employeeName[
                                                 index]
                                                     .employeeName!;
                                                 controller.generalEmployee
                                                     .value = false;
                                                 controller.assignProjectId.value =  controller
                                                     .employeeName[
                                                 index]
                                                     .employeeId!.toString();

                                                 print("Assign_Id${controller.assignProjectId}");
                                               },
                                               margin: false,
                                               isSelected: controller
                                                   .generalCodeEmployeeName
                                                   .text ==
                                                   controller
                                                       .employeeName[index]
                                                       .employeeName,
                                               label: "",
                                               isEntryField: false,
                                               textInputType:
                                               TextInputType.text,
                                               textColor:
                                               Color(0xCC234345),
                                               hintText:
                                               model.employeeName,
                                               obscureText: true,
                                               onTextChange: (String) {},
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
                                                   color:
                                                   AppTheme.appBlack,
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
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Obx(() => Visibility(
                           visible: controller.generalClientName.value,
                           child: Container(   width: width /2 , height: height*0.5,
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
                             child: SingleChildScrollView(
                               child: IntrinsicHeight(
                                 child: Column(
                                   children: List.generate(
                                     controller.getClientNameGeneralCode.length,
                                         (index) {
                                       var model =
                                       controller.getClientNameGeneralCode[index];
                                       return Container(
                                         child: Column(
                                           children: [
                                             TextInput(
                                               onPressed: () {
                                                 controller
                                                     .generalCodeClientName
                                                     .text =
                                                 controller
                                                     .getClientNameGeneralCode[
                                                 index]
                                                     .clientName!;
                                                 controller.generalClientName
                                                     .value = false;

                                               },
                                               margin: false,
                                               isSelected: controller
                                                   .generalCodeClientName
                                                   .text ==
                                                   controller
                                                       .getClientNameGeneralCode[index]
                                                       .clientName,
                                               label: "",
                                               isEntryField: false,
                                               textInputType:
                                               TextInputType.text,
                                               textColor:
                                               Color(0xCC234345),
                                               hintText:
                                               model.clientName,
                                               obscureText: true,
                                               onTextChange: (String) {},
                                             ),
                                             const SizedBox(
                                               height: 2,
                                             ),
                                             Visibility(
                                                 visible: controller
                                                     .getClientNameGeneralCode
                                                     .length !=
                                                     index + 1,
                                                 child: Container(
                                                   height: 1,
                                                   color:
                                                   AppTheme.appBlack,
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
                              controller: controller.detailsController,
                              //height: 70,
                              //label: "Ideas",
                              onPressed: () {},
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "Enter details",
                              //obscureText: true,

                              onTextChange: (general) {
                                // controller.popUpValue.value = true;
                              },
                            ),

                          ),
                          Container(
                            width: 170,
                            child: TextInput2(
                               controller: controller.placeController,
                              //height: 70,
                              //label: "Ideas",
                              onPressed: () {},
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "Enter Place",
                              //obscureText: true,

                              onTextChange: (general) {
                                // controller.popUpValue.value = true;
                              },
                            ),

                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 08,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                              onPressed: (){
                                controller.addGeneralCodeCall();
                              },
                              widthFactor: 0.35 ,
                              heightFactor: 0.04,
                              child: Text("Create Code", style: TextStyle(color: Colors.white),),),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9.0),
                        child: Row(
                          children: [
                            Text(
                              "GENERAL CODE:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.black54),
                            ),

                            Obx(() => Expanded(
                              child: Text(controller. generalCode.toString(), style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Colors.black54),),
                            ))

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "PROJECT CODE",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.teamSelection,
                              //height: 70,
                              //label: "Ideas",
                              onPressed: () {
                                controller.ClientDepartment.value =
                                    !controller.ClientDepartment.value;
                              },
                              textInputType: TextInputType.text,
                              textColor: Color(0xCC252525),
                              hintText: "Client",
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
                              controller: controller.typeController,
                              /* label: "Type",*/
                              onPressed: () {
                                if (controller.rendList.value) {
                                  controller.rendList.value = false;
                                } else {
                                  controller.rendList.value = true;
                                }

                                controller.rendDetails.add('Sub');
                                controller.rendDetails.add('own');
                              },
                              textInputType: TextInputType.number,
                              textColor: Color(0xCC252525),
                              obscureText: true,
                              isReadOnly: true,
                              hintText: "Sub or Own",
                              onTextChange: (string) {},
                            ),
                          ),
                        ],
                      ),
                      Obx(() => Visibility(
                            visible: controller.ClientDepartment.value,
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
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
                                    child: Column(
                                      children: List.generate(
                                        controller.fetchData.length,
                                        (index) {
                                          var model =
                                              controller.fetchData[index];
                                          return Container(
                                            child: Column(
                                              children: [
                                                TextInput(
                                                  onPressed: () {
                                                    controller.teamSelection
                                                            .text =
                                                        controller
                                                            .fetchData[index]
                                                            .clientName!;
                                                    controller.ClientDepartment
                                                        .value = false;
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
                                                          .teamSelection.text ==
                                                      controller
                                                          .fetchData[index]
                                                          .clientName,
                                                  label: "",
                                                  isEntryField: false,
                                                  textInputType:
                                                      TextInputType.text,
                                                  textColor: Color(0xCC234345),
                                                  hintText: model.clientName,
                                                  obscureText: true,
                                                  onTextChange: (String) {},
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Visibility(
                                                    visible: controller
                                                            .fetchData.length !=
                                                        index + 1,
                                                    child: Container(
                                                      height: 1,
                                                      color: AppTheme.grey,
                                                    ))
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Obx(() => Visibility(
                            visible: controller.rendList.value,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
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
                                      child: Column(
                                        children: List.generate(
                                          controller.rendDetails.length,
                                          (index) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  TextInput(
                                                    onPressed: () {
                                                      // controller.rendDetails.add('Sub');
                                                      // controller.rendDetails.add('own');
                                                      controller.typeController
                                                              .text =
                                                          controller
                                                                  .rendDetails[
                                                              index];
                                                      controller.rendList
                                                          .value = false;
                                                      controller.rendDetails
                                                          .clear();
                                                    },
                                                    margin: false,
                                                    isSelected: controller
                                                            .typeController
                                                            .text ==
                                                        controller.rendDetails[
                                                            index]!,
                                                    label: "",
                                                    isEntryField: false,
                                                    textInputType:
                                                        TextInputType.text,
                                                    textColor:
                                                        Color(0xCC234345),
                                                    hintText: controller
                                                        .rendDetails[index],
                                                    onTextChange: (String) {},
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Visibility(
                                                    visible: controller
                                                            .rendDetails
                                                            .length !=
                                                        index + 1,
                                                    child: Container(
                                                      height: 1,
                                                      color:
                                                          AppTheme.primaryColor,
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
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.TeamSelection,
                              height: 100,
                              /* label: "Type",*/
                              onPressed: () {
                                controller.StateDepartment.value =
                                    !controller.StateDepartment.value;
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
                              hintText: "State",
                              onTextChange: (string) {},
                            ),
                          ),
                          Container(
                            width: 170,
                            child: TextInput2(
                              controller: controller.DistrictController,
                              height: 100,
                              /* label: "Type",*/
                              onPressed: () {
                                controller.DistrictDepartment.value =
                                    !controller.DistrictDepartment.value;
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
                              hintText: "District",
                              onTextChange: (string) {},
                            ),
                          ),
                        ],
                      ),
                      Obx(() => Visibility(
                            visible: controller.StateDepartment.value,
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
                                    controller.getStateData.length,
                                    (index) {
                                      var model =
                                          controller.getStateData[index];
                                      return Container(
                                        child: Column(
                                          children: [
                                            TextInput(
                                              onPressed: () {
                                                controller.TeamSelection.text =
                                                    controller
                                                        .getStateData[index]
                                                        .stateName!;
                                                controller.StateDepartment
                                                    .value = false;
                                                /* controller.getFactoryDepartmentTeam();
                                                controller.depId.value = controller
                                                    .clientDepartmentData[index]
                                                    .clientId
                                                    .toString();
                                                controller.getFactoryEmployee(controller
                                                    .clientDepartmentData[index]
                                                    .clientId);
                                                    controller
                                                controller.staffDetails.text = '';*/
                                                // requestApi for district
                                                controller.getDistrictDataApi(
                                                    controller
                                                        .getStateData[index]
                                                        .stateName!
                                                        .toString());
                                              },
                                              margin: false,
                                              isSelected: controller
                                                      .TeamSelection.text ==
                                                  controller.getStateData[index]
                                                      .stateName,
                                              label: "",
                                              isEntryField: false,
                                              textInputType: TextInputType.text,
                                              textColor: Color(0xCC234345),
                                              hintText: model.stateName,
                                              obscureText: true,
                                              onTextChange: (String) {},
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Visibility(
                                                visible: controller
                                                        .getStateData.length !=
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
                      Obx(() => Visibility(
                            visible: controller.DistrictDepartment.value,
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
                                    controller.getDistrictData.length,
                                    (index) {
                                      var model =
                                          controller.getDistrictData[index];
                                      return Container(
                                        child: Column(
                                          children: [
                                            TextInput(
                                              onPressed: () {
                                                controller.DistrictController
                                                        .text =
                                                    controller
                                                        .getDistrictData[index]
                                                        .districtName!;
                                                controller.DistrictDepartment
                                                    .value = false;
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
                                                      .DistrictController
                                                      .text ==
                                                  controller
                                                      .getDistrictData[index]
                                                      .districtName,
                                              label: "",
                                              isEntryField: false,
                                              textInputType: TextInputType.text,
                                              textColor: Color(0xCC234345),
                                              hintText: model.districtName,
                                              obscureText: true,
                                              onTextChange: (String) {},
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Visibility(
                                                visible: controller
                                                        .getDistrictData
                                                        .length !=
                                                    index + 1,
                                                child: Container(
                                                  height: 1,
                                                  color: AppTheme.grey,
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
                      const SizedBox(
                        height: 25,
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
                              hintText: "Area",
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                              onPressed: (){
                                controller.getCreateCodeApi();
                              },
                              widthFactor: 0.35 ,
                              heightFactor: 0.04,
                              child: Text("Create Code", style: TextStyle(color: Colors.white),),),
                          )
                        ],
                      ),


                      Obx(() => Visibility(
                            visible: controller.CreateCodevalue.value,
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
                                    controller.getCreatecodeData.length,
                                    (index) {
                                      var model =
                                          controller.getCreatecodeData[index];
                                      return Container(
                                        child: Column(
                                          children: [
                                            TextInput(
                                              onPressed: () {
                                                controller.createCodeController
                                                        .text =
                                                    controller
                                                        .getCreatecodeData[
                                                            index]
                                                        .message!;
                                                controller.CreateCodevalue
                                                    .value = false;
                                                /* controller.getFactoryDepartmentTeam();
                                                controller.depId.value = controller
                                                    .clientDepartmentData[index]
                                                    .clientId
                                                    .toString();
                                                controller.getFactoryEmployee(controller
                                                    .clientDepartmentData[index]
                                                    .clientId);
                                                controller.staffDetails.text = '';*/
                                                controller.getDistrictDataApi(
                                                    controller
                                                        .getStateData[index]
                                                        .stateName!
                                                        .toString());
                                              },
                                              margin: false,
                                              isSelected: controller
                                                      .createCodeController
                                                      .text ==
                                                  controller
                                                      .getCreatecodeData[index]
                                                      .message,
                                              label: "",
                                              isEntryField: false,
                                              textInputType: TextInputType.text,
                                              textColor: Color(0xCC234345),
                                              hintText: model.message,
                                              obscureText: true,
                                              onTextChange: (String) {},
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Visibility(
                                                visible: controller
                                                        .getCreatecodeData
                                                        .length !=
                                                    index + 1,
                                                child: Container(
                                                  height: 1,
                                                  color: AppTheme.grey,
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
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9.0),
                        child: Row(
                          children: [
                            Text(
                              "PROJECT CODE:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.black54),
                            ),

                            Obx(() => Expanded(
                              child: Text(controller.projectCode.toString(), style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Colors.black54),),
                            ))

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.height * 0.19,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "TENDER TYPE",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 362,
                        child: TextInput2(
                          height: 100,
                          /* label: "Type",*/
                          controller: controller.tenderTypeController,
                          onPressed: () {
                            if (controller.tenderType.value) {
                              controller.tenderType.value = false;
                            } else {
                              controller.tenderType.value = true;
                            }
                            // controller.rendDetails.clear();
                            controller.tenderTypeList.add('Open');
                            controller.tenderTypeList.add('Close');
                          },
                          //  controller: controller.typeController,
                          textInputType: TextInputType.number,
                          textColor: Color(0xCC252525),
                          obscureText: true,
                          isReadOnly: true,
                          hintText: "Choose Tender Type",
                          onTextChange: (string) {},
                        ),
                      ),

                      Obx(() => Visibility(
                        visible: controller.tenderType.value,
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
                                controller.tenderTypeList.length,
                                    (index) {
                                  var model =
                                  controller.tenderTypeList[index];
                                  return Container(
                                    child: Column(
                                      children: [
                                        TextInput(
                                          onPressed: () {
                                            controller.tenderTypeController.text =
                                            controller
                                                .tenderTypeList[index];

                                            controller.tenderType
                                                .value = false;

                                             controller.tenderTypeList.clear();

                                            /* controller.getFactoryDepartmentTeam();
                                                controller.depId.value = controller
                                                    .clientDepartmentData[index]
                                                    .clientId
                                                    .toString();
                                                controller.getFactoryEmployee(controller
                                                    .clientDepartmentData[index]
                                                    .clientId);
                                                    controller
                                                controller.staffDetails.text = '';*/
                                            // requestApi for district



                                          },
                                          margin: false,
                                          isSelected: controller
                                              .tenderTypeController.text ==
                                              controller.tenderTypeList[index],

                                          label: "",
                                          isEntryField: false,
                                          textInputType: TextInputType.text,
                                          textColor: Color(0xCC234345),
                                          hintText: model,
                                          obscureText: true,
                                          onTextChange: (String) {},
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Visibility(
                                            visible: controller
                                                .tenderTypeList.length !=
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
                  
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 7.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Container(
                      //         width: 110,
                      //         height: 27,
                      //         child: Center(
                      //           child: Text(
                      //             "Create Code",
                      //             style: TextStyle(color: Colors.white),
                      //           ),
                      //         ),
                      //         decoration: BoxDecoration(
                      //           color: AppTheme.secondaryColor,
                      //           borderRadius: BorderRadius.circular(4),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.height * 0.23,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "TENDER SPEC/ENQUIRY SPEC",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 170,
                          child: TextInput2(
                             controller: controller.tenderSpecRemarkController,
                            //height: 70,
                            //label: "Ideas",
                            onPressed: () {},
                            textInputType: TextInputType.text,
                            textColor: Color(0xCC252525),
                            hintText: "Tender Spec Remarks",
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  border: Border.all(
                                      color: Colors.grey.shade400, width: 1)),
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
                                            controller.tenderSpecPickFile(context);
                                          },
                                          child: Container(
                                            width: 64,
                                            height: 25,
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: AppTheme.secondaryColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade400)),
                                            child: Center(
                                              child: Text("Browser",
                                                  style: GoogleFonts.poppins(
                                                      color: AppTheme.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => controller
                                                      .isFileSelected.value &&
                                                  controller.tenderFile != null
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
                                                                .tenderFile!.path
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
                                                  child: Text("No file choosen",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
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
                    const SizedBox(
                      height: 22,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 7.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         width: 110,
                    //         height: 27,
                    //         child: Center(
                    //           child: Text(
                    //             "Create Code",
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         ),
                    //         decoration: BoxDecoration(
                    //           color: AppTheme.secondaryColor,
                    //           borderRadius: BorderRadius.circular(4),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "ASSIGNED TO",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                height: 100,
                                /* label: "Type",*/
                                controller: controller.employeeNameController,
                                onPressed: () {
                                  if (controller.selectPerson.value) {
                                    controller.selectPerson.value = false;
                                  } else {
                                    controller.selectPerson.value = true;
                                  }
                    
                                },
                                //  controller: controller.typeController,
                                textInputType: TextInputType.number,
                                textColor: Color(0xCC252525),
                                obscureText: true,
                                isReadOnly: true,
                                hintText: "Employee name*",
                                onTextChange: (string) {},
                              ),
                            ),
                          ],
                        ),
                    
                        Obx(() => Visibility(
                          visible: controller.selectPerson.value,
                          child: Container(    height: height*0.5,
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
                            child: SingleChildScrollView(
                              child: IntrinsicHeight(
                                child: Column(
                                  children: List.generate(
                                    controller.employeeName.length,
                                        (index) {
                                      var model =
                                      controller.employeeName[index];
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
                                                controller.selectPerson
                                                    .value = false;
                                                controller.assignProjectId.value =  controller
                                                    .employeeName[
                                                index]
                                                    .employeeId!.toString();

                                                print("Assign_Id${controller.assignProjectId}");
                                              },
                                              margin: false,
                                              isSelected: controller
                                                  .employeeNameController
                                                  .text ==
                                                  controller
                                                      .employeeName[index]
                                                      .employeeName,
                                              label: "",
                                              isEntryField: false,
                                              textInputType:
                                              TextInputType.text,
                                              textColor:
                                              Color(0xCC234345),
                                              hintText:
                                              model.employeeName,
                                              obscureText: true,
                                              onTextChange: (String) {},
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
                                                  color:
                                                  AppTheme.appBlack,
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
                    
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "OPENING DATE",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                 controller: controller.openingDateRemarkController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "Opening Date Remarks",
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
                                controller: controller.openingDateController,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "CLOSING DATE",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                hintText: "Closing Date Remarks",
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
                                controller: controller.closingDateController,
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
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "BRQ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                controller: controller.brqRemarkController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "Brq Remark",
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
                                      border: Border.all(
                                          color: Colors.grey.shade400, width: 1)),
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
                                                controller.brqPickFile(context);
                                              },
                                              child: Container(
                                                width: 64,
                                                height: 25,
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppTheme.secondaryColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400)),
                                                child: Center(
                                                  child: Text("Browser",
                                                      style: GoogleFonts.poppins(
                                                          color: AppTheme.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => controller
                                                          .isFileSelected.value &&
                                                      controller.brqFile != null
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
                                                                    .brqFile!.path
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
                            // Obx(() => controller.isFileSelected.value &&
                            //     controller.file != null
                            //     ? Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 10),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: [
                            //       GestureDetector(
                            //         onTap: () {
                            //
                            //         },
                            //         child: Container(
                            //           margin: EdgeInsets.all(10),
                            //           padding: EdgeInsets.symmetric(
                            //               horizontal: 10, vertical: 5),
                            //           decoration: BoxDecoration(
                            //               borderRadius:
                            //               BorderRadius.all(Radius.circular(7)),
                            //               border: Border.all(
                            //                   color: AppTheme.primaryColor)),
                            //           child: Center(
                            //             child: Text(
                            //                 controller.file!.path.split('/').last,
                            //                 style: GoogleFonts.poppins(
                            //                     color: AppTheme.primaryColor,
                            //                     fontSize: 12,
                            //                     fontWeight: FontWeight.w600)),
                            //           ),
                            //         ),
                            //       ),
                            //       GestureDetector(
                            //           onTap: () {
                            //             controller.file = null;
                            //           },
                            //           child: Icon(Icons.clear))
                            //     ],
                            //   ),
                            // )
                            //     : Container()),
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
                              Text(
                                "EMD/EMD/EXEMPTION",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 170,
                              child: TextInput2(
                                 controller: controller.emdRemarkController,
                                //height: 70,
                                //label: "Ideas",
                                onPressed: () {},
                                textInputType: TextInputType.text,
                                textColor: Color(0xCC252525),
                                hintText: "EMD Remark",
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      border: Border.all(
                                          color: Colors.grey.shade400, width: 1)),
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
                                                controller.emdPickFile(context);
                                              },
                                              child: Container(
                                                width: 64,
                                                height: 25,
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppTheme.secondaryColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400)),
                                                child: Center(
                                                  child: Text("Browser",
                                                      style: GoogleFonts.poppins(
                                                          color: AppTheme.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => controller
                                                          .isFileSelected.value &&
                                                      controller.emdFile != null
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
                                                                    .emdFile!.path
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
                            /*Container(
                              width: 168,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.shade400, width: 1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 73,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: AppTheme.secondaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Choose file",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 1),
                                    child: Text(
                                      "No file choosen",
                                      style: TextStyle(
                                        color: Color(0xff828282),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),*/
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Button(
                  onPressed: (){
                   // controller.TenderUpdateApi();
                    Get.to(ProjectCodeDetails());
                  },
                  widthFactor: 0.8 ,
                  heightFactor: 0.06,
                  child: Text("Create Project Code", style: TextStyle(color: Colors.white),),),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
