import 'package:get/get.dart';
import '../Controller/RepairsAndMaintenanceSummaryController.dart';

class RepairsAndMaintenanceSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepairsAndMaintenanceSummaryController>(
        () => RepairsAndMaintenanceSummaryController());
  }
}
