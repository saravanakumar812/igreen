import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:provider/provider.dart';
import '../../Controller/LoginController.dart';
import '../../forms/forms.dart';
import '../../api_config/ApiUrl.dart';
import '../../forms/theme.dart';
import '../../provider/menuProvider.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    LoginController Controller = Get.put(LoginController());
    controller.userDataProvider =
        Provider.of<menuDataProvider>(context, listen: false);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Obx(() => Controller.initialLoading.isFalse
            ? Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: AppTheme.appColor,
                ),
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                        width: width * 0.5,
                        height: height * 0.2,
                      ),
                      const Text(
                        "Welcome Igreener's",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.secondaryColor),
                      ),
                      const SizedBox(height: 39),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            controller.selectDropDown.value =
                                !controller.selectDropDown.value;
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppTheme.inputBorderColor,
                                      width: 1),
                                  color: AppTheme.appColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                controller.selectItemOne.value,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xCC252525),
                                    fontSize: 14),
                              )),
                            ),
                          ),
                        ),
                      ),
                      Obx(() => Visibility(
                            visible: controller.selectDropDown.value,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 25,
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
                                      controller.selectedItemDropDown.length,
                                      (index) {
                                        return Container(
                                          child: Column(
                                            children: [
                                              TextInput(
                                                onPressed: () {
                                                  controller.selectItemOne
                                                      .value = controller
                                                          .selectedItemDropDown[
                                                      index];

                                                  controller.selectDropDown
                                                      .value = false;
                                                },
                                                margin: false,
                                                isSelected: controller
                                                        .selectItemOne.value ==
                                                    controller
                                                            .selectedItemDropDown[
                                                        index]!,
                                                label: '',
                                                isEntryField: false,
                                                textInputType:
                                                    TextInputType.text,
                                                textColor: Color(0xCC234345),
                                                hintText: controller
                                                        .selectedItemDropDown[
                                                    index]!,
                                                onTextChange: (String) {},
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Visibility(
                                                visible: controller
                                                        .selectedItemDropDown
                                                        .length !=
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
                      TextInput(
                          controller: controller.phoneNoController,
                          height: 100,
                          label: "Mobile Number",
                          onTextChange: (text) {},
                          textInputType: TextInputType.phone,
                          textColor: Color(0xCC252525),
                          hintText: "Enter Mobile Number"),
                      const SizedBox(height: 5),
                      TextInput(
                          controller: controller.passwordController,
                          height: 100,
                          MaxLength: 10,
                          label: "Password",
                          onTextChange: (text) {},
                          textInputType: TextInputType.text,
                          textColor: Color(0xCC252525),
                          hintText: "Enter your Password"),
                      const SizedBox.shrink(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [ InkWell(
                          onTap: (){
                            Get.toNamed(AppRoutes.forgotPassword.toName);
                          },
                          child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                        ),
                      ]),

                      const SizedBox.shrink(),

                      const SizedBox(
                        height: 20,
                      ),

                      Center(
                        child: Button(
                            widthFactor: 0.9,
                            heightFactor: 0.06,
                            onPressed: () {
                              var value = controller.firstValidation();
                              if (value) {
                                controller.loginCall(context);
                              }
                            },
                            child: const Text("LOGIN",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600))),
                      ),

                      AppPreference().getEmpId.toString() == "0"
                          ? Container()
                          : Container(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: Text("or Sign in With Bio Metric ",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontFamily: 'lato',
                                              fontWeight: FontWeight.w300))),
                                  IconButton(
                                    onPressed: controller.authenticate,
                                    icon: Icon(
                                      Icons.fingerprint,
                                      size: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                      const SizedBox(
                        height: 80,
                      ),
                      Center(
                          child: Text("Version : " + ApiUrl.appVersion,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.secondaryColor,
                                  fontFamily: 'lato',
                                  fontWeight: FontWeight.w600))),
                      //const SizedBox(height: 60),
                    ],
                  ),
                ))
            : const Center(
                child: CircularProgressIndicator(),
              )));
  }
}
