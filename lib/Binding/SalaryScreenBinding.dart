import 'package:get/get.dart';
import '../Controller/SalaryScreenController.dart';

class SalaryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalaryScreenController>(() => SalaryScreenController());
  }
}
