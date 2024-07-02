import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import '../../Controller/ProjectContoller/SalesTeamController.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import 'package:intl/intl.dart';

class AddSalesTeam extends GetView<SalesTeamController> {
  const AddSalesTeam({super.key});

  bool selectableDay(DateTime day) {

    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime dayBeforeYesterday = today.subtract(Duration(days: 2));

    return day.year == today.year &&
        day.month == today.month &&
        (day.day == today.day ||
            day.day == yesterday.day ||
            day.day == dayBeforeYesterday.day);
  }

  Future<void> startDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.startDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> endDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.endDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> orderConfirmedDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.orderConfirmedDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> customerRequireDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
       // selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.customerRequireDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> dispatchDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
       // selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.dispatchDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SalesTeamController controller = Get.put(SalesTeamController());
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
                  width: 70,
                ),
                Text(
                  "Add Sales Team",
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
      body: KeyboardActions(
        config: _buildKeyboardActionsConfig(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "CUSTOMER DETAILS",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              TextInput(
                height: 100,
                label: "Customer Name",
                onPressed: () {},
                controller: controller.customerNameController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Customer Name ",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Mobile Number*",
                onPressed: () {},
                controller: controller.mobileNumberController,
                focusNode: controller.mobileNumberFocusNode,
                textInputType: TextInputType.number,
                textColor: Color(0xCC252525),
                hintText: "Enter Mobile Number * ",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Secondary Contact*",
                onPressed: () {},
                controller: controller.secondaryContactController,
                textInputType: TextInputType.number,
                textColor: Color(0xCC252525),
                hintText: "Enter Secondary Contact* ",
                focusNode: controller.secondaryContactFocusNode,
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Email Id",
                onPressed: () {

                },
                controller: controller.emailController,
                textInputType: TextInputType.emailAddress,
                textColor: Color(0xCC252525),
                hintText: "Enter Email Id ",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Customer Location",
                onPressed: () {
                  // if (controller.subCategoryDropDownOne.value) {
                  //   controller.subCategoryDropDownOne.value = false;
                  // } else {
                  //   controller.subCategoryDropDownOne.value = true;
                  // }
                },
                controller: controller.customerLocationController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Customer Location ",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "WebSite Details",
                onPressed: () {
                  // if (controller.subCategoryDropDownOne.value) {
                  //   controller.subCategoryDropDownOne.value = false;
                  // } else {
                  //   controller.subCategoryDropDownOne.value = true;
                  // }
                },
                controller: controller.websiteDetailsController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter WebSite Details ",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Delivery Address",
                onPressed: () {
                  // if (controller.subCategoryDropDownOne.value) {
                  //   controller.subCategoryDropDownOne.value = false;
                  // } else {
                  //   controller.subCategoryDropDownOne.value = true;
                  // }
                },
                controller: controller.deliveryAddressController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Delivery Address ",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Company Name",
                onPressed: () {
                  // if (controller.subCategoryDropDownOne.value) {
                  //   controller.subCategoryDropDownOne.value = false;
                  // } else {
                  //   controller.subCategoryDropDownOne.value = true;
                  // }
                },
                controller: controller.companyNameController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Company Name ",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Company Address",
                onPressed: () {
                  // if (controller.subCategoryDropDownOne.value) {
                  //   controller.subCategoryDropDownOne.value = false;
                  // } else {
                  //   controller.subCategoryDropDownOne.value = true;
                  // }
                },
                controller: controller.companyAddressController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Company Address ",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "GST",
                onPressed: () {
                  // if (controller.subCategoryDropDownOne.value) {
                  //   controller.subCategoryDropDownOne.value = false;
                  // } else {
                  //   controller.subCategoryDropDownOne.value = true;
                  // }
                },
                controller: controller.gstNameController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter GST",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Service Domain",
                onPressed: () {
                  // if (controller.subCategoryDropDownOne.value) {
                  //   controller.subCategoryDropDownOne.value = false;
                  // } else {
                  //   controller.subCategoryDropDownOne.value = true;
                  // }
                },
                controller: controller.serviceDomainController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Service Domain ",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Approx Budget",
                onPressed: () {
                  },
                controller: controller.approxBudgetController,
                textInputType: TextInputType.number,
                textColor: Color(0xCC252525),
                hintText: "Enter Approx Budget",
                focusNode: controller.approxBudjetFocusNode,
                onTextChange: (String) {},
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Switch(
                        value: controller.isSwitched.value,
                        onChanged: (value) {
                          controller.toggleSwitch();
                          controller.pickUp.value = !controller.pickUp.value;
                        },
                      ),
                    ),
                    Text(
                      "Material  From Client",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Obx(() => Visibility(
                    visible: controller.pickUp.value,
                    child: TextInput(
                      height: 100,
                      label: "PickUp Address",
                      onPressed: () {

                      },
                      controller: controller.pickUpAddressController,
                      textInputType: TextInputType.text,
                      textColor: Color(0xCC252525),
                      hintText: "Enter PickUp Address ",
                      onTextChange: (String) {},
                    ),
                  )),
              Text(
                "PROJECT DETAILS",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              TextInput(
                height: 100,
                label: "Project Name",
                onPressed: () {
                  // if (controller.subCategoryDropDownOne.value) {
                  //   controller.subCategoryDropDownOne.value = false;
                  // } else {
                  //   controller.subCategoryDropDownOne.value = true;
                  // }
                },
                controller: controller.projectNameController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Project Name ",
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Project Description",
                onPressed: () {
                  // if (controller.subCategoryDropDownOne.value) {
                  //   controller.subCategoryDropDownOne.value = false;
                  // } else {
                  //   controller.subCategoryDropDownOne.value = true;
                  // }
                },
                controller: controller.projectDescriptionController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Project Description ",
                onTextChange: (String) {},
              ),
              Row(
                children: [
                  Container(
                    width: (width / 2) - 10,
                    child: TextInput(
                      height: 100,
                      label: "Type",
                      onPressed: () {
                        if (controller.rendList.value) {
                          controller.rendList.value = false;
                        } else {
                          controller.rendList.value = true;
                        }
                        controller.rendDetails.clear();
                        controller.rendDetails.add('Factory');
                        controller.rendDetails.add('Field');
                      },
                      controller: controller.typeController,
                      textInputType: TextInputType.number,
                      textColor: Color(0xCC252525),
                      obscureText: true,
                      isReadOnly: true,
                      hintText: "Select Type",
                      onTextChange: (string) {},
                    ),
                  ),
                  Container(
                    height: 50,
                    width: (width / 2) - 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey)),
                    margin: EdgeInsets.only(top: 8, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        _pickFile(context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Text("Choose From Files",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() => Visibility(
                    visible: controller.rendList.value,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                        padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white, // Set the desired background color
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
                                          controller.typeController.text =
                                              controller.rendDetails[index];
                                          controller.rendList.value = false;
                                          controller.rendDetails.clear();

                                          //controller.typeController.text = "";

                                          controller.rendDetails.add('Month');

                                          controller.rendDetails.add('Day');
                                          controller.rendDetails.add('Lease');
                                          controller.rendDetails.add('One Time');
                                        },
                                        margin: false,
                                        isSelected:
                                            controller.typeController.text ==
                                                controller.rendDetails[index]!,
                                        label: "",
                                        isEntryField: false,
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC234345),
                                        hintText: controller.rendDetails[index],
                                        onTextChange: (String) {},
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Visibility(
                                        visible: controller.rendDetails.length !=
                                            index + 1,
                                        child: Container(
                                          height: 1,
                                          color: AppTheme.primaryColor,
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
                  )),
              SizedBox(
                height: 20,
              ),

              Text(
                "ORDER",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              TextInput(
                onPressed: () {
                  orderConfirmedDate(context);
                },
                controller: controller.orderConfirmedDateController,
                height: 100,
                isReadOnly: true,
                label: "Order Confirmed Date",
                onTextChange: (text) {},
                textInputType: TextInputType.phone,
                textColor: Color(0xCC252525),
                hintText: "yyyy-mm-dd",
                sufficIcon: Icon(
                  Icons.calendar_month,
                ),
                obscureText: true,
              ),
              TextInput(
                onPressed: () {
                  customerRequireDate(context);
                },
                controller: controller.customerRequireDateController,
                height: 100,
                isReadOnly: true,
                label: "Customer requirement Date",
                onTextChange: (text) {},
                textInputType: TextInputType.phone,
                textColor: Color(0xCC252525),
                hintText: "yyyy-mm-dd",
                sufficIcon: Icon(
                  Icons.calendar_month,
                ),
                obscureText: true,
              ),
              TextInput(
                onPressed: () {
                  dispatchDate(context);
                },
                controller: controller.dispatchDateController,
                height: 100,
                isReadOnly: true,
                label: "Dispatch Committed Date",
                onTextChange: (text) {},
                textInputType: TextInputType.phone,
                textColor: Color(0xCC252525),
                hintText: "yyyy-mm-dd",
                sufficIcon: Icon(
                  Icons.calendar_month,
                ),
                obscureText: true,
              ),
              TextInput(
                height: 100,
                label: "Shipment Address",
                onPressed: () {
                  // if (controller.subCategoryDropDownOne.value) {
                  //   controller.subCategoryDropDownOne.value = false;
                  // } else {
                  //   controller.subCategoryDropDownOne.value = true;
                  // }
                },
                controller: controller.shipmentAddressController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Shipment Address",
                onTextChange: (String) {},
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Switch(
                        value: controller.isSwitchedTransport.value,
                        onChanged: (value) {
                          controller.toggleSwitchTransport();
                        },
                      ),
                    ),
                    Text(
                      "Transportation Scope",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              // Text(
              //   "DEMAND",
              //   style: GoogleFonts.poppins(
              //       color: Colors.black,
              //       fontSize: 15,
              //       fontWeight: FontWeight.w600),
              // ),
              // TextInput(
              //   height: 100,
              //   label: "Items ",
              //   onPressed: () {
              //     if (controller.itemList.value) {
              //       controller.itemList.value = false;
              //     } else {
              //       controller.itemList.value = true;
              //     }
              //     controller.itemDetails.clear();
              //     controller.itemDetails.add('1-code-first_Discription-item');
              //     controller.itemDetails.add('2-code-2-discription-name');
              //     controller.itemDetails.add('-MS Welding Electrod-');
              //     controller.itemDetails.add('-Tig Rod-');
              //     controller.itemDetails.add('-Grinding Stone-');
              //     controller.itemDetails.add('-Cutting Disck-');
              //     controller.itemDetails.add('-Emery Disck-');
              //     controller.itemDetails.add('- Arm Glove-');
              //     controller.itemDetails.add('-Hand Glove-');
              //     controller.itemDetails.add('-Sheild glass-');
              //     controller.itemDetails.add('-Gogle-');
              //     controller.itemDetails.add('-Arc welding Tourch-');
              //     controller.itemDetails.add('-Mig welding Nozle-');
              //     controller.itemDetails.add('-Button-');
              //     controller.itemDetails.add('-Ball Bearing-');
              //     controller.itemDetails.add('-Roller Bearing-');
              //     controller.itemDetails.add('-Rod-');
              //     controller.itemDetails.add('-Blocks-');
              //     controller.itemDetails.add('-Plates-');
              //     controller.itemDetails.add('-Air Filter-');
              //     controller.itemDetails.add('-Rod Wiper-');
              //     controller.itemDetails.add('-Cabke Bracket-');
              //     controller.itemDetails.add('-Safety Helmet-');
              //     controller.itemDetails.add('-Chinese finger-');
              //   },
              //   controller: controller.itemsController,
              //   textInputType: TextInputType.text,
              //   textColor: Color(0xCC252525),
              //   hintText: "Enter Items ",
              //   obscureText: true,
              //   isReadOnly: true,
              //   onTextChange: (String) {},
              // ),
              // Obx(() => Visibility(
              //       visible: controller.itemList.value,
              //       child: Align(
              //         alignment: Alignment.centerLeft,
              //         child: Container(
              //           width: MediaQuery.of(context).size.width,
              //           margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
              //           padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               color: AppTheme.inputBorderColor,
              //               width: 1,
              //             ),
              //             borderRadius: BorderRadius.circular(8),
              //             color: Colors.white, // Set the desired background color
              //           ),
              //           child: IntrinsicHeight(
              //             child: Column(
              //               children: List.generate(
              //                 controller.itemDetails.length,
              //                 (index) {
              //                   return Container(
              //                     child: Column(
              //                       children: [
              //                         TextInput(
              //                           onPressed: () {
              //                             controller.itemsController.text =
              //                                 controller.itemDetails[index];
              //                             controller.itemList.value = false;
              //                             controller.itemDetails.clear();
              //
              //                             //controller.typeController.text = "";
              //
              //                             controller.itemDetails.add('Month');
              //
              //                             controller.itemDetails.add('Day');
              //                             controller.itemDetails.add('Lease');
              //                             controller.itemDetails.add('One Time');
              //                           },
              //                           margin: false,
              //                           isSelected:
              //                               controller.itemsController.text ==
              //                                   controller.itemDetails[index]!,
              //                           label: "",
              //                           isEntryField: false,
              //                           textInputType: TextInputType.text,
              //                           textColor: Color(0xCC234345),
              //                           hintText: controller.itemDetails[index],
              //                           onTextChange: (String) {},
              //                         ),
              //                         SizedBox(
              //                           height: 2,
              //                         ),
              //                         Visibility(
              //                           visible: controller.itemDetails.length !=
              //                               index + 1,
              //                           child: Container(
              //                             height: 1,
              //                             color: AppTheme.primaryColor,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   );
              //                 },
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     )),
              // TextInput(
              //   height: 100,
              //   label: "Size ",
              //   onPressed: () {
              //     if (controller.sizeList.value) {
              //       controller.sizeList.value = false;
              //     } else {
              //       controller.sizeList.value = true;
              //     }
              //     controller.sizeDetails.clear();
              //     controller.sizeDetails.add('2.5 x 350');
              //     controller.sizeDetails.add('3.15 x 350');
              //     controller.sizeDetails.add('3.15 x 450');
              //     controller.sizeDetails.add('4 x 450');
              //     controller.sizeDetails.add('4 x 450');
              //     controller.sizeDetails.add('4 x 450');
              //     controller.sizeDetails.add('3.15 x 450');
              //     controller.sizeDetails.add('1.6 x 1000');
              //     controller.sizeDetails.add('4 inch');
              //     controller.sizeDetails.add('5 inch');
              //     controller.sizeDetails.add('7 inch');
              //     controller.sizeDetails.add('4 x 1mm');
              //     controller.sizeDetails.add('4 x 3mm');
              //     controller.sizeDetails.add('5 x 3');
              //     controller.sizeDetails.add('7 x 3');
              //     controller.sizeDetails.add('4 inch');
              //     controller.sizeDetails.add('5 inch');
              //     controller.sizeDetails.add('Leather');
              //     controller.sizeDetails.add('Leather');
              //     controller.sizeDetails.add('Black');
              //     controller.sizeDetails.add('White');
              //     controller.sizeDetails.add('Black');
              //     controller.sizeDetails.add('White');
              //     controller.sizeDetails.add('NA');
              //     controller.sizeDetails.add('NA');
              //     controller.sizeDetails.add('Cone Bottom bush');
              //     controller.sizeDetails.add('10 x 10');
              //     controller.sizeDetails.add('14 x 20');
              //     controller.sizeDetails.add('14 x 25');
              //     controller.sizeDetails.add('12 x 16');
              //     controller.sizeDetails.add('9 X 10.5');
              //     controller.sizeDetails.add('10 x 12');
              //
              //     controller.sizeDetails.add('12 X 15');
              //     controller.sizeDetails.add('10 X 13.4');
              //     controller.sizeDetails.add('17 X 12.3');
              //
              //     controller.sizeDetails.add('13 X 18.5');
              //     controller.sizeDetails.add('10 X 12.5');
              //     controller.sizeDetails.add('9 X 10.4');
              //
              //     controller.sizeDetails.add('13 X 18');
              //     controller.sizeDetails.add('12');
              //     controller.sizeDetails.add('25 x 14');
              //
              //     controller.sizeDetails.add('20 x 14');
              //     controller.sizeDetails.add('14 x 8');
              //     controller.sizeDetails.add('10 x 8');
              //
              //     controller.sizeDetails.add('6.3 x 41');
              //     controller.sizeDetails.add('9.6 x 6');
              //     controller.sizeDetails.add('Dia 90 x 250');
              //
              //     controller.sizeDetails.add('Dia 90 x 380');
              //     controller.sizeDetails.add('Dia 90 x 400');
              //     controller.sizeDetails.add('Dia 90 x 1100');
              //
              //     controller.sizeDetails.add('Dia 70 x 230');
              //     controller.sizeDetails.add('Dia 80 x 250');
              //     controller.sizeDetails.add('Dia 130 x 250');
              //
              //     controller.sizeDetails.add('60 x 35 x 120');
              //     controller.sizeDetails.add('90 x 60 x 115');
              //     controller.sizeDetails.add('85 x 65 x 140');
              //
              //     controller.sizeDetails.add('100 x 20 x 245');
              //     controller.sizeDetails.add('130 x 20 x 495');
              //     controller.sizeDetails.add('NA');
              //
              //     controller.sizeDetails.add('NA');
              //     controller.sizeDetails.add('NA');
              //     controller.sizeDetails.add('NA');
              //
              //     controller.sizeDetails.add('Dia 40');
              //     controller.sizeDetails.add('Dia 63');
              //     controller.sizeDetails.add('Dia 73');
              //     controller.sizeDetails.add('Dia 90');
              //     controller.sizeDetails.add('Dia 150');
              //
              //     controller.sizeDetails.add('Dia 80 x 80');
              //     controller.sizeDetails.add('Dia 80 x 160');
              //     controller.sizeDetails.add('Dia 70 x 170');
              //
              //     controller.sizeDetails.add('Dia 110 x 170');
              //     controller.sizeDetails.add('Dia 70 x 205');
              //     controller.sizeDetails.add('Dia 70 x 615');
              //     controller.sizeDetails.add('Dia 120 x 425');
              //     controller.sizeDetails.add('Dia 70 x 183');
              //   },
              //   controller: controller.sizeController,
              //   textInputType: TextInputType.text,
              //   textColor: Color(0xCC252525),
              //   hintText: "Enter size ",
              //   obscureText: true,
              //   isReadOnly: true,
              //   onTextChange: (String) {},
              // ),
              // Obx(() => Visibility(
              //       visible: controller.sizeList.value,
              //       child: Align(
              //         alignment: Alignment.centerLeft,
              //         child: Container(
              //           width: MediaQuery.of(context).size.width,
              //           margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
              //           padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               color: AppTheme.inputBorderColor,
              //               width: 1,
              //             ),
              //             borderRadius: BorderRadius.circular(8),
              //             color: Colors.white, // Set the desired background color
              //           ),
              //           child: IntrinsicHeight(
              //             child: Column(
              //               children: List.generate(
              //                 controller.sizeDetails.length,
              //                 (index) {
              //                   return Container(
              //                     child: Column(
              //                       children: [
              //                         TextInput(
              //                           onPressed: () {
              //                             controller.sizeController.text =
              //                                 controller.sizeDetails[index];
              //                             controller.sizeList.value = false;
              //                             controller.sizeDetails.clear();
              //
              //                             //controller.typeController.text = "";
              //
              //                             controller.sizeDetails.add('Month');
              //
              //                             controller.sizeDetails.add('Day');
              //                             controller.sizeDetails.add('Lease');
              //                             controller.sizeDetails.add('One Time');
              //                           },
              //                           margin: false,
              //                           isSelected:
              //                               controller.sizeController.text ==
              //                                   controller.sizeDetails[index]!,
              //                           label: "",
              //                           isEntryField: false,
              //                           textInputType: TextInputType.text,
              //                           textColor: Color(0xCC234345),
              //                           hintText: controller.sizeDetails[index],
              //                           onTextChange: (String) {},
              //                         ),
              //                         SizedBox(
              //                           height: 2,
              //                         ),
              //                         Visibility(
              //                           visible: controller.sizeDetails.length !=
              //                               index + 1,
              //                           child: Container(
              //                             height: 1,
              //                             color: AppTheme.primaryColor,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   );
              //                 },
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     )),
              // TextInput(
              //   height: 100,
              //   label: "Quantity",
              //   onPressed: () {
              //     // if (controller.subCategoryDropDownOne.value) {
              //     //   controller.subCategoryDropDownOne.value = false;
              //     // } else {
              //     //   controller.subCategoryDropDownOne.value = true;
              //     // }
              //   },
              //   controller: controller.quantityController,
              //   textInputType: TextInputType.number,
              //   textColor: Color(0xCC252525),
              //   hintText: "Enter Quantity",
              //   onTextChange: (String) {},
              // ),
              // TextInput(
              //   height: 100,
              //   label: "Item Value",
              //   onPressed: () {
              //     // if (controller.subCategoryDropDownOne.value) {
              //     //   controller.subCategoryDropDownOne.value = false;
              //     // } else {
              //     //   controller.subCategoryDropDownOne.value = true;
              //     // }
              //   },
              //   controller: controller.itemValueController,
              //   textInputType: TextInputType.number,
              //   textColor: Color(0xCC252525),
              //   hintText: "Enter Item Value",
              //   onTextChange: (String) {},
              // ),
              // TextInput(
              //   height: 100,
              //   label: "Raw Material Grade",
              //   onPressed: () {
              //     // if (controller.subCategoryDropDownOne.value) {
              //     //   controller.subCategoryDropDownOne.value = false;
              //     // } else {
              //     //   controller.subCategoryDropDownOne.value = true;
              //     // }
              //   },
              //   controller: controller.rawMaterialController,
              //   textInputType: TextInputType.text,
              //   textColor: Color(0xCC252525),
              //   hintText: "Enter Raw Material Grade",
              //   onTextChange: (String) {},
              // ),
              // Center(
              //   child: Container(
              //     width: (width / 2) - 10 ,
              //     height: 50,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color:Colors.blue
              //     ),
              //     child: GestureDetector(
              //       onTap: () {},
              //       child: Center(
              //         child: Container(
              //           child: Text("SAVE",style: GoogleFonts.poppins(
              //               color: Colors.black,
              //               fontSize: 18,
              //               fontWeight: FontWeight.w600),),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Text(
              //   "TOTAL ORDER VALUE",
              //   style: GoogleFonts.poppins(
              //       color: Colors.black,
              //       fontSize: 15,
              //       fontWeight: FontWeight.w600),
              // ),
              // TextInput(
              //   height: 100,
              //   label: "Order Value",
              //   onPressed: () {
              //     // if (controller.subCategoryDropDownOne.value) {
              //     //   controller.subCategoryDropDownOne.value = false;
              //     // } else {
              //     //   controller.subCategoryDropDownOne.value = true;
              //     // }
              //   },
              //   controller: controller.orderValueController,
              //   textInputType: TextInputType.number,
              //   textColor: Color(0xCC252525),
              //   hintText: "Enter Order Value",
              //   onTextChange: (String) {},
              // ),
              //
              //
              // TextInput(label: "", onTextChange: (String) {}),
              SizedBox(
                height: 20,
              ),
              Text(" Commercial Upload ",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              Container(
                height: 50,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey)),
                margin: EdgeInsets.only(top: 8, left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    _pickFile(context);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: (width / 2) - 10,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Text("Choose From Files",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      Text(" No File Chosen ",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Technical Upload ",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              Container(
                height: 50,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey)),
                margin: EdgeInsets.only(top: 8, left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    _pickFile(context);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: (width / 2) - 10,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Text("Choose From Files",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      Text(" No File Chosen ",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),

              TextInput(
                height: 100,
                label: "Process",
                onPressed: () {
                  if (controller.managerSelection.value) {
                    controller.managerSelection.value = false;
                  } else {
                    controller.managerSelection.value = true;
                  }
                  controller.managerDetailsSelection.clear();
                  controller.managerDetailsSelection.add('InSource');
                  controller.managerDetailsSelection.add('OutSource');
                },
                controller: controller.processController,
                textInputType: TextInputType.number,
                textColor: Color(0xCC252525),
                hintText: "Enter Process",
                onTextChange: (String) {},
                obscureText: true,
                isReadOnly: true,
              ),
              Obx(() => Visibility(
                    visible: controller.managerSelection.value,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                        padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white, // Set the desired background color
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: List.generate(
                              controller.managerDetailsSelection.length,
                              (index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      TextInput(
                                        onPressed: () {
                                          controller
                                                  .processController.text =
                                              controller
                                                  .managerDetailsSelection[index];
                                          controller.managerSelection.value =
                                              false;
                                          controller.managerDetailsSelection
                                              .clear();

                                          //controller.typeController.text = "";

                                          controller.managerDetailsSelection
                                              .add('Month');

                                          controller.managerDetailsSelection
                                              .add('Day');
                                          controller.managerDetailsSelection
                                              .add('Lease');
                                          controller.managerDetailsSelection
                                              .add('One Time');
                                        },
                                        margin: false,
                                        isSelected: controller
                                                .processController.text ==
                                            controller
                                                .managerDetailsSelection[index]!,
                                        label: "",
                                        isEntryField: false,
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC234345),
                                        hintText: controller
                                            .managerDetailsSelection[index],
                                        onTextChange: (String) {},
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Visibility(
                                        visible: controller
                                                .managerDetailsSelection.length !=
                                            index + 1,
                                        child: Container(
                                          height: 1,
                                          color: AppTheme.primaryColor,
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
                  )),
              Container(
                width: width,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Button(
                      widthFactor: 0.9,
                      heightFactor: 0.06,
                      onPressed: () {
                        if (controller.userDataProvider.getCurrentStatus
                                .toString() ==
                            'Edit') {
                          controller.updateSalesTeam();
                        } else {
                          controller.insertSalesTeam();
                        }
                      },
                      child: Text(
                          controller.userDataProvider.getCurrentStatus
                                      .toString() ==
                                  'Edit'
                              ? "Update"
                              : "SUBMIT",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w600))),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey,
      actions: [
        KeyboardActionsItem(
          focusNode: controller.mobileNumberFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.secondaryContactFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.approxBudjetFocusNode,
        ),

      ],
    );
  }

}

_pickFile(BuildContext context) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Display the selected file path
      Get.snackbar(
        'File Selected',
        'Path: ${result.files.first.path}',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } else {
      // User canceled the file picker
      Get.snackbar(
        'File Picker',
        'User canceled file picking.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  } catch (e) {
    // Handle any exceptions that may occur during file picking
    Get.snackbar(
      'Error',
      'An error occurred: $e',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }
}
