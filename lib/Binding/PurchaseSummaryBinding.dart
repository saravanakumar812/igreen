import 'package:get/get.dart';
import '../Controller/PurchaseSummaryController.dart';

class PurchaseSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseSummaryController>(() => PurchaseSummaryController());
  }
}
