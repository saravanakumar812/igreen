import 'package:get/get.dart';

import '../Controller/ProjectContoller/SalesTeamOneController.dart';

class SalesTeamOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesTeamOneController>(() => SalesTeamOneController());
  }
}
