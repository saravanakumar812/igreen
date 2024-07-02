import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/FeedbacsController.dart';

import '../Controller/LoginController.dart';

class FeedbacksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedBackController>(() => FeedBackController());
  }
}
