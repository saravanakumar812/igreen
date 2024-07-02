import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/routes/app_routes.dart';
import '../../Controller/ProfileScreenController.dart';
import '../../Utils/AppPreference.dart';
import '../../Utils/image_picker.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ProfileScreenController controller = Get.put(ProfileScreenController());
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
            title:  Text(
              'Profile',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),centerTitle: true,
            actions: [
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
            // flexibleSpace: Container(
            //   height: 80,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(0.0),
            //       bottomRight: Radius.circular(0.0),
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       // Container(
            //       //   child: InkWell(
            //       //       onTap: () {
            //       //         Get.back();
            //       //       },
            //       //       child: Padding(
            //       //         padding: EdgeInsets.symmetric(horizontal: 15),
            //       //         child: Column(
            //       //           children: [
            //       //             SizedBox(
            //       //               height: 23,
            //       //             ),
            //       //             Icon(
            //       //               Icons.arrow_back,
            //       //               color: Colors.black,
            //       //             ),
            //       //           ],
            //       //         ),
            //       //       )),
            //       // ),
            //       SizedBox(
            //         width: 120,
            //       ),
            //       Text(
            //         'Profile',
            //         style: GoogleFonts.poppins(
            //             color: Colors.black,
            //             fontSize: 15,
            //             fontWeight: FontWeight.w600),
            //       ),
            //       Spacer(),
            //       InkWell(
            //         onTap: () {
            //           Get.back();
            //         },
            //         child: Image.asset(
            //           "assets/images/logo.png",
            //           fit: BoxFit.contain,
            //           width: width * 0.3,
            //           height: height * 0.1,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ),
        body: Obx(() => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(children: [
                  SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        children: [
                          SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    ImagePick(
                                      isMultiple: true,
                                      title: "Profile ",
                                      onClose: () => Get.back(),
                                      onSave: (List<PickedImage> images) {
                                        if (images.isNotEmpty) {
                                          controller.item_image.value =
                                              images[0];
                                          controller.isImageSelected.value =
                                              true;
                                          // controller.clearImage();
                                        }

                                        Get.back();
                                      },
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      border: controller.isImageSelected.value
                                          ? null
                                          : Border.all(
                                              color: AppTheme.appBlack,
                                              width: 1),
                                      //
                                      // Add border for validation error
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          controller.item_image.value != null
                                              ? Image.file(
                                                  controller.item_image!
                                                              .value !=
                                                          null
                                                      ? controller.item_image!
                                                          .value!.imagePath
                                                      : "",
                                                  fit: BoxFit.cover,
                                                ).image
                                              : Image.asset(
                                                  'assets/images/logo.png',
                                                  fit: BoxFit.cover,
                                                ).image,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Text(
                                          "Welcome , ${AppPreference().getEmpName}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    //physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height - 210,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes
                                          .managerHierarchyBinding.toName);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.profileColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Image.asset(
                                                      "assets/images/hirarchy.png",
                                                      fit: BoxFit.contain,
                                                      width: width * 0.2,
                                                      height: height * 0.03,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            width: 0,
                                          ),
                                          Text(
                                            'Manager Hierarchy',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.getGreenThanks.toName);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.profileColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Image.asset(
                                                      "assets/images/greenthanks.png",
                                                      fit: BoxFit.contain,
                                                      width: width * 0.2,
                                                      height: height * 0.03,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            width: 0,
                                          ),
                                          Text(
                                            'GreenThank',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.griVance.toName);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.profileColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Image.asset(
                                                      "assets/images/grivance.png",
                                                      fit: BoxFit.contain,
                                                      width: width * 0.2,
                                                      height: height * 0.03,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            width: 0,
                                          ),
                                          Text(
                                            'Escalation',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.leaveStatusScreen.toName);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.profileColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Image.asset(
                                                      "assets/images/leaveApply.png",
                                                      fit: BoxFit.contain,
                                                      width: width * 0.2,
                                                      height: height * 0.03,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Text(
                                            'Leave Apply',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.changePassword.toName);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.profileColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Image.asset(
                                                      "assets/images/leaveApply.png",
                                                      fit: BoxFit.contain,
                                                      width: width * 0.2,
                                                      height: height * 0.03,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Text(
                                            'Change Password',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Button(
                                      widthFactor: 0.86,
                                      heightFactor: 0.06,
                                      onPressed: () {
                                        Get.offNamed(AppRoutes.login.toName);
                                      },
                                      child: Text('Logout',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontFamily: 'lato',
                                              fontWeight: FontWeight.w600))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              )),
      ),
    );
  }
}
