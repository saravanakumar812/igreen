
import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/AnnouncementController.dart';

import '../Controller/LoginController.dart';

class AnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnnouncementController>(() => AnnouncementController());
  }
}
