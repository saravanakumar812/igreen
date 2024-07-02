
import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/AnnouncementController.dart';

import '../Controller/AssignMechanicalTeamController.dart';


class AssignMechanicalTeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignMechanicalTeamController>(() => AssignMechanicalTeamController());
  }
}
