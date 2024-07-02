import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../Controller/SupportMessageScreenController.dart';
import '../Controller/TaskViewController.dart';

class TaskViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskViewController>(
            () => TaskViewController());
  }
}
