import 'package:get/get.dart';
import '../Controller/GreenThankController.dart';

class GetSupportScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GreenThankController>(() => GreenThankController());
  }
}
