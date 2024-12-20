import 'package:get/get.dart';
import 'package:kozzzila/app/modules/keuangan/controllers/keuangan_client_controller.dart';

import '../controllers/keuangan_controller.dart';

class KeuanganClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeuanganClientController>(
      () => KeuanganClientController(),
    );
  }
}
