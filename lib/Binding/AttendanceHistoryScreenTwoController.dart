import 'package:get/get.dart';

import '../Controller/AttendanceHistoryScreenTwoController.dart';

class AttendanceHistoryScreenTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceHistoryScreenTwoController>(
        () => AttendanceHistoryScreenTwoController());
  }
}
