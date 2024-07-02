import 'package:get/get.dart';
import '../Controller/GetCommercialFromTechnicalController.dart';

class GetCommercialFromTechnicalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCommercialFromTechnicalController>(() => GetCommercialFromTechnicalController());
  }
}
