import 'package:get/get.dart';

import '../../Controller/SiteProjectCreationController/SiteProjectCreationController.dart';

class SiteProjectCreationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SiteProjectCreationController>(
        () => SiteProjectCreationController());
  }
}
