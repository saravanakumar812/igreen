// EscalationResponseScreenController

import 'package:get/get.dart';

import '../Controller/EscalationOneController.dart';
import '../Controller/EscalationPendingScreenController.dart';
import '../Controller/EscalationResponseScreenController.dart';
import '../Controller/IdeasAgreeScreenController.dart';
import '../Controller/LoginController.dart';

class IdeasAgreeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdeasAgreeScreenController>(() => IdeasAgreeScreenController());
  }
}
