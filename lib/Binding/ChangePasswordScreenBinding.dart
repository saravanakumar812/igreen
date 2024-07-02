import 'package:get/get.dart';

import '../Controller/ChangePasswordScreenController.dart';


class ChangePasswordScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordScreenController>(() => ChangePasswordScreenController());
  }
}
