import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import '../api_connect/api_connect.dart';
import '../model/responseModel/EventsList.dart';
import '../provider/menuProvider.dart';

class AddEventController extends GetxController {
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late menuDataProvider userDataProvider;
  RxList<EventData> eventData = RxList();
  RxString editButtonText = RxString('Reject');
  RxString reuseButtonText = RxString('View');
  bool isCall = false;
  @override
  void onInit() async {
    super.onInit();
    userDataProvider =
        Provider.of<menuDataProvider>(Get.context!, listen: false);
    if (!isCall) {
      isCall = true;
      getEventTeam();
    }
  }

  Future<void> refreshData() async {
    getEventTeam();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getEventTeam() async {
    isLoading.value = true;
    var response = await _connect.getEventCall();
    isLoading.value = false;
    if (!response.error!) {
      eventData.value = response.eventsData!;
      update();
    }
  }
}
