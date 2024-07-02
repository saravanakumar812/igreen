// EscalationResponseScreenController

import 'package:get/get.dart';

import '../Controller/EscalationOneController.dart';
import '../Controller/EscalationPendingScreenController.dart';
import '../Controller/EscalationResponseScreenController.dart';
import '../Controller/LoginController.dart';
import '../Controller/OndutyPendingScreenController.dart';

class OnDutyPendingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnDutyPendingScreenController>(() => OnDutyPendingScreenController());
  }
}
