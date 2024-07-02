import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igreen_flutter/api_config/ApiUrl.dart';
import 'package:provider/provider.dart';
import '../../Controller/FuelCategoriesController.dart';
import '../../forms/theme.dart';
import '../../provider/menuProvider.dart';
import '../../routes/app_routes.dart';

class FuelCategories extends GetView<FuelCategoriesController> {
  const FuelCategories({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    FuelCategoriesController controller = Get.put(FuelCategoriesController());
    controller.userDataProvider =
        Provider.of<menuDataProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.isCall) {
        controller.isCall = false;
        controller.subCategoryFuel("");
      }
    });

    return WillPopScope(
        onWillPop: () async {
         // controller.getData.clear();
          controller.isCall = false;
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
                              Get.toNamed(AppRoutes.expenseScreen.toName);
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
                        "Fuel Categories",
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
                  : Column(
                      children: [
                        SingleChildScrollView(
                          child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height - 210,
                            child: GridView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 1,
                                childAspectRatio: 1.25,
                                // childAspectRatio: 0.85,
                              ),
                              itemCount: controller.fuelSubCategoryData.length,
                              // controller.fuelSubCategoryData.length,
                              itemBuilder: (BuildContext context, int index) {
                                Color itemColor = controller
                                    .myColors[index % controller.myColors.length];

                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.userDataProvider
                                            .setSubOneCategoryId(controller
                                                .fuelSubCategoryData[index]
                                                .sub1CategoryId);

                                        controller.userDataProvider.setFuelTypes(
                                            controller.fuelSubCategoryData[index]
                                                .sub1CategoryName);

                                        print("types123455: " +
                                            controller.fuelSubCategoryData[index]
                                                .sub1CategoryName
                                                .toString());
                                        Get.toNamed(AppRoutes.fuelSummary.toName);
                                      },
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: itemColor,
                                          ),
                                        ),
                                        child: Container(
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.12,
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.3,
                                          decoration: BoxDecoration(
                                              color: itemColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: itemColor,
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
                                                        .fuelSubCategoryData[
                                                            index]
                                                        .sub1CategoryImage
                                                        .toString(),
                                                fit: BoxFit.contain,
                                                width: width * 0.2,
                                                height: height * 0.03,
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                controller
                                                    .fuelSubCategoryData[index]
                                                    .sub1CategoryName
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
            )),
      ),
    );
  }
}
