import 'package:get/get.dart';

import '../Controller/AddOthersExpenseController.dart';
import '../Controller/AddOthersSummary.dart';
import '../Controller/WagesEntryController.dart';

class AddOthersSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOthersSummaryController>(() => AddOthersSummaryController());
  }
}
