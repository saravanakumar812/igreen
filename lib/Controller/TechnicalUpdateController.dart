import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../Utils/AppPreference.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/ItemList.dart';
import '../model/responseModel/ItemListResponse.dart';
import '../model/responseModel/SizeListResponse.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class TechnicalUpdateController extends GetxController {

  RxList<bool> itemListResponse = RxList();
  RxList<bool> itemListCodeResponse = RxList();
  RxList<bool> itemListNameResponse = RxList();
  RxList<bool> sizeList = RxList();

  List<String> rendDetails = [];
  List<String> managerDetailsSelection = [];
  RxBool isLoading = RxBool(false);
  RxBool itemListStatic = RxBool(false);
  RxBool itemListCodeStatic = RxBool(false);
  RxBool itemListNameStatic = RxBool(false);
  RxBool sizeListStatic = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<ItemData> itemDetails = RxList();
  RxList<SizeData> sizeDetails = RxList();
  RxList<ItemList> itemsList = RxList();
  final FocusNode quantityFocusNode = FocusNode();
  final FocusNode setQuantityFocusNode = FocusNode();
  final FocusNode itemValueFocusNode = FocusNode();
  RxInt isAdd = RxInt(1);
  List<String> processDetails = [];
  TextEditingController itemsControllerStatic = TextEditingController();
  TextEditingController sizeControllerStatic = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController setQuantityController = TextEditingController();
  TextEditingController itemValueController = TextEditingController();
  TextEditingController rawMaterialController = TextEditingController();
  TextEditingController orderValueController = TextEditingController();
  TextEditingController itemCodeController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();


  List <TextEditingController> itemsController = [];
  List <TextEditingController> itemsCodeController = [];
  List <TextEditingController> itemsNameController = [];
  List <TextEditingController> sizeController = [];

  final ApiConnect _connect = Get.put(ApiConnect());
  bool isCall = false;
  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);

    if (!isCall) {
      isCall = true;
      getItems();
      getSize();

    }
  }

  Future<void> refreshData() async {
    updateTechnicalToCommercial();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getItems() async {
    Map<String, dynamic> payload = {
      'Id': '',
      'ItemCode': '',
      'ItemDescription': "",
      'ItemName': ''
    };
    print('city132132amepayload:$payload');
    var response = await _connect.getItemsCall(payload);
    debugPrint("getCityTransport: ${response.toJson()}");
    if (!response.error!) {
      itemDetails.value = response.data!;
      for (int i = 0; i < response.data!.length; i++) {
        itemsController.add(TextEditingController());
        itemsCodeController.add(TextEditingController());
        itemsNameController.add(TextEditingController());
      }
    } else {}
  }

  Future<void> getSize() async {
    var response = await _connect.getSizeCall();
    if (!response.error!) {
      sizeDetails.value = response.data!;
      for (int i = 0; i < response.data!.length; i++) {
        sizeController.add(TextEditingController());
      }

    }
  }

  bool firstValidation() {
    if (quantityController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Quantity!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (rawMaterialController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter rawMaterial!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (itemValueController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Item value!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  Future<void> updateTechnicalToCommercial() async {

    ItemList items = ItemList();
    items.itemCode = itemCodeController.text;
    items.setQuantity = setQuantityController.text;
    items.quantity = quantityController.text;
    items.size = sizeControllerStatic.text;
    items.itemDescription = itemsControllerStatic.text;
    items.itemValue = itemValueController.text;
    items.rawMaterialGrade = rawMaterialController.text;
    items.itemName = itemNameController.text;
    itemsList.add(items);
   itemListResponse.add(false);
   itemListCodeResponse.add(false);
   itemListNameResponse.add(false);

   sizeList.add(false);
    //itemsList.clear();
    print(json.encode(itemsList));
    if (firstValidation()) {
      Map<String, dynamic> payload = {
        'itemsList': json.encode(itemsList),
        'ProjectId': userDataProvider.getTechnicalDataData!.projectId.toString(),
      };
      print(json.encode(payload));

      print("updateTechnicalToCommercialFirst:$payload");
      var response = await _connect.updateTechnicalToCommercialCall(payload);
      debugPrint("updateTechnicalToCommercial: ${response.toJson()}");
      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.technicalScreen.toName);
        Get.deleteAll();
      } else {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.red,
        );
      }
    }
  }
}
