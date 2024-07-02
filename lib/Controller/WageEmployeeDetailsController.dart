import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../Utils/image_picker.dart';
import '../api_config/ApiUrl.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/WagesSummarylist.dart';
import '../provider/menuProvider.dart';
import '../routes/app_routes.dart';

class WageEmployeeDetailsController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxString editButtonText = RxString('Edit');
  RxString reuseButtonText = RxString('Re-Use');
  TextEditingController amountController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  // Rx<PickedImage?> itemImagePickEmp = Rx<PickedImage?>(null);
  RxString imagePathFromData = RxString("");
  RxBool isUpdateImageAvailable = false.obs;
  Rx<PickedImage> itemImagePickEmp = Rx<PickedImage>(PickedImage(
      imagePath: null,
      file: null,
      renderType: RenderImage.platform,
      extension: '',
      base64: ''));
  RxBool pickImageSelectedEmp = false.obs;
  bool isCall = false;

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      setData();
    }
  }

  Future<void> empUpdate() async {
    Map<String, dynamic> payload = {
      'Id': userDataProvider.getWagesData!.wagesEmployee![1].wagesEmployeeId
          .toString(),
      'EmployeeName': employeeNameController.text,
      'Amount': amountController.text,
      'FingerPrint': '',
      'Photo': '',
      'ContactNumber': contactNumberController.text,
    };
    print('empUpdate:$payload');
    var response = await _connect.empUpdateCall(payload);
    debugPrint("empUpdateResponse: ${response.toJson()}");

    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offNamed(AppRoutes.wagesSummaryScreen.toName);
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

  void setData() {
    WagesEmployee data = userDataProvider.getWagesEmployee!;
    employeeNameController.text = data.employeeName!.toString() ?? '';
    amountController.text = data.amount.toString() ?? '';
    contactNumberController.text = data.contactNumber.toString() ?? '';

    if (userDataProvider.getCurrentStatus == "Edit") {
      if (data.photo != null && data.photo!.isNotEmpty) {
        imagePathFromData.value = "${ApiUrl.baseUrl}expense/${data.photo!}";
        isUpdateImageAvailable.value = true;
      }
    }

  }
}
