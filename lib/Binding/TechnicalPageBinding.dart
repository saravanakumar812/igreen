import 'package:get/get.dart';
import '../Controller/ProjectContoller/TechnicalPageController.dart';

class TechnicalPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TechnicalPageController>(() => TechnicalPageController());
  }
}
