import 'package:get/get.dart';
import 'package:kozzzila/app/modules/navbar/controllers/navbar_client_controller.dart';

import '../controllers/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarClientController>(
      () => NavbarClientController(),
    );
  }
}
