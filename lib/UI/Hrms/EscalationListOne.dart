import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/forms/forms.dart';
import 'package:igreen_flutter/forms/theme.dart';
import '../../Controller/EscalationOneController.dart';
import '../../api_config/ApiUrl.dart';
import '../../routes/app_routes.dart';

class EscalationListOne extends GetView<EscalationOneController> {
  const EscalationListOne({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    EscalationOneController controller = Get.put(EscalationOneController());
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
                        'Escalation List',
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
                  : controller.escalationData!.isNotEmpty
                      ? SingleChildScrollView(
                          child: RefreshIndicator(
                            onRefresh: controller.refreshData,
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height - 100,
                                  child: ListView.builder(
                                    itemCount: controller.escalationData.length,
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
    var model = controller.escalationData[index];
    return Container(
      width: width,
      height: height * 0.18,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.bgPink,
          boxShadow: [
            //BoxShadow(offset: Offset(2, 2)),
          ]),
      margin: EdgeInsets.all(10),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        onTap: () {
          controller.userDataProvider.setEscalationValues(model);
          Get.toNamed(AppRoutes.escalationTwo.toName);
        },
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            ApiUrl.baseUrl + "escalation/" + model.profileImage.toString(),
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(top: 10, bottom: 20),
          child: Text(
            model.profileName.toString(),
            style: GoogleFonts.poppins(
                color: Colors.black,
                letterSpacing: 0.1,
                fontSize: 13,
                fontWeight: FontWeight.w700),
          ),
        ),
        subtitle: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Button(
                    widthFactor: 0.28,
                    heightFactor: 0.04,
                    onPressed: () {
                      controller.userDataProvider.setEscalationValues(model);
                      Get.toNamed(AppRoutes.escalationTwo.toName);
                    },
                    child: Text(
                      "Response",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
    );


  }
}
