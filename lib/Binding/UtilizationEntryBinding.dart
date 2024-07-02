import 'package:get/get.dart';

import '../Controller/UtilizationEntryController.dart';
import '../Controller/WagesEntryController.dart';

class UtilizationEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UtilizationEntryController>(() => UtilizationEntryController());
  }
}
