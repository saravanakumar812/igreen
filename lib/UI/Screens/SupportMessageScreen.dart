import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import '../../Controller/SupportMessageScreenController.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';

class SupportMessageScreen extends GetView<SupportMessageScreenController> {
  const SupportMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SupportMessageScreenController controller =
        Get.put(SupportMessageScreenController());
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
                    width: 10,
                  ),
                  Text(
                    'Support',
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
                      width: width * 0.2,
                      height: height * 0.05,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextInput(
                height: 100,
                label: "Name",
                onPressed: () {},
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                isReadOnly: true,
                hintText: AppPreference().getEmpName.toString(),
                onTextChange: (String) {},
              ),
              TextInput(
                height: 100,
                label: "Mobile",
                onPressed: () {},
                isReadOnly: true,
                textInputType: TextInputType.number,
                textColor: Color(0xCC252525),
                hintText: AppPreference().getMobileNumber.toString(),
                onTextChange: (String) {},
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: TextField(
                  maxLines: 3,
                  controller: controller.messageController,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.grey),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Enter Your Message',
                    labelText: 'Message',
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: AppTheme.grey // Choose the desired alignment
                        ),
                    labelStyle: TextStyle(
                        fontSize: 14,
                        color: AppTheme.grey // Choose the desired alignment
                        ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.02),
                child: Center(
                  child: Button(
                      widthFactor: 0.9,
                      heightFactor: 0.06,
                      onPressed: () {
                        controller.support();
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
        ),
      ),
    );
  }
}
