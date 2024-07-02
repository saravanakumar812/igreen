import 'package:get/get.dart';

import '../Controller/PurchaseEntryController.dart';

class PurchaseEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseEntryController>(() => PurchaseEntryController());
  }
}
