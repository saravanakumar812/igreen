import 'package:get/get.dart';
import '../Controller/CreateFundRequestController.dart';

class CreateFundRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateFundRequestController>(
        () => CreateFundRequestController());
  }
}
