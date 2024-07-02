import 'package:get/get.dart';
import '../Controller/GriVanceCreateScreenController.dart';

class GriVanceCreateScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GriVanceCreateScreenController>(
        () => GriVanceCreateScreenController());
  }
}
