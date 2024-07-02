import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:provider/provider.dart';

import '../../../api_connect/api_connect.dart';
import '../../../provider/menuProvider.dart';
import '../../../routes/app_routes.dart';

import '../../model/responseModel/TravelSummaryList.dart';
import '../Components/Key.dart';
import '../model/GetSupportResponseModel.dart';
import '../model/IdealogyResponseModel.dart';
import '../model/IdeasUserDataResponse.dart';
import '../model/responseModel/FoodSummaryList.dart';

class GetSupportScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);

  late menuDataProvider userDataProvider;
  RxList<IdeaLogyUserResponseData> ideologyUserData = RxList();
  RxList<GetSupportResponseData> getSupportData = RxList();
  RxString editButtonText = RxString('Edit');
  RxString reuseButtonText = RxString('Re-Use');
  bool isCall = false;
  RxInt selectedValues = RxInt(0);
  RxInt deleteIdeas = RxInt(0);
  RxInt selectId = RxInt(0);
  RxInt selectedTabIndex = 0.obs;
  RxInt currentIndex = RxInt(0);
  RxBool isFABVisible = RxBool(false);
  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getSupport();
      //getUserIdeaLogy();
    }
  }

  Future<void> refreshData() async {
    getSupport();
    // getUserIdeaLogy();
    return Future.delayed(Duration(seconds: 0));
  }
  Future<void> refreshDeleteData() async {
    // getIdeaLogy();
    getUserIdeaLogy();
    return Future.delayed(Duration(seconds: 0));
  }
  List<Keyvalues> listValues = [
    Keyvalues(key: "0", value: "User"),
    Keyvalues(key: "1", value: "Employee"),
  ];

  updateCurrentTabIndex(int index) {
    print("INDEX$index");
    selectedTabIndex.value = index;
    listValues[selectedTabIndex.value].key;
    update();
  }

  Future<void> getSupport() async {
    isLoading.value = true;
    var response = await _connect.getSupportCall();
    isLoading.value = false;
    if (!response.error!) {
      getSupportData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        //Get.toNamed(AppRoutes.foodEntryScreen.toName);
      } else {}
    } else {
      //Get.toNamed(AppRoutes.foodEntryScreen.toName);
    }
  }

  Future<void> getUserIdeaLogy() async {
    isLoading.value = true;
    Map<String, dynamic> payload = {
      'employeeName' :  AppPreference().getEmpName
    };
    var response = await _connect.getUserIdeaLogyCall(payload);
    isLoading.value = false;
    if (!response.error!) {
      ideologyUserData.value = response.data!;
      //update();
      if (response.data!.isEmpty) {
        // Get.toNamed(AppRoutes.foodEntryScreen.toName);
      } else {}
    } else {
      // Get.toNamed(AppRoutes.foodEntryScreen.toName);
    }
  }



  Future<void> deleteIdea() async {
    Map<String, dynamic> payload = {
      'id': ideologyUserData[deleteIdeas.value].ideasId,
    };
    print("DeleteUpdate:$payload");
    var response = await _connect.deleteIdeasCall(payload);
    debugPrint("statusUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      getUserIdeaLogy();
    } else {}
    ;
  }

  Future<void> addAgreeIdeas() async {

    Map<String, dynamic> payload = {
      'ideasId':userDataProvider.getIdeaLogyUser!.ideasId.toString() ,
      'agree': userDataProvider.currentStatus == "Agree" ? "Agree" : "DisAgree",
      'employeeName':  AppPreference().getEmpName,

    };
    print("AddIdeaPayload:$payload");
    var response = await _connect.addAgreeCall(payload);
    debugPrint("AddIdeaResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.ideaLogySummary.toName);
      Get.deleteAll();
    } else
          () {};
  }

  Future<void> updateIdeaLogy() async {
    Map<String, dynamic> payload = {
      'ideasId': userDataProvider.getIdeaLogyUser!.ideasId.toString(),
      'ideas': "",
      'agreeCount': userDataProvider.currentStatus == "Agree" ? "Agree" : "DisAgree",
      'employeeName':  "",

    };

    print('IdeaLogyUpdateRequest$payload');
    var response = await _connect.updateAgreeCall(  payload );
    debugPrint("IdeaLogyUpdateResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.ideaLogySummary.toName);
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
    ;
  }
}
