import 'package:get/get.dart';

import '../Controller/FoodSummaryController.dart';

class FoodSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodSummaryController>(() => FoodSummaryController());
  }
}
