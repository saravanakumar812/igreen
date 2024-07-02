// EscalationResponseScreenController

import 'package:get/get.dart';

import '../Controller/EscalationOneController.dart';
import '../Controller/EscalationPendingScreenController.dart';
import '../Controller/EscalationResponseScreenController.dart';
import '../Controller/LoginController.dart';
import '../Controller/OndutyPendingScreenController.dart';
import '../Controller/OndutyRejectScreenController.dart';

class OnDutyRejectScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnDutyRejectScreenController>(() => OnDutyRejectScreenController());
  }
}
