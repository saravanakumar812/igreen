import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../Utils/image_picker.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/ParticularTaskResponse.dart';
import '../provider/menuProvider.dart';

class UpdateSiteThreeController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  bool isCall = false;
  RxBool isLoading = RxBool(false);
  RxList<ParticularData> taskData = RxList();
  RxInt taskIdValue = RxInt(0);
  RxBool isFileSelected = RxBool(false);
  File? file;
  Rx<PickedImage?> item_image = Rx<PickedImage?>(null);
  RxBool isImageSelected = false.obs;
  Future<void> refreshData() async {
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
    }
  }
  Future<void> pickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }
}
