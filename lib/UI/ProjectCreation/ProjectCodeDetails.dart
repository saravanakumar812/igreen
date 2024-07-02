import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/ProjectCodeScreenController.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import 'ProjectCodeDetailsViewScreen.dart';

class ProjectCodeDetails extends GetView<ProjectCodeScreenController> {
  const ProjectCodeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectCodeScreenController controller =
        Get.put(ProjectCodeScreenController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppTheme.screenBackground,
      body: Column(
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Project Code",
                  style: TextStyle(color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/Group 14.png",
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
          Container(

            child: Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.siteProject!.isNotEmpty
                      ? SingleChildScrollView(
                          child: RefreshIndicator(
                            onRefresh: controller.refreshData,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: MediaQuery.of(context).size.height -
                                        235,
                                    child: ListView.builder(
                                      itemCount: controller.siteProject.length,
                                      itemBuilder: (context, index) {
                                        return summaryList(context, index);
                                      },
                                    ),
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
          )
        ],
      ),
    );
  }

  Widget summaryList(BuildContext context, int index) {
    ProjectCodeScreenController controller =
        Get.put(ProjectCodeScreenController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.siteProject[index];
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: AppTheme.grey),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: width * 0.65,
                decoration: BoxDecoration(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        model.projectCode.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Button(
                widthFactor: 0.2,
                heightFactor: 0.04,
                onPressed: (){
                  controller.userDataProvider.setSiteProjectCodeData(controller.siteProject[index]);
                   Get.to(ProjectCodeDetailsViewScreen());
                },
                child: Center(child: Text("More" ,style: TextStyle(color: Colors.white, fontSize: 10),)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
