import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../Controller/FuelSummaryController.dart';

class FuelSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FuelSummaryController>(() => FuelSummaryController());
  }
}
