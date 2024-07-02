// EscalationResponseScreenController

import 'package:get/get.dart';

import '../Controller/EscalationOneController.dart';
import '../Controller/EscalationPendingScreenController.dart';
import '../Controller/EscalationResponseScreenController.dart';
import '../Controller/LoginController.dart';
import '../Controller/OndutyApprovalScreenController.dart';
import '../Controller/OndutyPendingScreenController.dart';

class OnDutyApprovalScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnDutyApprovalScreenController>(() => OnDutyApprovalScreenController());
  }
}
