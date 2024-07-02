// import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../api_connect/api_connect.dart';
import '../../model/responseModel/TechnicalList.dart';
import '../../provider/menuProvider.dart';

class TechnicalPageController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<TechnicalData> technicalData = RxList();
  RxString editButtonText = RxString('Add');
  bool isCall = false;
  RxInt selectId = RxInt(0);
  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getTechnicalTeam();
    }
  }

  Future<void> getTechnicalTeam() async {
    // Map<String, dynamic> payload = {
    //   'projectCode': userDataProvider.projectCode.toString(),
    //   'EmployeeId': AppPreference().getEmpId,
    //
    // };
    isLoading.value = true;
    // print("Payload $payload");
    var response = await _connect.getTechnicalExpenseCall();
    isLoading.value = false;
    if (!response.error!) {
      technicalData.value = response.data!;
      update();
      if (response.data!.isEmpty) {
        //Get.toNamed(AppRoutes.AddSalesTeam.toName);
      } else {}
    } else {
      // Get.toNamed(AppRoutes.AddSalesTeam.toName);
    }
  }
}
