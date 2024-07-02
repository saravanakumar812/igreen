import 'package:get/get.dart';
import '../Controller/EarningScreenController.dart';
class EarningScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EarningScreenController>(() => EarningScreenController());
  }
}
