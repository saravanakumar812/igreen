import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Controller/SummaryScreenController.dart';
import '../../forms/theme.dart';

class SummaryScreen extends GetView<SummaryScreenController> {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SummaryScreenController controller = Get.put(SummaryScreenController());

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
                    "Summary",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Spacer(),
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                    width: width * 0.2,
                    height: height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Obx(
              () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.getSummaryListData!.isNotEmpty
              ? SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: controller.refreshData,
              child: Column(
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 5, horizontal: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                                () => Text(
                              "Total Expense Amount: ${controller.SumValue.value}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          )
                        ]),
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height - 100,
                    child: ListView.builder(
                      itemCount: controller.getSummaryListData.length,
                      itemBuilder: (context, index) {
                        return summaryList(context, index);
                      },
                    ),
                  ),

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
            if(controller.isLoading.isTrue){
              Fluttertoast.showToast(
                msg: "Uploading... Please wait",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
              );
              return;
            }
            controller.addUpload();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            height: 45,
            decoration: BoxDecoration(
                color: AppTheme.secondaryColor,
                borderRadius: BorderRadius.circular(8)),
            child:   controller.isLoading.isTrue ? CircularProgressIndicator() :   Text("Upload", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppTheme.white),),
          ),
        ),
      ),
    );
  }

  Widget summaryList(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = controller.getSummaryListData[index];
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
                    controller.getSummaryListData[index].mainCategory ?? "",
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Project Name:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      controller.getSummaryListData[index].projectName
                          .toString(),
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Dates:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    controller.getSummaryListData[index].dates.toString(),
                    style: const TextStyle(
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
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Expense Amount:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    controller.getSummaryListData[index].expenseAmount
                        .toString() ??
                        "",
                    style: const TextStyle(
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
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ));
  }

}

