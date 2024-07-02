import 'package:get/get.dart';
import '../Controller/TravelEntryController.dart';

class TravelEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelEntryController>(() => TravelEntryController());
  }
}
