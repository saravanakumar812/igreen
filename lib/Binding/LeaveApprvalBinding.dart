import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/LeaveApprovalController.dart';

class LeaveApprovalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveApprovalController>(() => LeaveApprovalController());
  }
}
