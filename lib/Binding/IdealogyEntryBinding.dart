import 'package:get/get.dart';

import '../Controller/IdeaLogyEntryController.dart';

class IdeaLogyEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdeaLogyEntryController>(() => IdeaLogyEntryController());
  }
}
