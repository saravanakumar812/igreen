import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/FoodSummaryController.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class FoodSummaryScreen extends GetView<FoodSummaryController> {
  const FoodSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    FoodSummaryController controller = Get.put(FoodSummaryController());

    return WillPopScope(
        onWillPop: () async {
          controller.getBalance();
          controller.isCall.value = false;
          Get.offNamed(AppRoutes.expenseScreen.toName);
          return false;
        },
        child: SafeArea(
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
                      //       WillPopScope(
                      //       onWillPop: () async {
                      //
                      // controller.isCall.value = false;
                      // Get.offNamed(AppRoutes.expenseScreen.toName);
                      // return false;
                      // },child: const Padding(
                      //         padding: EdgeInsets.symmetric(horizontal: 15),
                      //         child: Column(
                      //           children: [
                      //             SizedBox(
                      //               height: 23,
                      //             ),
                      //             Icon(
                      //               Icons.arrow_back,
                      //               color: Colors.black,
                      //             ),
                      //           ],
                      //         ),
                      //       )),
                      Container(
                        child: InkWell(
                            onTap: () {
                              Get.offNamed(AppRoutes.expenseScreen.toName);
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
                        "Food Summary",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                        width: width * 0.3,
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
                  : controller.foodData!.isNotEmpty
                      ? SingleChildScrollView(
                          child: RefreshIndicator(
                            onRefresh: controller.refreshData,
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height - 100,
                                  child: ListView.builder(
                                    itemCount: controller.foodData.length,
                                    itemBuilder: (context, index) {
                                      return summaryList(context, index);
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
            floatingActionButton: GestureDetector(
              onTap: () {
                controller.userDataProvider.setCurrentStatus('');
                controller.userDataProvider.setCurrentStatus('Add');
                print("AddCode :  " +
                    controller.userDataProvider.getCurrentStatus.toString());

                Get.toNamed(AppRoutes.foodEntryScreen.toName);
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
          ),
        ));
  }

  Widget summaryList(BuildContext context, int index) {
    FoodSummaryController controller = Get.put(FoodSummaryController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.foodData[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 22,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        controller.foodData[index].category1.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Spacer(),
                      model.expenseStatus != "1"?
                      InkWell(
                        onTap: () {
                          controller.selectedValues.value = index;
                          controller.statusUpdate();
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ) : Container()
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              controller.foodData[index].category1.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Categories :',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              model.category1 ?? "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : Container(),
              controller.foodData[index].category2.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Sub Categories :',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              model.category2 ?? "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : Container(),
              controller.foodData[index].noOfPeople.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'No Of People:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              model.noOfPeople ?? "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : Container(),
              controller.foodData[index].rate.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Rate:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              model.rate ?? "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : Container(),
              controller.foodData[index].totalAmount.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Total Amount:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              model.totalAmount ?? "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : Container(),
              controller.foodData[index].comments.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Comments:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              model.comments ?? "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : Container(),
              controller.foodData[index].expenseDate.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Expense Date:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              model.expenseDate ?? "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : Container(),
              controller.foodData[index].expenseStatus.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Expense Status:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              model.expenseStatus.toString() == '0'
                                  ? "Waiting for Approval"
                                  : model.expenseStatus.toString() == '1'
                                      ? "Accept"
                                      : "Reject",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : Container(),
              controller.foodData[index].totalAmount.toString() != "null"
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                'Amount:',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                model.totalAmount ?? "",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  model.expenseStatus != "1"?
                  GestureDetector(
                    onTap: () {
                      controller.userDataProvider
                          .setFoodExpenseData(controller.foodData[index]);
                      controller.userDataProvider.setCurrentStatus('');
                      controller.userDataProvider
                          .setCurrentStatus(controller.editButtonText.value);
                      Get.offNamed(AppRoutes.foodEntryScreen.toName);
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
                        "Edit",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            letterSpacing: 0.1,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
                  ) : Container(),
                  GestureDetector(
                    onTap: () {
                      controller.userDataProvider
                          .setFoodExpenseData(controller.foodData[index]);
                      controller.userDataProvider.setCurrentStatus('');
                      controller.userDataProvider
                          .setCurrentStatus(controller.reuseButtonText.value);
                      Get.offNamed(AppRoutes.foodEntryScreen.toName);
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
                        "Re-Use",
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
