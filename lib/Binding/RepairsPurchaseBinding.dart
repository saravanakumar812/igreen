import 'package:get/get.dart';
import '../Controller/RepairPurchaseController.dart';
import '../Controller/RepairsAndMaintenanceSummaryController.dart';

class RepairsPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepairPurchaseEntryController>(
            () => RepairPurchaseEntryController());
  }
}
