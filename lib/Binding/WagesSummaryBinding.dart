import 'package:get/get.dart';

import '../Controller/WagesSummaryController.dart';

class WagesSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WagesSummaryController>(() => WagesSummaryController());
  }
}
