import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kozzzila/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:kozzzila/app/modules/keuangan/controllers/keuangan_controller.dart';
import 'package:kozzzila/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  //put controller globally
  Get.put(AuthenticationController());
  Get.put(KeuanganController());

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
