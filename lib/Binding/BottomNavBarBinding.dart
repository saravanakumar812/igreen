import 'package:get/get.dart';

import '../Controller/BottomNavBarController.dart';


class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavBarController>(() => BottomNavBarController());
  }
}
