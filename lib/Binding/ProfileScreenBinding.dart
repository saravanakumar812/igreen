import 'package:get/get.dart';
import '../Controller/ProfileScreenController.dart';

class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
