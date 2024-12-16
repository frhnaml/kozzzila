import 'package:get/get.dart';

import '../controllers/kosan_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KosanController>(
      () => KosanController(),
    );
  }
}
