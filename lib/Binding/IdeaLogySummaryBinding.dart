import 'package:get/get.dart';

import '../Controller/IdeaLogySummaryController.dart';
import '../Controller/FoodSummaryController.dart';

class IdeaLogySummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdeaLogySummaryController>(() => IdeaLogySummaryController());
  }
}
