import 'package:get/get.dart';

import '../Controller/LoginController.dart';
import '../Controller/ProjectContoller/ProjectController.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectController>(() => ProjectController());
  }
}
