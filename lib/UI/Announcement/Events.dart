import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/forms/theme.dart';
import '../../Controller/EventsController.dart';
import '../../routes/app_routes.dart';

class Events extends GetView<EventController> {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    EventController controller = Get.put(EventController());

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
            decoration: const BoxDecoration(
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
                      child: const Padding(
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
                const SizedBox(
                  width: 70,
                ),
                const Text(
                  "Events ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Spacer(),
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
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : controller.eventData!.isNotEmpty
                ? SingleChildScrollView(
                    child: RefreshIndicator(
                      onRefresh: controller.refreshData,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height - 100,
                            child: ListView.builder(
                              itemCount: controller.eventData.length,
                              itemBuilder: (context, index) {
                                return reviewList(context, index);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      child: Image.asset(
                        height: 250,
                        width: 250,
                        "assets/images/noData.png",
                      ),
                    ),
                  ),
      ),
    ));
  }
}

Widget reviewList(BuildContext context, int index) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  EventController controller = Get.put(EventController());
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.bgPink,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 22,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        (index + 1).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      controller.eventData[index].title.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    controller.eventData[index].startdate.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.09,
                ),
                Text(
                  "Message ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.eventData[index].descriptions.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.userDataProvider
                        .setEvent(controller.eventData[index]);

                    controller.userDataProvider.setCurrentStatus('');

                    controller.userDataProvider
                        .setCurrentStatus(controller.reuseButtonText.value);
                    Get.toNamed(AppRoutes.addEvents.toName);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                    width: width * 0.2,
                    height: height * 0.045,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromARGB(255, 179, 176, 176),
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      controller.reuseButtonText.value,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          letterSpacing: 0.1,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}
