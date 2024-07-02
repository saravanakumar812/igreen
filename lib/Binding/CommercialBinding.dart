import 'package:get/get.dart';

import '../Controller/ProjectContoller/CommercialPageController.dart';

class CommercialPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommercialPageController>(() => CommercialPageController());
  }
}
