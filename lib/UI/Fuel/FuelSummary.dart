import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Controller/FuelSummaryController.dart';
import '../../forms/theme.dart';
import '../../provider/menuProvider.dart';
import '../../routes/app_routes.dart';

class FuelSummary extends GetView<FuelSummaryController> {
  const FuelSummary({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    FuelSummaryController controller = Get.put(FuelSummaryController());
    controller.userDataProvider =
        Provider.of<menuDataProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        controller.getData.clear();
        controller.isCall = false;
        Get.offNamed(AppRoutes.fuelCategories.toName);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: GestureDetector(
            onTap: () {
              controller.userDataProvider.setCurrentStatus('');
              controller.userDataProvider.setCurrentStatus('Add');
              print("AddCode :  " +
                  controller.userDataProvider.getCurrentStatus.toString());
              Get.toNamed(AppRoutes.addFuelExpense.toName);
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
                            // controller.getData.clear();
                            // controller.isCall = false;
                            //controller.getFuelExpense();
                            Get.offNamed(AppRoutes.fuelCategories.toName);
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
                      controller.userDataProvider.subCategoryName.toString(),
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
                ? Center(child: CircularProgressIndicator(

            ))
                : controller.getData.isNotEmpty
                    ? SingleChildScrollView(
                        child: RefreshIndicator(
                          onRefresh: controller.refreshData,
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 100,
                                child: ListView.builder(
                                  itemCount: controller.getData.length,
                                  itemBuilder: (context, index) {
                                    return fuelList(context, index);
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
      ),
    );
  }

  Widget fuelList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    FuelSummaryController controller = Get.put(FuelSummaryController());
    var model = controller.getData[index];

    return (Column(
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
                    'Fuel',
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
                  ): Container()
                ],
              ),
              SizedBox(
                height: 5,
              ),
              controller.getData[index].category1.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Categories : ',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.getData[index].category1.toString(),
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
                    )
                  : Container(),
              controller.getData[index].category2.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Sub Categories :',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.getData[index].category2.toString(),
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
                    )
                  : Container(),
              controller.getData[index].category3.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Categories3 :',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.getData[index].category3.toString(),
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
                    )
                  : Container(),
              controller.getData[index].category4.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Categories4 :',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.getData[index].category4.toString(),
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
                    )
                  : Container(),
              controller.getData[index].category5.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Categories5 :',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.getData[index].category5.toString(),
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
                    )
                  : Container(),
              controller.getData[index].rentedOrOwned.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Rent & Own :',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.getData[index].rentedOrOwned
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
                      ],
                    )
                  : Container(),
              controller.getData[index].vendorName.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Vendor Name:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].vendorName.toString(),
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
                    )
                  : Container(),
              controller.getData[index].startingHr.toString() !=
                      "0000-00-00 00:00:00"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Starting Hr:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              model.startingHr ?? "",
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
                    )
                  : Container(),
              controller.getData[index].endHr.toString() !=
                      "0000-00-00 00:00:00"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Closing Hr:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].endHr!.toString(),
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
                    )
                  : Container(),
              controller.getData[index].quantity.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Quantity:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].quantity.toString(),
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
                    )
                  : Container(),
              controller.getData[index].rate.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Rate:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].rate.toString(),
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
                    )
                  : Container(),
              controller.getData[index].amount.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Amount:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].amount.toString(),
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
                    )
                  : Container(),

              controller.getData[index].comment.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Comments:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].comment.toString(),
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
                    )
                  : Container(),
              controller.getData[index].vechicalDetails.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Vechical Details:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].vechicalDetails
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
                      ],
                    )
                  : Container(),
              controller.getData[index].startKM.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Starting Km:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].startKM.toString(),
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
                    )
                  : Container(),
              controller.getData[index].endKM.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Ending Km:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].endKM.toString(),
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
                    )
                  : Container(),
              controller.getData[index].lumsumCharges.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Lumsum Charges:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].lumsumCharges
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
                      ],
                    )
                  : Container(),
              controller.getData[index].otherMachineCategories.toString() !=
                      "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Other Machine Categories:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].otherMachineCategories
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
                      ],
                    )
                  : Container(),
              controller.getData[index].rate.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Other Vehicle Categories:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].rate.toString(),
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
                    )
                  : Container(),
              controller.getData[index].phase.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Phase:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].phase.toString(),
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
                    )
                  : Container(),
              controller.getData[index].otherVehicleCategories.toString() !=
                      "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Other Phase:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].otherVehicleCategories
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
                      ],
                    )
                  : Container(),
              controller.getData[index].expenseAmount.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Expense Amount:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].expenseAmount
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
                      ],
                    )
                  : Container(),
              controller.getData[index].expenseDate.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Expense Date:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].expenseDate.toString(),
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
                    )
                  : Container(),
              controller.getData[index].expenseStatus.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Expense Status:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].expenseStatus.toString() == '0' ? "Pending" : controller.getData[index].expenseStatus.toString() ==  '1'  ? "Accept" : "Reject",
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
                    )
                  : Container(),
              controller.getData[index].createdAt.toString() != "null"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Created:',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.getData[index].createdAt.toString(),
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
                    )
                  : Container(),
              controller.getData[index].expenseAmount.toString() != "null"
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Amount:',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                controller.getData[index].expenseAmount
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                          .setFuelExpenseData(controller.getData[index]);
                      controller.userDataProvider.setCurrentStatus('');
                      controller.userDataProvider
                          .setCurrentStatus(controller.editButtonText.value);
                      Get.offNamed(AppRoutes.addFuelExpense.toName);
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
                  ):Container(),
                  GestureDetector(
                    onTap: () {
                      controller.userDataProvider
                          .setFuelExpenseData(controller.getData[index]);

                      controller.userDataProvider.setCurrentStatus('');

                      controller.userDataProvider
                          .setCurrentStatus(controller.reuseButtonText.value);
                      Get.offNamed(AppRoutes.addFuelExpense.toName);
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
    ));
  }
}
