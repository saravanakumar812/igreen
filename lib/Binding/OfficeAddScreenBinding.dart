import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/OfficeAddScreenController.dart';
import '../Controller/NonProjectListControllerScreen.dart';

class OfficeAddScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfficeAddScreenController>(
            () => OfficeAddScreenController());
  }
}
