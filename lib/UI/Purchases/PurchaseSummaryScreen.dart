import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../forms/theme.dart';
import '../../../routes/app_routes.dart';
import '../../Controller/PurchaseSummaryController.dart';

class PurchaseSummaryScreen extends GetView<PurchaseSummaryController> {
  const PurchaseSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PurchaseSummaryController controller = Get.put(PurchaseSummaryController());

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
                    "Purchase",
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
              : controller.purchaseData!.isNotEmpty
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: controller.refreshData,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height - 100,
                              child: ListView.builder(
                                itemCount: controller.purchaseData.length,
                                itemBuilder: (context, index) {
                                  return purchaseList(context, index);
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
            Get.offNamed(AppRoutes.purchaseEntryScreen.toName);
            Get.deleteAll();
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
    );
  }

  Widget purchaseList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var model = controller.purchaseData[index];
    return (Column(
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
                      const Text(
                        'Purchases',
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
                  ),  const SizedBox(
                    height: 5,
                  ),
                ],
              ),

              Column(
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
                        width: 5,
                      ),
                      Text(
                        controller.purchaseData[index].category1.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ), SizedBox(height: 5,)
                ],
              ),

              Column(
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
                        width: 5,
                      ),
                      Text(
                        controller.purchaseData[index].category2.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ), SizedBox(height: 5,)
                ],
              ),
              controller.purchaseData[index].category3.toString() != "null" ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Category3 : ',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        controller.purchaseData[index].category3.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ), SizedBox(height: 5,)
                ],
              ) : Container(),
              controller.purchaseData[index].materialName.toString() != "null" ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Material Name :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        controller.purchaseData[index].materialName.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ), SizedBox(height: 5,)
                ],
              ) : Container(),
              controller.purchaseData[index].unit.toString() != "null" ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Unit :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        controller.purchaseData[index].unit.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ), SizedBox(height: 5,)
                ],
              ): Container(),
              controller.purchaseData[index].owner.toString() != "null" ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Owner Name :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        controller.purchaseData[index].owner.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ), SizedBox(height: 5,)
                ],
              ): Container(),
              controller.purchaseData[index].comments.toString() != "null" ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Comments :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        controller.purchaseData[index].comments.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ), SizedBox(height: 5,)
                ],
              ) :Container(),
              controller.purchaseData[index].currentlyPaidAmount.toString() != "null" ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                         'Currently Paid Amount :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        controller.purchaseData[index].currentlyPaidAmount.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ), SizedBox(height: 5,)
                ],
              ): Container(),
              controller.purchaseData[index].balanceAmount.toString() != "null" ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Balance Amount :',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        controller.purchaseData[index].balanceAmount.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ), SizedBox(height: 5,)
                ],
              ) :Container(),
              controller.purchaseData[index].amount.toString() != "null" ?
              Column(
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
                          'Amount :',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          controller.purchaseData[index].amount.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ) :Container(),


              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.userDataProvider
                          .setPurchaseData(controller.purchaseData[index]);

                      controller.userDataProvider.setCurrentStatus('');
                      controller.userDataProvider
                          .setCurrentStatus(controller.editButtonText.value);
                      Get.toNamed(AppRoutes.purchaseEntryScreen.toName);
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
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.userDataProvider
                          .setPurchaseData(controller.purchaseData[index]);

                      controller.userDataProvider.setCurrentStatus('');

                      controller.userDataProvider
                          .setCurrentStatus(controller.reuseButtonText.value);
                      Get.toNamed(AppRoutes.purchaseEntryScreen.toName);
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
        const SizedBox(
          height: 50,
        )
      ],
    ));
  }
}
