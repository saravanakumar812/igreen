import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/forms/theme.dart';

import '../../Controller/ProjectCodeDetailsViewScreenController.dart';
import '../projectCreation/UPdate_Site_Projects.dart';

class ProjectCodeDetailsViewScreen
    extends GetView<ProjectCodeDetailsViewScreenController> {
  const ProjectCodeDetailsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectCodeDetailsViewScreenController controller =
    Get.put(ProjectCodeDetailsViewScreenController());

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
          Padding(
              padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),child: Container(
            width: width,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: width / 5,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                            color: AppTheme.secondaryColor,
                            border: Border(
                                bottom: BorderSide(color: AppTheme.grey),
                                right:
                                BorderSide(color: AppTheme.grey))),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        width: width / 4,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppTheme.secondaryColor,
                            border: Border(
                              bottom: BorderSide(color: AppTheme.grey),
                                right:
                                BorderSide(color: AppTheme.grey)
                            )),
                        child: Align(
                          alignment: Alignment.center,

                          child: Text(
                            "Team",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 13, color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        width: width / 4,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppTheme.secondaryColor,
                            border: Border(
                              bottom: BorderSide(color: AppTheme.grey),
                                right:
                                BorderSide(color: AppTheme.grey)
                            )),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "     Last \n Updated",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 13, color: Colors.black),
                          ),
                        ),
                      ), Container(
                        width: width / 4.05,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                          color: AppTheme.secondaryColor,
                            border: Border(
                              bottom: BorderSide(color: AppTheme.grey),

                            )),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Updated by",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 13, color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: width / 5,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(

                                right:
                                BorderSide(color: AppTheme.grey))),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            controller.userDataProvider.getSiteProjectCode!.date.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        width: width / 4,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(

                                right:
                                BorderSide(color: AppTheme.grey)
                            )),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            controller.userDataProvider.getSiteProjectCode!.department.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 13, color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        width: width / 4,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(

                                right:
                                BorderSide(color: AppTheme.grey)
                            )),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            controller.userDataProvider.getSiteProjectCode!.lastUpdatedDate.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 13, color: Colors.black),
                          ),
                        ),
                      ), Container(
                        width: width / 4.05,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(


                            )),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            controller.userDataProvider.getSiteProjectCode!.lastUpdatedEmployeeName.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 13, color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
          ),
           Padding(
             padding: const EdgeInsets.all(15.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 InkWell(
                   onTap: (){
                   controller.getParticularSiteProjectApi(controller.userDataProvider.getSiteProjectCode!.siteProjectId.toString());
                   },
                   child: Container(
                     width: 80,
                     height: 33,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(4),
                         border: Border.all(width: 1,color: AppTheme.secondaryColor)
                     ),
                     child: const Center(child: Text("Edit",style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w600,
                       color: AppTheme.secondaryColor,

                     ),)),
                   ),
                 ),
                 const SizedBox(
                   width: 8,
                 ),
                 InkWell(
                   onTap: (){},
                   child: Container(
                     width: 80,
                     height: 33,
                     decoration: BoxDecoration(
                         color: AppTheme.secondaryColor,
                         borderRadius: BorderRadius.circular(4),
                         border: Border.all(width: 1,color: AppTheme.secondaryColor)
                     ),
                     child: const Center(child: Text("View",style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w600,
                       color: AppTheme.white,


                     ),)),
                   ),
                 ),
               ],
             ),
           )
        ],
      ),
    );
  }
}
