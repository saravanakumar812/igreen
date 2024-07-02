import 'package:get/get.dart';
import '../Controller/OndutyEntryScreenController.dart';
import '../Controller/OndutySummaryScreenController.dart';


class OnDutyEntryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnDutyEntryScreenController>(() => OnDutyEntryScreenController());
  }
}
