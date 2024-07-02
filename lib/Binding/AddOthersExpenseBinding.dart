import 'package:get/get.dart';

import '../Controller/AddOthersExpenseController.dart';
import '../Controller/WagesEntryController.dart';

class AddOthersExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut< AddOthersExpenseController>(() =>  AddOthersExpenseController());
  }
}
