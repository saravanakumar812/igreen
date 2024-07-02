import 'package:get/get.dart';

import '../Controller/EscalationOneController.dart';
import '../Controller/LoginController.dart';

class EscalationOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EscalationOneController>(() => EscalationOneController());
  }
}
