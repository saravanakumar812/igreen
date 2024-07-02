import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/AttendanceApprovalController.dart';

import '../Controller/LoginController.dart';

class AttendanceApprovalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceApprovalController>(
        () => AttendanceApprovalController());
  }
}
