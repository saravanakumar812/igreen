import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../../api_connect/api_connect.dart';
import '../../model/responseModel/CommercialFromTechnicalDataResponse.dart';
import '../../provider/menuProvider.dart';

class GetCommercialFromTechnicalController extends GetxController {
  RxList<CommercialFromTechnicalData> listData = RxList();
  RxList<FactoryProjectsItems> projectItems = RxList();
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
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
    }
  }

  // Future<void> getCommercialFromTechnical() async {
  //   var response = await _connect.commercialFromTechnicalList();
  //   isLoading.value = false;
  //   if (!response.error!) {
  //     listData.value = response.data!;
  //     update();
  //     if (response.data!.isEmpty) {}
  //   }
  // }
}
