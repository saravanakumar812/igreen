import 'package:get/get.dart';
import '../Controller/AddEventsController.dart';

class AddEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEventController>(() => AddEventController());
  }
}
