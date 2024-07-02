// EscalationResponseScreenController

import 'package:get/get.dart';

import '../Controller/EscalationOneController.dart';
import '../Controller/EscalationResponseScreenController.dart';
import '../Controller/LoginController.dart';

class EscalationResponseScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EscalationResponseScreenController>(() => EscalationResponseScreenController());
  }
}
