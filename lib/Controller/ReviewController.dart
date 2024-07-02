import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../api_connect/api_connect.dart';
import '../model/LoginResponseModel.dart';
import '../model/responseModel/WailtingForApprovalReviewResponseModel.dart';
import '../provider/menuProvider.dart';

class ReviewController extends GetxController {
  RxString editButtonText = RxString('Reject');
  RxString reuseButtonText = RxString('Approve');
  late menuDataProvider userDataProvider;
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  RxList<ReviewApprovalData> reviewData = RxList();

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    getReviewWaitingForApproval();
  }

  Future<void> getReviewWaitingForApproval() async {
    var response = await _connect.getReviewWaitingForApproval();
    if (!response.error!) {
      reviewData.value = response.data!;
      update();
    }
  }

  Future<void> refreshData() async {
    getReviewWaitingForApproval();
    return Future.delayed(Duration(seconds: 0));
  }
}
