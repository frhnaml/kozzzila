import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:kozzzila/app/modules/authentication/views/registrationView.dart';
import 'package:kozzzila/app/routes/app_pages.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  AuthenticationView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 24.0), // Adjust the padding as needed
          child: ListView(
            shrinkWrap:
                true, // Makes the ListView only take up as much space as needed
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/image/Home.png', height: 100),
              const SizedBox(height: 40),
              const Text(
                'Account login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'email',
                  fillColor: Colors.grey[700],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password',
                  fillColor: Colors.grey[700],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.to(Registrationview());
                },
                child: const Text(
                  'register',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: 12),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            Get.snackbar(
                                'Error', 'Pastikan email dan password benar',
                                backgroundColor: Colors.red);
                          } else {
                            controller.loginUser(_emailController.text,
                                _passwordController.text);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }),
              const SizedBox(height: 60),
              const Text(
                'More login methods',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return IconButton(
                      onPressed: controller.isLoading.value ? null : () {},
                      icon: const Icon(Icons.email_outlined),
                    );
                  }),
                  const SizedBox(width: 8),
                  Obx(() {
                    return IconButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              if (!controller.isLoading.value) {
                                controller.isLoading.value = true;
                                var userCredential =
                                    await controller.signInWithGoogle();

                                if (userCredential != null) {
                                  Get.snackbar('Sukses',
                                      'Login menggunakan google sukses',
                                      backgroundColor: Colors.green);
                                  Get.toNamed(Routes.KEUANGAN);
                                } else {
                                  Get.snackbar(
                                      'Gagal', 'Login menggunakan google gagal',
                                      backgroundColor: Colors.red);
                                }
                                controller.isLoading.value = false;
                              }
                            },
                      icon: SvgPicture.asset(
                        'assets/image/googleIcon.svg',
                        height: 24,
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
