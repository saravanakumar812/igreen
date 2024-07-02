import 'package:get/get.dart';

import '../Controller/TransportSummaryController.dart';
import '../Controller/TravelSummaryController.dart';

class TransportSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransportSummaryController>(() => TransportSummaryController());
  }
}
