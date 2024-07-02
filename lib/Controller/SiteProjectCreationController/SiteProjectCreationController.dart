import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SiteProjectCreationController extends GetxController {

  late final WebViewController controller;
  @override
  void onInit() {
    super.onInit();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse("https://cmsuat.mdqualityapps.in/home/siteproject"),
      );
  }

}
