import 'package:get/get.dart';
import '../Controller/OndutySummaryScreenController.dart';


class OnDutySummaryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnDutySummaryScreenController>(() => OnDutySummaryScreenController());
  }
}
