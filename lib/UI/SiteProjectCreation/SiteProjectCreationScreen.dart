

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Controller/SiteProjectCreationController/SiteProjectCreationController.dart';

class SiteProjectCreationScreen extends GetView<SiteProjectCreationController> {
  const SiteProjectCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double  width = MediaQuery.of(context).size.width;
    double  height = MediaQuery.of(context).size.height;
    SiteProjectCreationController controller = Get.put(SiteProjectCreationController());
    return  SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width:width,
          child: WebViewWidget(
            controller: controller.controller,
          ),
        ),
      ),
    );
  }

}