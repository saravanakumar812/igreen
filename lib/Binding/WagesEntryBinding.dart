import 'package:get/get.dart';

import '../Controller/WagesEntryController.dart';

class WagesEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WagesEntryController>(() => WagesEntryController());
  }
}
