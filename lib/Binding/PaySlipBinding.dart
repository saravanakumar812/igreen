import 'package:get/get.dart';
import '../Controller/PaySlipController.dart';

class PaySlipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaySlipController>(() => PaySlipController());
  }
}
