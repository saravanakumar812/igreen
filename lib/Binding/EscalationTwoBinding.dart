import 'package:get/get.dart';
import '../Controller/EscalationTwoController.dart';

class EscalationTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EscalationTwoController>(() => EscalationTwoController());
  }
}
