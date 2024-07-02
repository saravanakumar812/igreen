import 'package:get/get.dart';
import '../Controller/AttendanceHistoryScreenOneController.dart';

class AttendanceHistoryScreenOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceHistoryScreenOneController>(
        () => AttendanceHistoryScreenOneController());
  }
}
