import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Utils/AppPreference.dart';
import '../../api_connect/api_connect.dart';
import '../../model/responseModel/GetOverAllExpenseSummaryResponse.dart';
import '../../provider/menuProvider.dart';

class SummaryScreenController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<GraphData> data = RxList();

  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
  }


  Future<void> getSummaryList() async {

    Map<String, dynamic> payload = {
      'EmployeeId': AppPreference().getEmpId.toString(),
      'projectCode': userDataProvider.projectCode.toString(),
    };

    print("getSummaryList:$payload");
    var response = await _connect.getProjectGraphData(payload);
    if (!response.error! && response.data!.isNotEmpty) {
      data.value  = response.data!;



    } else {
    }
    isLoading.value = true;
    isLoading.value = false;
    isLoading.value = true;
    isLoading.value = false;
  }



}