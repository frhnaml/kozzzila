import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kozzzila/app/modules/authentication/views/authentication_view.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/image/Home.png'), 
      nextScreen: const AuthenticationView(),
      duration: 1000,
      backgroundColor: Colors.lightBlue[200]!,);
  }
}
