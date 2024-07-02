import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/api_config/ApiUrl.dart';
import '../../Controller/ExpenseScreenController.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class ExpenseScreen extends GetView<ExpenseScreenController> {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ExpenseScreenController controller = Get.put(ExpenseScreenController());
    controller.getBalance();
    WidgetsBinding.instance?.addPostFrameCallback((_) {});
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
                      "Expense Tracker",
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
                : RefreshIndicator(
                    onRefresh: controller.refreshData,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: AppTheme.secondaryColor),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.search_sharp,
                                    size: 25, color: Colors.black26),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Search Categories',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black45),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Text(
                                      "Total Available Cash:\n\$${controller.totalBalanceValue.toString() ?? 0}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: controller
                                                    .totalBalanceValue.value !=
                                                '0'
                                            ? Colors
                                                .red // Set to red if the value is negative
                                            : AppTheme
                                                .secondaryColor, // Use secondary color for positive or zero values
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Obx(
                                    () => Text(
                                      "Available Cash \nFor This Project:\n\$${controller.CurrentProjecttotalBalanceValue.toString() ?? 0}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: controller
                                                    .totalBalanceValue.value !=
                                                '0'
                                            ? Colors
                                                .red // Set to red if the value is negative
                                            : AppTheme
                                                .secondaryColor, // Use secondary color for positive or zero values
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.summaryScreen.toName);
                                },
                                child: Container(
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                      color: AppTheme.secondaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Summary',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SingleChildScrollView(
                            child: SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height -250 ,
                              child: GridView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 1,
                                  childAspectRatio: 1.25,
                                  // childAspectRatio: 0.85,
                                ),
                                itemCount: controller.fetchData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Color itemColor = controller.myColors[
                                      index % controller.myColors.length];

                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.userDataProvider
                                                .setExpenseId(controller
                                                    .fetchData[index]
                                                    .expenseCategoryId);
                                            if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Fuel') {
                                              Get.toNamed(AppRoutes
                                                  .fuelCategories.toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Rental') {
                                              Get.toNamed(
                                                  AppRoutes.rentSummary.toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Accommodation') {
                                              Get.toNamed(AppRoutes
                                                  .accommodationSummary.toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Travel') {
                                              Get.toNamed(AppRoutes
                                                  .travelSummaryScreen.toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Food') {
                                              Get.toNamed(AppRoutes
                                                  .foodSummaryScreen.toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Repairs and Maintenance') {
                                              Get.toNamed(AppRoutes
                                                  .repairsAndMaintenanceSummaryScreen
                                                  .toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'General') {
                                              Get.toNamed(AppRoutes
                                                  .generalSummaryScreen.toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Wages') {
                                              Get.toNamed(AppRoutes
                                                  .wagesSummaryScreen.toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Purchases') {
                                              Get.toNamed(AppRoutes
                                                  .purchaseSummaryScreen.toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Utilization') {
                                              Get.toNamed(AppRoutes
                                                  .utilizationSummaryScreen
                                                  .toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Others') {
                                              Get.toNamed(AppRoutes
                                                  .addOthersSummaryScreen.toName);
                                            } else if (controller.fetchData[index]
                                                    .expenseCategoryName ==
                                                'Transport') {
                                              Get.toNamed(AppRoutes
                                                  .transportSummaryScreen.toName);
                                            }
                                          },
                                          child: Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: itemColor,
                                              ),
                                            ),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.12,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                  color: itemColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: AppTheme.grey,
                                                        spreadRadius: 0,
                                                        blurRadius: 2)
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.network(
                                                    ApiUrl.baseUrl +
                                                        "category_icons/" +
                                                        controller
                                                            .fetchData[index]
                                                            .expenseCategoryImage
                                                            .toString(),
                                                    fit: BoxFit.contain,
                                                    width: width * 0.2,
                                                    height: height * 0.03,
                                                  ),
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    controller.fetchData[index]
                                                        .expenseCategoryName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }
}
