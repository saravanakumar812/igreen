import 'package:get/get.dart';

import '../Controller/LeaveApplyController.dart';

class LeaveApplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveApplyController>(() => LeaveApplyController());
  }
}
