import 'package:get/get.dart';
import '../Controller/GreenThankController.dart';
import '../Controller/MaintenanceController.dart';

class MaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaintenanceController>(() => MaintenanceController());
  }
}
