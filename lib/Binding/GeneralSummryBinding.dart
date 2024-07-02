import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../Controller/GeneralSummaryController.dart';

class GeneralSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut <GeneralSummaryController>(() => GeneralSummaryController());
  }
}