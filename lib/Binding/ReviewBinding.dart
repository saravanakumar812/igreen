import 'package:get/get.dart';
import 'package:igreen_flutter/Controller/RentedScreenController.dart';
import 'package:igreen_flutter/Controller/ReviewController.dart';

class ReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewController>(() => ReviewController());
  }
}
