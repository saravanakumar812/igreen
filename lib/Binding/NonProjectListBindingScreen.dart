import 'package:get/get.dart';
import '../Controller/NonProjectListControllerScreen.dart';

class NonProjectListBindingScreen extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NonProjectListControllerScreen>(
        () => NonProjectListControllerScreen());
  }
}
