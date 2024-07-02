import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igreen_flutter/model/responseModel/FundRequestResponsemodel.dart';
import 'package:igreen_flutter/provider/menuProvider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../../Components/forms.dart';
import '../../Controller/FundController/FundRequestController.dart';
import '../../Controller/MaintenanceController.dart';
import '../../Utils/image_picker.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import 'package:rxdart/rxdart.dart' as rx;

import '../../model/responseModel/CategoryList.dart';

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class FundRequest extends GetView<FundRequestController> {
  const FundRequest({super.key});

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          controller.audioPlayer.positionStream,
          controller.audioPlayer.bufferedPositionStream,
          controller.audioPlayer.durationStream,
          (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration!));

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<menuDataProvider>(context);
    final playProvider = Provider.of<menuDataProvider>(context);
    final playProviderWithoutListen =
        Provider.of<menuDataProvider>(context, listen: false);
    final recordProviderWithoutListener =
        Provider.of<menuDataProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    FundRequestController controller = Get.put(FundRequestController());

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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    "Fund Request",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
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
        body: KeyboardActions(
          config: _buildKeyboardActionsConfig(context),
          child: SingleChildScrollView(
            //physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                TextInput(
                    label: "Project",
                    onPressed: () {
                      controller.projectListOnClick.value =
                          !controller.projectListOnClick.value;
                    },
                    controller: controller.projectCode,
                    onTextChange: (text) {
                      controller.projectListOnClick.value = true;
                      controller.filterSearchResults(text);
                    },
                    textInputType: TextInputType.text,
                    textColor: Color(0xCC252525),
                    hintText: "Select the Project",
                    obscureText: true),
                Obx(
                  () => Visibility(
                    visible: controller.projectListOnClick.value,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: height * 0.2,
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      padding: EdgeInsets.fromLTRB(6, 4, 0, 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.inputBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white, // Set the desired background color
                      ),
                      child: SingleChildScrollView(
                        child: IntrinsicHeight(
                          child: Column(
                            children: List.generate(
                              controller.filteredProjectData.length,
                              (index) {
                                var model =
                                    controller.filteredProjectData[index];
                                return Container(
                                  child: Column(
                                    children: [
                                      TextInput(
                                        onPressed: () {
                                          controller.selectProject.value =
                                              controller
                                                  .filteredProjectData[index]
                                                  .projectCode
                                                  .toString();
                                          controller.projectCode.text =
                                              controller
                                                  .filteredProjectData[index]
                                                  .projectCode
                                                  .toString();

                                          controller.projectListOnClick.value =
                                              false;
                                          controller.userDataProvider
                                              .setProjectCode(controller
                                                  .filteredProjectData[index]
                                                  .projectCode
                                                  .toString());

                                          print("Project Code: " +
                                              controller
                                                  .filteredProjectData[index]
                                                  .projectCode
                                                  .toString());
                                        },
                                        margin: false,
                                        isSelected:
                                            controller.selectProject.value ==
                                                controller
                                                    .filteredProjectData[index]
                                                    .projectCode
                                                    .toString(),
                                        label: "",
                                        isEntryField: false,
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC234345),
                                        hintText: model.projectCode,
                                        onTextChange: (String) {},
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Visibility(
                                        visible: controller
                                                .filteredProjectData.length !=
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
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: TextField(
                    maxLines: 3,
                    controller: controller.messageController,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.grey),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: 'Enter Your Work Detail',
                      hintStyle: TextStyle(
                        fontSize: 14, // Choose the desired alignment
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextInput(
                  height: 100,
                  label: "Amount",
                  onPressed: () {},
                  controller: controller.amountController,
                  textInputType: TextInputType.number,
                  textColor: Color(0xCC252525),
                  focusNode: controller.amountFocusNode,
                  hintText: "Enter Amount",
                  onTextChange: (string) {},
                  isReadOnly: true,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Obx(() => controller.isOpened.value
                    ? Container(
                        margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IntrinsicHeight(
                          child: SingleChildScrollView(
                            controller: controller.scrollController,
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              children: List.generate(
                                controller.selectedPointsSecond.value,
                                (index) {
                                  if (index == 0) {
                                    controller.amountAdd = 0;
                                  }
                                  controller.amountAdd +=
                                      controller.requestList[index].amount ?? 0;

                                  controller
                                          .textEditingControllersListComments[index]
                                          .text =
                                      controller.requestList[index].comments!;

                                  if( controller.requestList[index].amount! != 0) {
                                    controller
                                        .textEditingControllersListAmount[index]
                                        .text =
                                        controller.requestList[index].amount!
                                            .toString();
                                  }

                                  controller
                                          .textEditingControllersListSecondCategory[
                                              index]
                                          .text =
                                      controller.requestList[index].Category!
                                          .toString();
                                  controller
                                          .textEditingControllersListFirstCategory[
                                              index]
                                          .text =
                                      controller.requestList[index].options!
                                          .toString();

                                  return Column(
                                    children: [

                                      if(index != 0)
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller.amountAdd -=
                                                    controller.requestList[index].amount ?? 0;

                                                controller.selectedPointsSecond.value--;
                                                controller.requestList.removeAt(index);
                                                controller.firstCategoryBoolList.removeAt(index);
                                                controller.secondCategoryBoolList.removeAt(index);
                                                controller.textEditingControllersListSecondCategory[index].text  = "";
                                                controller.textEditingControllersListSecondCategory.removeAt(index);
                                                controller.textEditingControllersListFirstCategory[index].text  = "";
                                                controller.textEditingControllersListFirstCategory.removeAt(index);
                                                controller.textEditingControllersListComments[index].text  = "";
                                                controller.textEditingControllersListComments.removeAt(index);
                                                controller.textEditingControllersListAmount[index].text  = "";
                                                controller.textEditingControllersListAmount.removeAt(index);
                                                controller.fuelSubCategoryData.removeAt(index);
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) async {
                                                  controller.amountController.text =
                                                      controller.amountAdd.toString();
                                                });
                                              },
                                              child: Image.asset(
                                                "assets/images/closed.png",
                                                fit: BoxFit.fitWidth,
                                                width: 25,
                                                height: 25,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                      TextInput(
                                        controller: controller
                                                .textEditingControllersListFirstCategory[
                                            index],
                                        height: 100,
                                        onPressed: () {
                                          controller
                                                  .firstCategoryBoolList[index] =
                                              !controller
                                                  .firstCategoryBoolList[index];
                                        },
                                        margin: true,
                                        isReadOnly: true,
                                        label: "",
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Select the first Categroy",
                                        obscureText: true,
                                        onTextChange: (String) {},
                                      ),
                                      Obx(() => Visibility(
                                            visible:
                                                controller.firstCategoryBoolList[
                                                        index] &&
                                                    controller
                                                        .categoryList.isNotEmpty,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      AppTheme.inputBorderColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: AppTheme.primaryColor,
                                              ),
                                              child: IntrinsicHeight(
                                                child: Column(
                                                  children: List.generate(
                                                    controller
                                                        .categoryList!.length,
                                                    (index2) {
                                                      var model = controller
                                                          .categoryList![index2];
                                                      return Container(
                                                        child: Column(
                                                          children: [
                                                            TextInput(
                                                              withImage: true,
                                                              imagePath: model
                                                                  .expenseCategoryImage,
                                                              onPressed: () {
                                                                try {
                                                                  controller
                                                                      .fuelSubCategoryData[
                                                                          index]
                                                                      .clear();
                                                                } catch (e) {}
                                                                controller
                                                                    .textEditingControllersListSecondCategory[
                                                                        index]
                                                                    .text = "";
                                                                controller
                                                                    .requestList[
                                                                        index]
                                                                    .Category = "";
                                                                controller
                                                                        .requestList[
                                                                            index]
                                                                        .options =
                                                                    model
                                                                        .expenseCategoryName!;
                                                                controller
                                                                        .textEditingControllersListFirstCategory[
                                                                            index]
                                                                        .text =
                                                                    model
                                                                        .expenseCategoryName!;
                                                                controller.firstCategoryBoolList[
                                                                        index] =
                                                                    !controller
                                                                            .firstCategoryBoolList[
                                                                        index];
                                                                controller
                                                                        .selectSubCategoryNumber =
                                                                    index;
                                                                controller.subCategoryFuel(model
                                                                    .expenseCategoryId!
                                                                    .toString());
                                                                controller
                                                                        .isOpened
                                                                        .value =
                                                                    false;
                                                                controller
                                                                    .isOpened
                                                                    .value = true;
                                                              },
                                                              margin: true,
                                                              isSelected: controller
                                                                      .textEditingControllersListFirstCategory[
                                                                          index]
                                                                      .text ==
                                                                  model
                                                                      .expenseCategoryName!,
                                                              label: "",
                                                              isEntryField: false,
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                              textColor:
                                                                  const Color(
                                                                      0xCC234345),
                                                              hintText: model
                                                                  .expenseCategoryName!,
                                                              obscureText: true,
                                                              onTextChange:
                                                                  (String) {},
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextInput(
                                        controller: controller
                                                .textEditingControllersListSecondCategory[
                                            index],
                                        isReadOnly: true,
                                        height: 100,
                                        onPressed: () {
                                          controller
                                                  .secondCategoryBoolList[index] =
                                              !controller
                                                  .secondCategoryBoolList[index];
                                        },
                                        margin: true,
                                        label: "",
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Select the Second Category",
                                        obscureText: true,
                                        onTextChange: (String) {},
                                      ),
                                      controller.fuelSubCategoryData.isNotEmpty &&
                                          controller
                                              .fuelSubCategoryData.length > index &&
                                              controller
                                                  .fuelSubCategoryData[index]
                                                  .isNotEmpty
                                          ? Obx(() => Visibility(
                                                visible: controller
                                                            .secondCategoryBoolList[
                                                        index] &&
                                                    controller.fuelSubCategoryData
                                                        .isNotEmpty &&
                                                    controller
                                                        .fuelSubCategoryData[
                                                            index]
                                                        .isNotEmpty,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppTheme
                                                          .inputBorderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    color: AppTheme.primaryColor,
                                                  ),
                                                  child: IntrinsicHeight(
                                                    child: Column(
                                                      children: List.generate(
                                                        controller
                                                            .fuelSubCategoryData[
                                                                index]!
                                                            .length,
                                                        (index1) {
                                                          var model = controller
                                                                  .fuelSubCategoryData[
                                                              index][index1];
                                                          return Container(
                                                            child: Column(
                                                              children: [
                                                                TextInput(
                                                                  onPressed: () {
                                                                    controller
                                                                        .requestList[
                                                                            index]
                                                                        .Category = model.sub1CategoryName!;
                                                                    controller
                                                                        .textEditingControllersListSecondCategory[
                                                                            index]
                                                                        .text = model.sub1CategoryName!;
                                                                    controller.secondCategoryBoolList[
                                                                            index] =
                                                                        !controller
                                                                                .secondCategoryBoolList[
                                                                            index];
                                                                    controller
                                                                        .isOpened
                                                                        .value = false;
                                                                    controller
                                                                        .isOpened
                                                                        .value = true;
                                                                  },
                                                                  margin: true,
                                                                  withImage: true,
                                                                  imagePath: model
                                                                      .sub1CategoryImage,
                                                                  isSelected: controller
                                                                          .textEditingControllersListSecondCategory[
                                                                              index]
                                                                          .text ==
                                                                      model
                                                                          .sub1CategoryName!,
                                                                  label: "",
                                                                  isEntryField:
                                                                      false,
                                                                  textInputType:
                                                                      TextInputType
                                                                          .text,
                                                                  textColor:
                                                                      const Color(
                                                                          0xCC234345),
                                                                  hintText: model
                                                                      .sub1CategoryName!,
                                                                  obscureText:
                                                                      true,
                                                                  onTextChange:
                                                                      (String) {},
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          : Container(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextInput(
                                        controller: controller
                                                .textEditingControllersListComments[
                                            index],
                                        height: 100,
                                        label: "Comments",
                                        onPressed: () {},
                                        textInputType: TextInputType.text,
                                        textColor: Color(0xCC252525),
                                        hintText: "Enter Comments",
                                        onTextChange: (string) {
                                          if (string.isNotEmpty) {
                                            controller.requestList[index]
                                                .comments = string;
                                          } else {
                                            controller
                                                .requestList[index].comments = "";
                                          }
                                        },
                                      ),
                                      TextInput(
                                        controller: controller
                                                .textEditingControllersListAmount[
                                            index],
                                        height: 100,
                                        label: "Amount",
                                        onPressed: () {},
                                        textInputType: TextInputType.number,
                                        textColor: Color(0xCC252525),
                                        hintText: "Enter Amount",
                                        onTextChange: (string) {
                                          if (string.isNotEmpty) {
                                            int perviousAmount = controller
                                                    .requestList[index].amount ??
                                                0;

                                            controller.requestList[index].amount =
                                                int.parse(string);
                                            controller.amountAdd -=
                                                perviousAmount;
                                            controller.amountAdd += controller
                                                    .requestList[index].amount ??
                                                0;

                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) async {
                                              controller.amountController.text =
                                                  controller.amountAdd.toString();
                                            });
                                          } else {
                                            int perviousAmount = controller
                                                    .requestList[index].amount ??
                                                0;

                                            controller.requestList[index].amount =
                                                0;

                                            controller.amountAdd -=
                                                perviousAmount;
                                            controller.amountAdd += controller
                                                    .requestList[index].amount ??
                                                0;
                                            controller.amountController.text =
                                                controller.amountAdd.toString();
                                          }
                                        },
                                        isReadOnly: false,
                                      ),

                                      if((controller.selectedPointsSecond.value-1) == index)
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  RequestList request = RequestList();
                                                  request.amount = 0;
                                                  request.comments = "";
                                                  request.options = "";
                                                  request.Category = "";

                                                  controller.requestList.add(request);

                                                  controller.firstCategoryBoolList.add(false);
                                                  controller.secondCategoryBoolList.add(false);
                                                  controller.textEditingControllersListSecondCategory.add(TextEditingController());
                                                  controller.textEditingControllersListFirstCategory.add(TextEditingController());
                                                  controller.textEditingControllersListComments.add(TextEditingController());
                                                  controller.textEditingControllersListAmount.add(TextEditingController());
                                                  controller.selectedPointsSecond.value += 1;
                                                  controller.scrollController.jumpTo(controller.scrollController.position.maxScrollExtent);


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
                                              )
                                            ],
                                          ),
                                        ),

                                      Divider(),

                                      SizedBox(height: 30,)

                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 40, right: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: AppTheme.liteWhite),
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: controller.pickImageSelected.value
                                      ? null
                                      : Border.all(
                                          color: AppTheme.liteWhite, width: 3),
                                ),
                                child: Material(
                                  color: AppTheme.liteWhite,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        ImagePick(
                                          isMultiple: true,
                                          title: "Profile ",
                                          onClose: () => Get.back(),
                                          onSave: (List<PickedImage> images) {
                                            if (images.isNotEmpty) {
                                              controller.itemImagePick.value =
                                                  images[0];
                                              controller.pickImageSelected
                                                  .value = true;
                                              // controller.clearImage();
                                            }
                                            Get.back();
                                          },
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        if (controller.itemImagePick.value !=
                                                null &&
                                            controller.itemImagePick.value
                                                    .imagePath !=
                                                null)
                                          Image.file(
                                            controller.itemImagePick!.value!
                                                .imagePath,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        if (controller.itemImagePick.value ==
                                                null ||
                                            controller.itemImagePick.value
                                                    .imagePath ==
                                                null)
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.image,
                                                  size: 50,
                                                ),
                                                Text(
                                                  "Pick Image",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        // Positioned(
                                        //   bottom: 0,
                                        //   right: 0,
                                        //   child: Container(
                                        //     padding: EdgeInsets.all(8),
                                        //     decoration: BoxDecoration(
                                        //       shape: BoxShape.circle,
                                        //       color: Colors.blue,
                                        //     ),
                                        //     child: Icon(
                                        //       Icons.add,
                                        //       color: Colors.white,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              controller.startRecord();
                              Fluttertoast.showToast(
                                msg: "Record Starting",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                            },
                            onTapUp: (TapUpDetails details) {
                              controller.stopRecord();
                              controller.isAudio.value = true;
                              Fluttertoast.showToast(
                                msg: "Record Stop",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                            },
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: AppTheme.liteWhite),
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    color: AppTheme.liteWhite,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppTheme.liteWhite,
                                          spreadRadius: 0,
                                          blurRadius: 2)
                                    ]),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.mic,
                                      size: 40,
                                    ),
                                    Text(
                                      "Hold",
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
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Visibility(
                      //   //visible: controller.isAudio.value,
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         children: [
                      //           if (recordProvider.recordedFilePath.isNotEmpty &&
                      //               !playProvider.isSongPlaying)
                      //             _resetButton(context),
                      //         ],
                      //       ),
                      //       recordProvider.recordedFilePath.isEmpty
                      //           ? _recordingSection(context)
                      //           : _audioPlayingSection(context),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // recordProvider.recordedFilePath.isEmpty
                      //     ? InkWell(
                      //         onTapUp: (TapUpDetails details) async =>
                      //             await recordProviderWithoutListener
                      //                 .stopRecording(),
                      //         onTapDown: (TapDownDetails details) async =>
                      //             await recordProviderWithoutListener
                      //                 .recordVoice(),
                      //         child: _commonIconSection(context),
                      //       )
                      //     : Container(
                      //         width: MediaQuery.of(context).size.width - 110,
                      //         height: 50,
                      //         padding: const EdgeInsets.symmetric(horizontal: 10),
                      //         margin: const EdgeInsets.only(bottom: 10),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(8),
                      //           color: Colors.white,
                      //         ),
                      //         child: Row(
                      //           children: [
                      //             _audioControllingSection(
                      //                 context, recordProvider.recordedFilePath),
                      //             _audioProgressSection(context),
                      //           ],
                      //         ),
                      //       )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isAudio.value,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: AppTheme.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                      child: GestureDetector(
                                    onTap: () {
                                      controller.deleteOldData();
                                    },
                                    child: Image.asset(
                                      "assets/images/closed.png",
                                      fit: BoxFit.contain,
                                      width: width * 0.3,
                                      height: height * 0.1,
                                    ),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Expanded(
                            child: Row(
                              children: [
                                StreamBuilder<PlayerState>(
                                  stream:
                                      controller.audioPlayer.playerStateStream,
                                  builder: (context, snapshot) {
                                    final playerState = snapshot.data;
                                    final processingState =
                                        playerState?.processingState;
                                    final playing = playerState?.playing;
                            
                                    if (!(playing ?? false)) {
                                      return IconButton(
                                        onPressed: () {
                                          controller.play();
                                        },
                                        icon: Icon(
                                          Icons.play_arrow_rounded,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      );
                                    } else if (processingState !=
                                        ProcessingState.completed) {
                                      return IconButton(
                                        onPressed: controller.audioPlayer.pause,
                                        icon: Icon(
                                          Icons.pause_rounded,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                            
                                    // If processingState is completed, return an empty container
                                    return Icon(Icons
                                        .play_arrow_rounded); // No icon shown
                                  },
                                ),
                                SizedBox(width: 30),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  width: 180,
                                  child: StreamBuilder(
                                    stream: _positionDataStream,
                                    builder: (context, snapshot) {
                                      final positionData = snapshot.data;
                            
                                      return ProgressBar(
                                        progress: positionData?.position ??
                                            Duration.zero,
                                        buffered:
                                            positionData?.bufferedPosition ??
                                                Duration.zero,
                                        total: positionData?.duration ??
                                            Duration.zero,
                                        onSeek: controller.audioPlayer.seek,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: GestureDetector(
                    child: Center(
                      child: Obx(() => Button(
                          widthFactor: 0.9,
                          heightFactor: 0.06,
                          onPressed: () {
                            controller.insertFundRequest();
                          },
                          child: controller.uploadLoading.isTrue
                              ? CircularProgressIndicator()
                              : const Text("Add",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.w600)))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  play(context, String songPath) async {
    final playProviderWithoutListen =
        Provider.of<menuDataProvider>(context, listen: false);
    if (songPath.isEmpty) return;
    await playProviderWithoutListen.playAudio(File(songPath));
  }

  _audioControllingSection(context, String songPath) {
    final _playProvider = Provider.of<menuDataProvider>(context);
    final _playProviderWithoutListen =
        Provider.of<menuDataProvider>(context, listen: false);

    return IconButton(
      onPressed: () async {
        if (songPath.isEmpty) return;
        await _playProviderWithoutListen.playAudio(File(songPath));
      },
      icon: Icon(
          _playProvider.isSongPlaying ? Icons.pause : Icons.play_arrow_rounded),
      color: const Color(0xff4BB543),
      iconSize: 30,
    );
  }

  _resetButton(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final _recordProvider =
        Provider.of<menuDataProvider>(context, listen: false);

    return InkWell(
      onTap: () => _recordProvider.clearOldData(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: AppTheme.white, borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: Image.asset(
              "assets/images/closed.png",
              fit: BoxFit.contain,
              width: width * 0.3,
              height: height * 0.1,
            )),
          ),
        ),
      ),
    );
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey,
      actions: [
        KeyboardActionsItem(
          focusNode: controller.amountFocusNode,
        ),
      ],
    );
  }
}
