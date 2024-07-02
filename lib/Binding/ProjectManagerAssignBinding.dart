import 'package:get/get.dart';

import '../Controller/ProjectManagerAssignController.dart';

class ProjectManagerAssignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectManagerAssignController>(
        () => ProjectManagerAssignController());
  }
}
