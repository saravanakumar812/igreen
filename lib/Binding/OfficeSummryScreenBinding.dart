import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/OfficeSummaryScreenController.dart';
import '../Controller/NonProjectListControllerScreen.dart';

class OfficeSummaryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfficeSummaryScreenController>(
            () => OfficeSummaryScreenController());
  }
}
