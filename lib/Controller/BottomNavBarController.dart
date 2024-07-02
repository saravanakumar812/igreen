import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BottomNavBarController extends GetxController {

  late PageController pageController ;
  // int _Page = 0;
  @override

  void onInit() async {
    super.onInit();
    pageController = PageController() ;
  }
}
