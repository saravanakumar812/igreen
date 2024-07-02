import 'package:get/get.dart';
import '../Controller/FundController/FundRequestController.dart';

class FundRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FundRequestController>(() => FundRequestController());
  }
}
