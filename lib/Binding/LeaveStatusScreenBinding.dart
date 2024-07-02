import 'package:get/get.dart';
import '../Controller/LeaveStatusScreenController.dart';

class LeaveStatusScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveStatusScreenController>(
        () => LeaveStatusScreenController());
  }
}
