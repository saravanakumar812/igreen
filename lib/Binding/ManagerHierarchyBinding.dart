import 'package:get/get.dart';
import '../Controller/ManagerHierarchyController.dart';

class ManagerHierarchyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerHierarchyController>(() => ManagerHierarchyController());
  }
}
