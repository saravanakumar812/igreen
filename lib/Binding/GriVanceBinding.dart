import 'package:get/get.dart';
import '../Controller/GriVanceController.dart';

class GriVanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GriVanceController>(() => GriVanceController());
  }
}
