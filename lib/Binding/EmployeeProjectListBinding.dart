import 'package:get/get.dart';
import '../Controller/EmployeeProjectListController.dart';
class EmployeeProjectListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeProjectListController>(
        () => EmployeeProjectListController());
  }
}
