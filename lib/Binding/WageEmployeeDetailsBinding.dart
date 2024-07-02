import 'package:get/get.dart';
import '../Controller/WageEmployeeDetailsController.dart';
import '../Controller/WageEmployeeListController.dart';

class WageEmployeeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WageEmployeeDetailsController>(
        () => WageEmployeeDetailsController());
  }
}
