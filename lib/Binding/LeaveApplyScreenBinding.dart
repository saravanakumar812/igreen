import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/LeaveApplyScreenController.dart';

import '../Controller/LoginController.dart';

class LeaveApplyScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveApplyScreenController>(() => LeaveApplyScreenController());
  }
}
