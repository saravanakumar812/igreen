import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/OfficeSummaryScreenController.dart';
import '../../Controller/RentalSummaryController.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class OfficeSummaryScreen extends GetView<OfficeSummaryScreenController> {
  const OfficeSummaryScreen({super.key});



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    OfficeSummaryScreenController controller = Get.put(OfficeSummaryScreenController());

    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            controller.userDataProvider.setCurrentStatus('');
            controller.userDataProvider.setCurrentStatus('Add');
            print("AddCode :  " +
                controller.userDataProvider.getCurrentStatus.toString());

            Get.offNamed(AppRoutes.officeAdd.toName);
          },
          child: Container(
            width: 45,
            height: 45,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                color: AppTheme.secondaryColor,
                borderRadius: BorderRadius.circular(22.5)),
          ),
        ),
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
                          Get.offNamed(AppRoutes.bottomNavBar.toName);
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
                    "Office ",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      // Get.toNamed(AppRoutes.fuelSummary.toName);
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
        body: Obx(
              () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.getOfficeEmployeeData.isNotEmpty
              ? SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: controller.refreshData,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 100,
                    child: ListView.builder(
                      itemCount: controller.getOfficeEmployeeData.length,
                      itemBuilder: (context, index) {
                        return rentList(context, index);
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
        ),
      ),
    );
  }

  Widget rentList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    OfficeSummaryScreenController controller = Get.put(OfficeSummaryScreenController());
    var model = controller.getOfficeEmployeeData[index];

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
                    "Office",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      controller.selectedValues.value = index;
                      controller.statusUpdate();
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              controller.getOfficeEmployeeData[index].category!.isNotEmpty ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Categories :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        controller.getOfficeEmployeeData[index].category.toString(),
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
                ],
              ): Container(),
              controller.getOfficeEmployeeData[index].comments.toString() != "null" ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'comments :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        controller.getOfficeEmployeeData[index].comments.toString(),
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
                ],
              ) : Container() ,
              controller.getOfficeEmployeeData[index].amount.toString() != "0" ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Amount :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        controller.getOfficeEmployeeData[index].amount.toString(),
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
                ],
              ) : Container() ,
              controller.getOfficeEmployeeData[index].spendDate.toString() != "null" ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Spend Date :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        controller.getOfficeEmployeeData[index].spendDate.toString(),
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
                ],
              ) : Container() ,





              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.userDataProvider
                          .setOfficeEmployee(controller.getOfficeEmployeeData[index]);

                      controller.userDataProvider.setCurrentStatus('');
                      controller.userDataProvider
                          .setCurrentStatus(controller.editButtonText.value);
                      Get.offNamed(AppRoutes.officeAdd.toName);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      width: width * 0.18,
                      height: height * 0.045,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 179, 176, 176),
                              width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                            controller.editButtonText.value,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                letterSpacing: 0.1,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.userDataProvider
                          .setOfficeEmployee(controller.getOfficeEmployeeData[index]);

                      controller.userDataProvider.setCurrentStatus('');
                      controller.userDataProvider
                          .setCurrentStatus(controller.reuseButtonText.value);
                      Get.offNamed(AppRoutes.officeAdd.toName);
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
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
