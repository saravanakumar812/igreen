import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../provider/menuProvider.dart';

class AnnouncementController extends GetxController {
  RxString editButtonText = RxString('Reject');
  RxString reuseButtonText = RxString('Approve');
  late menuDataProvider userDataProvider;
  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
  }
}
