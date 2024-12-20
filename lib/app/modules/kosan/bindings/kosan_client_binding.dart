import 'package:get/get.dart';
import 'package:kozzzila/app/modules/kosan/controllers/kosan_client_controller.dart';

import '../controllers/kosan_controller.dart';

class KosanClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KosanClientController>(
      () => KosanClientController(),
    );
  }
}
