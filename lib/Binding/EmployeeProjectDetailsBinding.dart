import 'package:get/get.dart';
import '../Controller/EmployeeProjectDetailsController.dart';

class EmployeeProjectDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeProjectDetailsController>(
        () => EmployeeProjectDetailsController());
  }
}
