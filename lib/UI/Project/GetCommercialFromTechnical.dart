import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/GetCommercialFromTechnicalController.dart';
import '../../forms/theme.dart';

class GetCommercialFromTechnical
    extends GetView<GetCommercialFromTechnicalController> {
  const GetCommercialFromTechnical({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    GetCommercialFromTechnicalController controller =
        Get.put(GetCommercialFromTechnicalController());

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

                const Text(
                  "Get Commercial From Technical ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Spacer(),
                Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                  width: width * 0.28,
                  height: height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : controller
                    .userDataProvider
                    .getCommercialFromTechnicalResponseData!
                    .factoryProjectsItems!
                    .isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height - 100,
                          child: ListView.builder(
                            itemCount: controller
                                .userDataProvider
                                .getCommercialFromTechnicalResponseData!
                                .factoryProjectsItems!
                                .length,
                            itemBuilder: (context, index) {
                              return getCommercialFromTechnicalList(
                                  context, index);
                            },
                          ),
                        )
                      ],
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

Widget getCommercialFromTechnicalList(BuildContext context, int index) {
  GetCommercialFromTechnicalController controller =
      Get.put(GetCommercialFromTechnicalController());
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  print(json.encode({
    'commercisdgrdgalData': controller
        .userDataProvider.getCommercialFromTechnicalResponseData!.customerName
  }));
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
                  'Commercial From Technical',
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
                  " ItemId:",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller
                      .userDataProvider
                      .getCommercialFromTechnicalResponseData!
                      .factoryProjectsItems![index]
                      .itemId
                      .toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
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
                  width: 8,
                ),
                Text(
                  'factoryProjectId:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller
                      .userDataProvider
                      .getCommercialFromTechnicalResponseData!
                      .factoryProjectsItems![index]
                      .factoryProjectId
                      .toString(),
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
                  'ItemCode:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller
                      .userDataProvider
                      .getCommercialFromTechnicalResponseData!
                      .factoryProjectsItems![index]
                      .itemCode
                      .toString(),
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
                  'ItemDescription',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller
                      .userDataProvider
                      .getCommercialFromTechnicalResponseData!
                      .factoryProjectsItems![index]
                      .itemDescription
                      .toString(),
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
                  'Quantity :',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller
                      .userDataProvider
                      .getCommercialFromTechnicalResponseData!
                      .factoryProjectsItems![index]
                      .quantity
                      .toString(),
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
                  'Size:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller
                      .userDataProvider
                      .getCommercialFromTechnicalResponseData!
                      .factoryProjectsItems![index]
                      .size
                      .toString(),
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
                  'ItemName : ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller
                      .userDataProvider
                      .getCommercialFromTechnicalResponseData!
                      .factoryProjectsItems![index]
                      .itemName
                      .toString(),
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
                  'ItemValue : ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller
                      .userDataProvider
                      .getCommercialFromTechnicalResponseData!
                      .factoryProjectsItems![index]
                      .itemValue
                      .toString(),
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
                  'RawMaterialGrade : ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller
                      .userDataProvider
                      .getCommercialFromTechnicalResponseData!
                      .factoryProjectsItems![index]
                      .rawMaterialGrade
                      .toString(),
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
