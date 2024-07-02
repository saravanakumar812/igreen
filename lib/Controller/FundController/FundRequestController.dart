import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:igreen_flutter/Utils/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import '../../api_config/ApiUrl.dart';
import '../../api_connect/api_connect.dart';
import '../../model/responseModel/CategoryList.dart';
import '../../model/responseModel/FuelSubCategoryResponse.dart';
import '../../model/responseModel/FundRequestResponsemodel.dart';
import '../../model/responseModel/ProjectCodeListResponse.dart';
import '../../provider/menuProvider.dart';

import '../../routes/app_routes.dart';
import 'package:record/record.dart';

class FundRequestController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  late menuDataProvider userDataProvider;
  RxInt selectedPointsSecond = RxInt(1);
  Rx<PickedImage> itemImagePick = Rx<PickedImage>(PickedImage(
      imagePath: null,
      file: null,
      renderType: RenderImage.platform,
      extension: '',
      base64: ''));
  RxBool startImageSelected = false.obs;
  RxBool pickImageSelected = false.obs;
  RxBool projectListOnClick = false.obs;
  RxString selectProject = RxString("Select Project");
  RxBool isLoading = RxBool(false);
  RxBool uploadLoading = RxBool(false);
  RxBool isOpened = RxBool(true);

  RxList<ProjectListData> projectDataTry = RxList();
  RxList<ProjectListData> filteredProjectData = RxList();

  RxList<CategoryListData> categoryList = RxList();
  RxList<TextEditingController> textEditingControllersListFirstCategory = RxList();
  RxList<TextEditingController> textEditingControllersListSecondCategory = RxList();
  RxList<TextEditingController> textEditingControllersListComments = RxList();
  RxList<TextEditingController> textEditingControllersListAmount = RxList();
  RxList<String> categoryListName = RxList();
  RxList<List<FuelSubOneData>> fuelSubCategoryData = RxList();

  List<RequestList> requestList = [];
  RxList<bool> firstCategoryBoolList = RxList();
  RxList<bool> secondCategoryBoolList = RxList();
  int amountAdd = 0;
  int selectSubCategoryNumber = 0;
  bool isComplete = false;
  int i = 0;
  RxString? recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  RxBool isAudio = RxBool(false);
  late Map<String, dynamic> checkDataMap = {};
  RxBool isChecked = RxBool(false);
  RxBool isPointsSecond = RxBool(false);
  RxBool popUpValue = RxBool(false);
  RxBool selectPerson = RxBool(false);
  final FocusNode amountFocusNode = FocusNode();
  List<String> rendDetails = [];
  bool isCall = false;
  TextEditingController amountController = TextEditingController();
  TextEditingController fundController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController testingController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController projectCode = TextEditingController();
  TextEditingController pointsControllerSecond = TextEditingController();
  late Record record;
  bool _isRecording = false;
  String _afterRecordingFilePath = '';
  ScrollController scrollController = ScrollController();
  bool get isRecording => _isRecording;
  String get recordedFilePath => _afterRecordingFilePath;
  late AudioPlayer _justAudioPlayer;
  double _currAudioPlaying = 0.0;
  bool _isSongPlaying = false;
  String _audioFilePath = '';
  bool get isSongPlaying => _isSongPlaying;
  String get currSongPath => _audioFilePath;

  @override
  void onInit() async {
    super.onInit();
    RequestList request = RequestList();
    request.amount = 0;
    request.comments = "";
    request.options = "";
    request.Category = "";

    requestList.add(request);

    firstCategoryBoolList.add(false);
    secondCategoryBoolList.add(false);
    textEditingControllersListSecondCategory.add(TextEditingController());
    textEditingControllersListFirstCategory.add(TextEditingController());
    textEditingControllersListComments.add(TextEditingController());
    textEditingControllersListAmount.add(TextEditingController());
    audioPlayer = AudioPlayer();
    _justAudioPlayer = AudioPlayer();
    record = Record();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);

    userDataProvider.recordedFilePath.isEmpty;
    if (!isCall) {
      isCall = true;
      getProjectList();
      getCategoryList();
    }
  }

  subCategoryFuel(String subcategory1Name) async {
    Map<String, dynamic> payload = {
      'ExpenseCategoryId': subcategory1Name,
    };
    print("1234566$payload");

    isLoading.value = true;
    var response = await _connect.fuelSubCategory(payload);
    debugPrint("subCateory: ${response.toJson()}");

    if (!response.error!) {
      if (fuelSubCategoryData.isEmpty || fuelSubCategoryData.length <= selectSubCategoryNumber) {
        fuelSubCategoryData.add(response.data!);
        print("ENTERIF");
      } else {
        fuelSubCategoryData[selectSubCategoryNumber] = response.data!;
        print("ENTERELSE");
      }
    }

    isLoading.value = false;

  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      if (query.length < 2) {
        return;
      }

      filteredProjectData.clear();

      String lowercaseQuery = query.toLowerCase();
      print("Counts${projectDataTry.length}");

      for (int i = 0; i < projectDataTry.length; i++) {
        String lowercaseValue = projectDataTry[i].projectCode!.toLowerCase();
        if (lowercaseValue.contains(lowercaseQuery)) {
          filteredProjectData.add(projectDataTry[i]);
        }
        print(projectDataTry[i].projectCode!);
      }


    } else {
      print("else");
      filteredProjectData.addAll(projectDataTry);
    }

    isLoading.value = true;
    isLoading.value = false;

  }

  void toggleCheckbox(bool newValue) {
    isChecked.value = newValue;
  }

  Future<bool> checkPermission() async {
    Map<Permission, PermissionStatus> permissions =
        await [Permission.storage, Permission.microphone].request();
    print(permissions[Permission.microphone]);
    return permissions[Permission.microphone] == PermissionStatus.granted;
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/test_${i++}.mp3";
  }

  void startRecord() async {
    audioPlayer = AudioPlayer();

    bool hasPermission = await checkPermission();
    if (hasPermission) {
      if (recordFilePath != null && File(recordFilePath!.value).existsSync()) {
        File(recordFilePath!.value).deleteSync();
        print("record1$recordFilePath");
      }

      if (userDataProvider.currentStatus == "Edit" ||
          userDataProvider.currentStatus == "Re-Use") {
        if (recordFilePath != null &&
            File(recordFilePath!.value).existsSync()) {
          File(recordFilePath!.value).deleteSync();
        }
      }

      recordFilePath!.value = await getFilePath();
      print("record2$recordFilePath");
      isComplete = false;
      RecordMp3.instance.start(recordFilePath!.value, (type) {});
      isAudio.value = false;
      isAudio.value = true;
    } else {}
  }

  void deleteOldData() async {
    File(recordFilePath!.value).deleteSync();
    print("delete1$recordFilePath");
    recordFilePath!.value = "";
    print("delete2$recordFilePath");
    isComplete = false;
    isAudio.value = false;
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      isComplete = true;
    }
  }

  void play() {
    if (recordFilePath!.isEmpty) return;
    if (recordFilePath != null && File(recordFilePath!.value).existsSync()) {
      audioPlayer.setFilePath(recordFilePath!.value);
      audioPlayer.play();
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {}
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {}
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {}
    }
  }

  getProjectList() async {
    isLoading.value = true;
    var response = await _connect.getProjectListCall();
    if (response.data != null) {
      for(var responseData in response.data!){
        projectDataTry.add(responseData);
        filteredProjectData.add(responseData);
      }
      debugPrint("getProjectList45556: ${response.toJson()}");
    } else {}

    isLoading.value = false;

  }

  getCategoryList() async {
    isLoading.value = true;
    var response = await _connect.getCategoryListCall();
    isLoading.value = false;
    if (response.data != null) {
      categoryList.value = response.data!;

      debugPrint("getProjectList4555: ${response.toJson()}");
    } else {}
  }

  bool firstValidation() {
    if (selectProject.value == "Select Project") {
      Fluttertoast.showToast(
        msg: "Please Select Project!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }

    if (messageController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Message!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    if (amountController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Amount!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> insertFundRequest() async {


    for(var response in  requestList){


      if(response.Category!.isEmpty || response.options!.isEmpty || response.amount! == 0 ){

        Fluttertoast.showToast(
          msg: " Please Enter Main category, Sub Category, Amount in expense list ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return;

      }


    }




    if (firstValidation()) {
      Map<String, String> payload = {
        'EmployeeId': AppPreference().getEmpId.toString(),
        'projectCode': selectProject.value,
        'requestTo': '1',
        'amount': amountController.text,
        'message': messageController.text,
        'RequestList': json.encode(requestList)
      };
      print(json.encode(requestList));
      print('insertFundRequest:$payload');

      uploadLoading.value = true;
      var response = await _connect.imgTaskUpload(ApiUrl.fundRequest,
          itemImagePick.value.file, payload, recordFilePath!.value ?? "");
      uploadLoading.value = false;

      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Get.offNamed(AppRoutes.createdFundRequest.toName);
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
}
