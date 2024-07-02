import 'package:get/get.dart';
import '../Controller/EventsController.dart';

class EventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventController>(() => EventController());
  }
}