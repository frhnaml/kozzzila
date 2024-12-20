import 'package:get/get.dart';
import 'package:kozzzila/app/modules/home/controllers/home_controller%20copy.dart';

import '../controllers/home_controller.dart';

class HomeClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeClientController>(
      () => HomeClientController(),
    );
  }
}
