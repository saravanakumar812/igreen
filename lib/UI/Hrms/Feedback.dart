import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/Controller/FeedbacsController.dart';
import 'package:igreen_flutter/forms/theme.dart';

import '../../api_config/ApiUrl.dart';
import '../../forms/forms.dart';
import '../../routes/app_routes.dart';

class FeedbackPage extends GetView<FeedBackController> {
  const FeedbackPage({super.key});

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    FeedBackController controller = Get.put(FeedBackController());
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
                        width: 70,
                      ),
                      Text(
                        'Feedback List',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {},
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
            body: Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.feedbackData!.isNotEmpty
                      ? SingleChildScrollView(
                          child: RefreshIndicator(
                            onRefresh: controller.refreshData,
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height - 100,
                                  child: ListView.builder(
                                    itemCount: controller.feedbackData.length,
                                    itemBuilder: (context, index) {
                                      return list(context, index);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
            )));
  }

  Widget list(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.feedbackData[index];
    return Column(children: [
      InkWell(
        onTap: () {},
        child: Container(
          width: width,
          height: height * 0.18,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppTheme.bgPink,
              boxShadow: [
                //BoxShadow(offset: Offset(2, 2)),
              ]),
          margin: EdgeInsets.all(10),
          child: Row(children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 10,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      ApiUrl.baseUrl + "escalation/" + model.images.toString(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.profileName.toString(),
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        letterSpacing: 0.1,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Reason:${model.messages.toString()}",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        letterSpacing: 0.1,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 80,
                  ),
                  child: Button(
                    widthFactor: 0.28,
                    heightFactor: 0.04,
                    onPressed: () {
                      controller.userDataProvider.setFeedbackValues(model);
                      Get.toNamed(AppRoutes.feedbackRespond.toName);
                    },
                    child: Text(
                      "Respond",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ]),
            )
          ]),
        ),
      ),
    ]);
  }
}
