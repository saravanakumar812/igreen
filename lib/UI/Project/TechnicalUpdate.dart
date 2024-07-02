import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/Controller/TechnicalUpdateController.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import '../../model/responseModel/ItemList.dart';

class TechnicalUpdate extends GetView<TechnicalUpdateController> {
  const TechnicalUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TechnicalUpdateController controller = Get.put(TechnicalUpdateController());

    return SafeArea(
        child: Scaffold(
            backgroundColor: AppTheme.appColor,
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
                const SizedBox(
                  width: 70,
                ),
                const Text(
                  "Technical Update ",
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

      body: KeyboardActions(
        config: _buildKeyboardActionsConfig(context),
        child: SingleChildScrollView(
          child:Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "DEMAND",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      TextInput(
                        height: 100,
                        label: "Item Code ",
                        onPressed: () {
                          controller.itemListCodeStatic.value= !controller.itemListCodeStatic.value;
                        },
                        controller: controller.itemCodeController,
                        textInputType: TextInputType.text,
                        textColor: Color(0xCC252525),
                        hintText: "Enter Item Code ",
                        obscureText: true,
                        isReadOnly: true,
                        onTextChange: (text) {
                        },
                      ),
                      Obx(() => Visibility(
                        visible: controller.itemListCodeStatic.value,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                            padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.inputBorderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white, // Set the desired background color
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                children: List.generate(
                                  controller.itemDetails.length,
                                      (subIndex) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller.itemCodeController.text =
                                              controller.itemDetails[subIndex]
                                                  .itemCode!;
                                              controller.itemListCodeStatic.value = false;

                                            },
                                            margin: false,
                                            isSelected:
                                            controller.itemCodeController.text  ==
                                                controller.itemDetails[subIndex]
                                                    .itemCode,
                                            label: "",
                                            isEntryField: false,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC234345),
                                            hintText: controller
                                                .itemDetails[subIndex].itemCode,
                                            onTextChange: (String) {},
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Visibility(
                                            visible: controller.itemDetails.length !=
                                                subIndex + 1,
                                            child: Container(
                                              height: 1,
                                              color: AppTheme.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),

                      TextInput(
                        height: 100,
                        label: "Item Name ",
                        onPressed: () {
                          controller.itemListNameStatic.value= !controller.itemListNameStatic.value;
                        },
                        controller: controller.itemNameController,
                        textInputType: TextInputType.text,
                        textColor: Color(0xCC252525),
                        hintText: "Enter Item Name ",
                        obscureText: true,
                        isReadOnly: true,
                        onTextChange: (text) {
                        },
                      ),
                      Obx(() => Visibility(
                        visible: controller.itemListNameStatic.value,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                            padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.inputBorderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white, // Set the desired background color
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                children: List.generate(
                                  controller.itemDetails.length,
                                      (subIndex) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller.itemNameController.text =
                                              controller.itemDetails[subIndex]
                                                  .itemName!;
                                              controller.itemListNameStatic.value = false;

                                            },
                                            margin: false,
                                            isSelected:
                                            controller.itemNameController.text  ==
                                                controller.itemDetails[subIndex]
                                                    .itemName,
                                            label: "",
                                            isEntryField: false,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC234345),
                                            hintText: controller
                                                .itemDetails[subIndex].itemName,
                                            onTextChange: (String) {},
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Visibility(
                                            visible: controller.itemDetails.length !=
                                                subIndex + 1,
                                            child: Container(
                                              height: 1,
                                              color: AppTheme.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                      TextInput(
                        height: 100,
                        label: "Item Description ",
                        onPressed: () {
                          controller.itemListStatic.value = !controller.itemListStatic.value;
                        },
                       controller: controller.itemsControllerStatic,
                        textInputType: TextInputType.text,
                        textColor: Color(0xCC252525),
                        hintText: "Enter Item Description ",
                        obscureText: true,
                        isReadOnly: true,
                        onTextChange: (text) {
                        },
                      ),
                      Obx(() => Visibility(
                        visible: controller.itemListStatic.value,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                            padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.inputBorderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white, // Set the desired background color
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                children: List.generate(
                                  controller.itemDetails.length,
                                      (index) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller.itemsControllerStatic.text =
                                              controller.itemDetails[index]
                                                  .itemDescription!;


                                              controller.itemListStatic.value = false;
                                            },
                                            margin: false,
                                            isSelected:
                                            controller.itemsControllerStatic.text  ==
                                                controller.itemDetails[index]
                                                    .itemDescription,
                                            label: "",
                                            isEntryField: false,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC234345),
                                            hintText: controller
                                                .itemDetails[index].itemDescription,
                                            onTextChange: (String) {},
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Visibility(
                                            visible: controller.itemDetails.length !=
                                                index + 1,
                                            child: Container(
                                              height: 1,
                                              color: AppTheme.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                      TextInput(
                        height: 100,
                        label: "Size ",
                        onPressed: () {
                          controller.sizeListStatic.value = !controller.sizeListStatic.value;
                        },
                        controller: controller.sizeControllerStatic,
                        textInputType: TextInputType.text,
                        textColor: Color(0xCC252525),
                        hintText: "Enter size ",
                        obscureText: true,
                        isReadOnly: true,
                        onTextChange: (text) {

                        },
                      ),
                      Obx(() => Visibility(
                        visible: controller.sizeListStatic.value,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                            padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.inputBorderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white, // Set the desired background color
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                children: List.generate(
                                  controller.sizeDetails.length,
                                      (index) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          TextInput(
                                            onPressed: () {
                                              controller.sizeControllerStatic.text =
                                              controller.sizeDetails[index].size!;
                                              controller.sizeListStatic.value = false;
                                             // controller.sizeDetails.clear();

                                              //controller.typeController.text = "";
                                            },
                                            margin: false,
                                            isSelected:
                                            controller.sizeControllerStatic.text ==
                                                controller.sizeDetails[index]!.size,
                                            label: "",
                                            isEntryField: false,
                                            textInputType: TextInputType.text,
                                            textColor: Color(0xCC234345),
                                            hintText:
                                            controller.sizeDetails[index].size,
                                            onTextChange: (String) {},
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Visibility(
                                            visible: controller.sizeDetails.length !=
                                                index + 1,
                                            child: Container(
                                              height: 1,
                                              color: AppTheme.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                      TextInput(
                        height: 100,
                        label: "Quantity",
                        onPressed: () {},
                        controller: controller.quantityController,
                        textInputType: TextInputType.number,
                        textColor: Color(0xCC252525),
                        hintText: "Enter Quantity",
                          focusNode: controller.quantityFocusNode ,
                        onTextChange: (text) {
                         // controller.itemsList[index].quantity = text;
                        },
                      ),
                      TextInput(
                        height: 100,
                        label: "Set Quantity",
                        onPressed: () {},
                        controller: controller.setQuantityController,
                        textInputType: TextInputType.number,
                        textColor: Color(0xCC252525),
                        hintText: "Enter Set Quantity",
                        focusNode: controller.setQuantityFocusNode,
                        onTextChange: (text) {
                         // controller.itemsList[index].quantity = text;
                        },
                      ),
                      TextInput(
                        height: 100,
                        label: "Item Value",
                        onPressed: () {},
                        controller: controller.itemValueController,
                        textInputType: TextInputType.number,
                        textColor: Color(0xCC252525),
                        focusNode: controller.itemValueFocusNode,
                        hintText: "Enter Item Value",
                        onTextChange: (text) {
                          //controller.itemsList[index].itemValue = text;
                        },
                      ),
                      TextInput(
                        height: 100,
                        label: "Raw Material Grade",
                        onPressed: () {},
                        controller: controller.rawMaterialController,
                        textInputType: TextInputType.text,
                        textColor: Color(0xCC252525),
                        hintText: "Enter Raw Material Grade",
                        onTextChange: (text) {
                          //controller.itemsList[index].rawMaterialGrade = text;
                        },
                      ),

                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      ItemList items = ItemList();
                      items.quantity = '';
                      items.rawMaterialGrade = '';
                      items.size = '';
                      items.itemName = '';
                      items.itemValue = '';
                      items.setQuantity ="";controller.itemsList.add(items);
                      controller.itemListResponse.add(false);
                      controller.itemListCodeResponse.add(false);
                      controller.itemListNameResponse.add(false);
                      controller.sizeList.add(false);

                    },
                    child: Container(
                      width: 50,
                      height: 45,
                      margin: EdgeInsets.only(top: 5, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),

              Obx(
                () => Container(
                       // height: height,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Container(
                               // height: MediaQuery.of(context).size.height * 0.7,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.itemsList.length,
                                  itemBuilder: (context, index) {
                                    return technicalUpdateList(context, index);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),

              Center(
                child: Container(
                 // margin: EdgeInsets.only(right: width * 0.22),
                  width: (width / 2) - 10,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppTheme.secondaryColor),
                  child: GestureDetector(
                    onTap: () {
                      controller.updateTechnicalToCommercial();
                    },
                    child: Center(
                      child: Container(
                        child: Text(
                          "SAVE",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),



    ));
  }
  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey,
      actions: [
        KeyboardActionsItem(
          focusNode: controller.quantityFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.setQuantityFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: controller.itemValueFocusNode,
        ),

      ],
    );
  }
}

Widget technicalUpdateList(BuildContext context, int index) {
  TechnicalUpdateController controller = Get.put(TechnicalUpdateController());
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Column(
    children: [
      SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            children: [
              Text(
                "DEMAND",
                style: GoogleFonts.poppins(
                    color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
              ),
              TextInput(
                height: 100,
                label: "Item Code ",
                onPressed: () {
                  controller.itemListCodeResponse[index] = !controller.itemListCodeResponse[index];
                },
                controller: controller.itemsCodeController[index],
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Item Code ",
                obscureText: true,
                isReadOnly: true,
                onTextChange: (text) {
                },
              ),
              Obx(() => Visibility(
                    visible: controller.itemListCodeResponse[index],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                        padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white, // Set the desired background color
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: List.generate(
                              controller.itemDetails.length,
                              (subIndex) {
                                return Container(
                                  child: Column(
                                    children: [
                                      TextInput(
                                        onPressed: () {
                                          controller.itemsCodeController[index].text =
                                              controller.itemDetails[subIndex]
                                                  .itemCode!;

                                          controller.itemsList[index].itemCode =  controller.itemDetails[subIndex]
                                              .itemCode!;
                                          controller.itemListCodeResponse[index] = false;
                                        },
                                        margin: false,
                                        isSelected:
                                        controller.itemsCodeController[index].text  ==
                                                controller.itemDetails[subIndex]
                                                    .itemCode,
                                        label: "",
                                        isEntryField: false,
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC234345),
                                        hintText: controller
                                            .itemDetails[subIndex].itemCode,
                                        onTextChange: (String) {},
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Visibility(
                                        visible: controller.itemDetails.length !=
                                            subIndex + 1,
                                        child: Container(
                                          height: 1,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),

              TextInput(
                height: 100,
                label: "Item Name ",
                onPressed: () {
                  controller.itemListNameResponse[index] = !controller.itemListNameResponse[index];
                },
                controller: controller.itemsNameController[index],
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Item Name ",
                obscureText: true,
                isReadOnly: true,
                onTextChange: (text) {
                },
              ),
              Obx(() => Visibility(
                    visible: controller.itemListNameResponse[index],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                        padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white, // Set the desired background color
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: List.generate(
                              controller.itemDetails.length,
                              (subIndex) {
                                return Container(
                                  child: Column(
                                    children: [
                                      TextInput(
                                        onPressed: () {
                                          controller.itemsNameController[index].text =
                                              controller.itemDetails[subIndex]
                                                  .itemName!;

                                          controller.itemsList[index].itemName =  controller.itemDetails[subIndex]
                                              .itemName!;
                                          controller.itemListNameResponse[index] = false;
                                        },
                                        margin: false,
                                        isSelected:
                                        controller.itemsNameController[index].text  ==
                                                controller.itemDetails[subIndex]
                                                    .itemName,
                                        label: "",
                                        isEntryField: false,
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC234345),
                                        hintText: controller
                                            .itemDetails[subIndex].itemName,
                                        onTextChange: (String) {},
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Visibility(
                                        visible: controller.itemDetails.length !=
                                            subIndex + 1,
                                        child: Container(
                                          height: 1,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),


              TextInput(
                height: 100,
                label: "Items ",
                onPressed: () {
                  controller.itemListResponse[index] = !controller.itemListResponse[index];
                },
                controller: controller.itemsController[index],
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Items ",
                obscureText: true,
                isReadOnly: true,
                onTextChange: (text) {
                },
              ),
              Obx(() => Visibility(
                    visible: controller.itemListResponse[index],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                        padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white, // Set the desired background color
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: List.generate(
                              controller.itemDetails.length,
                              (subIndex) {
                                return Container(
                                  child: Column(
                                    children: [
                                      TextInput(
                                        onPressed: () {
                                          controller.itemsController[index].text =
                                              controller.itemDetails[subIndex]
                                                  .itemDescription!;

                                          controller.itemsList[index].itemDescription =  controller.itemDetails[subIndex]
                                              .itemDescription!;
                                          controller.itemListResponse[index] = false;
                                        },
                                        margin: false,
                                        isSelected:
                                        controller.itemsController[index].text  ==
                                                controller.itemDetails[subIndex]
                                                    .itemDescription,
                                        label: "",
                                        isEntryField: false,
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC234345),
                                        hintText: controller
                                            .itemDetails[subIndex].itemDescription,
                                        onTextChange: (String) {},
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Visibility(
                                        visible: controller.itemDetails.length !=
                                            subIndex + 1,
                                        child: Container(
                                          height: 1,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              TextInput(
                height: 100,
                label: "Size ",
                onPressed: () {
                  controller.sizeList[index] = !controller.sizeList[index];
                },
                controller: controller.sizeController[index],
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter size ",
                obscureText: true,
                isReadOnly: true,
                onTextChange: (text) {

                },
              ),
              Obx(() => Visibility(
                    visible: controller.sizeList[index],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                        padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white, // Set the desired background color
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: List.generate(
                              controller.sizeDetails.length,
                              (subIndex) {
                                return Container(
                                  child: Column(
                                    children: [
                                      TextInput(
                                        onPressed: () {
                                          controller.sizeController[index].text =
                                              controller.sizeDetails[subIndex].size!;
                                          controller.sizeList[index] = false;

                                          controller.itemsList[index].size =  controller.sizeDetails[subIndex].size!;
                                          //controller.typeController.text = "";
                                        },
                                        margin: false,
                                        isSelected:
                                            controller.sizeController[index].text ==
                                                controller.sizeDetails[subIndex]!.size,
                                        label: "",
                                        isEntryField: false,
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC234345),
                                        hintText:
                                            controller.sizeDetails[subIndex].size,
                                        onTextChange: (String) {},
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Visibility(
                                        visible: controller.sizeDetails.length !=
                                            subIndex + 1,
                                        child: Container(
                                          height: 1,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              TextInput(
                height: 100,
                label: "Quantity",
                onPressed: () {},
                //controller: controller.quantityController,
                textInputType: TextInputType.number,
                focusNode: controller.quantityFocusNode,
                textColor: Color(0xCC252525),
                hintText: "Enter Quantity",
                onTextChange: (text) {
                  controller.itemsList[index].quantity = text;
                },
              ),
              TextInput(
                height: 100,
                label: "Set Quantity",
                onPressed: () {},
                //controller: controller.quantityController,
                textInputType: TextInputType.number,
                focusNode: controller.setQuantityFocusNode,
                textColor: Color(0xCC252525),
                hintText: "Enter Set Quantity",
                onTextChange: (text) {
                  controller.itemsList[index].setQuantity = text;
                },
              ),
              TextInput(
                height: 100,
                label: "Item Value",
                onPressed: () {},
                //controller: controller.itemValueController,
                textInputType: TextInputType.number,
                focusNode: controller.itemValueFocusNode,
                textColor: Color(0xCC252525),
                hintText: "Enter Item Value",
                onTextChange: (text) {
                  controller.itemsList[index].itemValue = text;
                },
              ),
              TextInput(
                height: 100,
                label: "Raw Material Grade",
                onPressed: () {},
                //controller: controller.rawMaterialController,
                textInputType: TextInputType.text,
                textColor: Color(0xCC252525),
                hintText: "Enter Raw Material Grade",
                onTextChange: (text) {
                  controller.itemsList[index].rawMaterialGrade = text;
                },
              ),
            ],
          ),
        ),
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              controller.itemsList.removeAt(index);
            },
            child: Container(
              width: 50,
              height: 45,
              margin: EdgeInsets.only(top: 5, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    ],
  );
}




