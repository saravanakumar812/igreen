import 'package:get/get.dart';
import '../Controller/FinanceHomeController.dart';

class FinanceHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinanceHomeController>(() => FinanceHomeController());
  }
}
