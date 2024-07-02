import 'package:get/get.dart';

import '../Controller/LoginController.dart';
import '../Controller/ProjectContoller/ProjectController.dart';
import '../Controller/ProjectListViewController.dart';

class ProjectListViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectListViewController>(() => ProjectListViewController());
  }
}
