import 'package:get/get.dart';

import '../Controller/TravelSummaryController.dart';

class TravelSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelSummaryController>(() => TravelSummaryController());
  }
}
