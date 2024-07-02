import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/ChangePasswordScreenController.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';

class ForgotPasswordScreen extends GetView<ChangePasswordScreenController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordScreenController controller =
        Get.put(ChangePasswordScreenController());
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                Text(
                  'Forgot Password',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
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
      body: Column(
        children: [
          // Padding(
          //     padding: const EdgeInsets.only(right: 15, left: 15),
          //     child: Obx(()=> TextFormField(
          //         keyboardType: TextInputType.visiblePassword,
          //         obscureText: controller.oldPass.value,
          //         controller: controller.oldPassController,
          //         decoration: InputDecoration(
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(10)),
          //           hintText: 'Enter Old Password',
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500,
          //             color: Color(0xFF475269),
          //           ),
          //           prefixIcon: Icon(
          //             Icons.lock,
          //             size: 27,
          //             color: Color(0xFF475269),
          //           ),
          //           suffixIcon:
          //           InkWell(
          //             onTap: () {
          //
          //               controller.oldPass.value = !controller.oldPass.value;
          //
          //             },
          //             child: Icon(
          //                 controller.oldPass.value ? Icons.visibility_off : Icons.visibility),
          //           ),
          //         )))
          //
          // ),
          // SizedBox(height: 20,),
          //
          // Padding(
          //     padding: const EdgeInsets.only(right: 15, left: 15),
          //     child: Obx(()=>TextFormField(
          //         keyboardType: TextInputType.visiblePassword,
          //         obscureText: controller.newPass.value,
          //         controller: controller.newPassController,
          //         decoration: InputDecoration(
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(10)),
          //           hintText: 'Enter New Password',
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500,
          //             color: Color(0xFF475269),
          //           ),
          //           prefixIcon: Icon(
          //             Icons.lock,
          //             size: 27,
          //             color: Color(0xFF475269),
          //           ),
          //           suffixIcon: InkWell(
          //             onTap: () {
          //
          //               controller.newPass.value = !controller.newPass.value;
          //
          //             },
          //             child: Icon(
          //                 controller.newPass.value ? Icons.visibility_off : Icons.visibility),
          //           ),
          //         )))),
          // SizedBox(height: 20,),
          //
          // Padding(
          //     padding: const EdgeInsets.only(right: 15, left: 15),
          //     child: Obx(()=> TextFormField(
          //         keyboardType: TextInputType.visiblePassword,
          //         obscureText: controller.conFirmPass.value,
          //         controller: controller.confirmPassController,
          //         decoration: InputDecoration(
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(10)),
          //           hintText: 'Enter confirm Password',
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500,
          //             color: Color(0xFF475269),
          //           ),
          //           prefixIcon: Icon(
          //             Icons.lock,
          //             size: 27,
          //             color: Color(0xFF475269),
          //           ),
          //           suffixIcon: InkWell(
          //             onTap: () {
          //
          //               controller.conFirmPass.value = !controller.conFirmPass.value;
          //
          //             },
          //             child: Icon(
          //                 controller.conFirmPass.value ? Icons.visibility_off : Icons.visibility),
          //           ),
          //         )))),
          SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Container(
                decoration: BoxDecoration(
                    //color: AppTheme.borderColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child:  TextFormField(
                    controller: controller.mobileNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.lableColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.lableColor),
                      ),
                      hintText: "Enter Mobile number".tr,
                      hintStyle: const TextStyle(
                          fontSize: 13.0,
                          color: AppTheme.appBlack,
                          fontWeight: FontWeight.w700),
                      contentPadding: const EdgeInsets.only(left: 20),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.lableColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        decorationThickness: 0,
                        color: AppTheme.appBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
          ),
          SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Container(
                decoration: BoxDecoration(
                    //color: AppTheme.borderColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Obx(
                  () => TextFormField(
                    controller: controller.newPassController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.newPass.value,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.lableColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.lableColor),
                      ),
                      hintText: "Enter New Password".tr,
                      hintStyle: const TextStyle(
                          fontSize: 13.0,
                          color: AppTheme.appBlack,
                          fontWeight: FontWeight.w700),
                      contentPadding: const EdgeInsets.only(left: 20),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.lableColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.newPass.value = !controller.newPass.value;
                        },
                        child: Icon(
                          controller.newPass.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppTheme.appBlack,
                        ),
                      ),
                    ),
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        decorationThickness: 0,
                        color: AppTheme.appBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Container(
                decoration: BoxDecoration(
                    //color: AppTheme.borderColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Obx(
                  () => TextFormField(
                    controller: controller.confirmPassController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.conFirmPass.value,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.lableColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.lableColor),
                      ),
                      hintText: "Enter Confirm Password".tr,
                      hintStyle: const TextStyle(
                          fontSize: 13.0,
                          color: AppTheme.appBlack,
                          fontWeight: FontWeight.w700),
                      contentPadding: const EdgeInsets.only(left: 20),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.lableColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.conFirmPass.value =
                              !controller.conFirmPass.value;
                        },
                        child: Icon(
                          controller.conFirmPass.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppTheme.appBlack,
                        ),
                      ),
                    ),
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        decorationThickness: 0,
                        color: AppTheme.appBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),

          Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: Button(
                  widthFactor: 0.9,
                  heightFactor: 0.06,
                  onPressed: () {
                    controller.forgotPassword();
                  },
                  child: const Text("Submit ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w600))),
            ),
          )
        ],
      ),
    ));
  }
}
