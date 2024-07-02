import 'package:get/get.dart';
import '../Controller/FoodEntryController.dart';

class FoodEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodEntryController>(() => FoodEntryController());
  }
}
