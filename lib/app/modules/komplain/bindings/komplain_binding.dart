import 'package:get/get.dart';

import '../controllers/komplain_controller.dart';

class KomplainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KomplainController>(
      () => KomplainController(),
    );
  }
}
