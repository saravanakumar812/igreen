import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/AttendanceScreenController.dart';

class AttendanceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceScreeController>(() => AttendanceScreeController());
  }
}
