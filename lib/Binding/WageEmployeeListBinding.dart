import 'package:get/get.dart';
import '../Controller/WageEmployeeListController.dart';

class WageEmployeeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WageEmployeeListController>(() => WageEmployeeListController());
  }
}
