

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/AppTab.dart';
import '../../Components/HorizontalScrollView.dart';
import '../../Controller/AssignProjectList.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class AssignProjectList extends GetView<AssignProjectListController> {
  const AssignProjectList({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AssignProjectListController controller =
        Get.put(AssignProjectListController());
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
                    width: 100,
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
          child: Column(
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
                            isSelected: controller.selectedTabIndex == index,
                            onClick: () =>
                                controller.updateCurrentTabIndex(index),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(() => controller.isLoading.value
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 10,
                          child: Center(child: CircularProgressIndicator()))
                      : Column(children: [
                          if (controller.selectedTabIndex == 0)
                            RefreshIndicator(
                              onRefresh: controller.refreshData,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height - 100,
                                child: ListView.builder(
                                    itemCount: controller.projectData.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: 40),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return progress(context, index);
                                    }),
                              ),
                            )
                          else if (controller.selectedTabIndex == 1)
                            RefreshIndicator(
                              onRefresh: controller.refreshData,
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height -
                                        100,
                                    child: ListView.builder(
                                        itemCount: 1,
                                        shrinkWrap: true,
                                        padding:
                                            const EdgeInsets.only(bottom: 40),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return complete(context, index);
                                        }),
                                  ),
                                ],
                              ),
                            )
                        ]))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget progress(BuildContext context, int index) {
    AssignProjectListController controller =
        Get.put(AssignProjectListController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.projectData[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 8,
                  ),
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
                    'ProjectProgress',
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Project Description :',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    model.projectDescp.toString() ?? "",
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Customer Required Date :',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    model.customerRequiredDate.toString() ?? "",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    widthFactor: 0.28,
                    heightFactor: 0.04,
                    onPressed: () {
                      controller.userDataProvider.setFactoryProjectData(model);
                      Get.toNamed(AppRoutes.assignMechanicalTeam.toName);
                    },
                    child: Text(
                      "Edit",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Button(
                    widthFactor: 0.28,
                    heightFactor: 0.04,
                    onPressed: () {
                      controller.userDataProvider.setFactoryProjectData(model);
                      Get.toNamed(AppRoutes.assignMechanicalTeam.toName);
                    },
                    child: Text(
                      "Assign",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }

  Widget complete(BuildContext context, int index) {
    AssignProjectListController controller =
        Get.put(AssignProjectListController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // var model = controller.technicalData[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 8,
                  ),
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
                    'Completed Team',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
