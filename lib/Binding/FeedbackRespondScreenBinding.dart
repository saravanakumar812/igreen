import 'package:get/get.dart';
import '../Controller/FeedbackRespondScreenController.dart';

class FeedbackRespondScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackRespondScreenController>(
        () => FeedbackRespondScreenController());
  }
}
