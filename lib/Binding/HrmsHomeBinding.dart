import 'package:get/get.dart';

import '../Controller/HRMSHomeController.dart';

class HRMSHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HRMSHomeController>(() => HRMSHomeController());
  }
}
