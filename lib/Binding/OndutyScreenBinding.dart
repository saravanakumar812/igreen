import 'package:get/get.dart';
import '../Controller/OndutyEntryScreenController.dart';
import '../Controller/OndutyScreenController.dart';
import '../Controller/OndutySummaryScreenController.dart';


class OnDutyScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnDutyScreenController>(() => OnDutyScreenController());
  }
}
