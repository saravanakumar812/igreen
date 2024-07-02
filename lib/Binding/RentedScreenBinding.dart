import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/RentedScreenController.dart';

class RentedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentedScreenController>(() => RentedScreenController());
  }
}
