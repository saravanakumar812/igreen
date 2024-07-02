import 'package:get/get.dart';
import '../Controller/GetEmployeeIdealogyController.dart';
import '../Controller/GetOnDutyEmployeeListController.dart';


class GetOnDutyEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetOnDutyEmployeeListController>(() => GetOnDutyEmployeeListController());
  }
}
