import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:igreen_flutter/Utils/AppPreference.dart';
import 'package:provider/provider.dart';

import '../../api_connect/api_connect.dart';
import '../../model/responseModel/SalesTeamList.dart';
import '../../provider/menuProvider.dart';
import '../../routes/app_routes.dart';

class SalesTeamOneController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<SalesTeamData> salesTeamData = RxList();
  RxString editButtonText = RxString('Edit');
  RxString reuseButtonText = RxString('Re-Use');
  bool isCall = false;

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getSalesTeam();
    }
  }

  Future<void> getSalesTeam() async {
    Map<String, dynamic> payload = {
      'projectCode': userDataProvider.projectCode.toString(),
      'EmployeeId': AppPreference().getEmpId,
    };
    isLoading.value = true;
    print("Payload $payload");
    var response = await _connect.getSalesTeamExpenseCall();
    isLoading.value = false;
    if (!response.error!) {
      salesTeamData.value = response.salesData!;
      update();
      if (response.salesData!.isEmpty) {
        Get.toNamed(AppRoutes.addSalesTeam.toName);
      } else {}
    } else {
      Get.toNamed(AppRoutes.addSalesTeam.toName);
    }
  }
}
