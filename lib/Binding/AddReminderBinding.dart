import 'package:get/get.dart';

import '../Controller/PurchaseEntryController.dart';
import '../Controller/ReminderAddController.dart';
import '../Controller/ReminderController.dart';

class AddReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReminderAddController>(() => ReminderAddController());
  }
}
