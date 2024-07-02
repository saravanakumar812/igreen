import 'package:get/get.dart';

import '../Controller/PurchaseEntryController.dart';
import '../Controller/ReminderController.dart';

class ReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReminderController>(() => ReminderController());
  }
}
