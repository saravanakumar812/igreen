import 'package:get/get.dart';
import '../Controller/TransportExpenseController.dart';
import '../Controller/TravelEntryController.dart';

class TransportExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransportExpenseController>(() => TransportExpenseController());
  }
}
