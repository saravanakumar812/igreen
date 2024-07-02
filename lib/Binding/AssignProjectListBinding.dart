
import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/AnnouncementController.dart';
import 'package:igreen_flutter/Controller/AssignProjectList.dart';

import '../Controller/LoginController.dart';

class AssignProjectListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignProjectListController>(() => AssignProjectListController());
  }
}
