import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../Controller/AddAccommodationController.dart';
class AddAccommodationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAccommodationController>(() => AddAccommodationController());
  }
}
