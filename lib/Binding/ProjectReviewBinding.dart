import 'package:get/get.dart';
import '../Controller/ProjectReviewController.dart';

class ProjectReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectReviewController>(() => ProjectReviewController());
  }
}
