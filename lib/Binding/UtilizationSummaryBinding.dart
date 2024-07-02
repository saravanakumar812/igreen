import 'package:get/get.dart';

import '../Controller/UtilizationSummaryController.dart';
import '../Controller/WagesSummaryController.dart';

class UtilizationSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UtilizationSummaryController>(() => UtilizationSummaryController());
  }
}
