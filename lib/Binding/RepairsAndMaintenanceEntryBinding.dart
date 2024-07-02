import 'package:get/get.dart';

import '../Controller/RepairsAndMaintenanceEntryController.dart';

class RepairsAndMaintenanceEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepairsAndMaintenanceEntryController>(
        () => RepairsAndMaintenanceEntryController());
  }
}
