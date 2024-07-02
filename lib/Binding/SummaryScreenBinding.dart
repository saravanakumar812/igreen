import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../Controller/SummaryScreenController.dart';

class SummaryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SummaryScreenController>(() => SummaryScreenController());
  }
}
