import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/keuangan_controller.dart';

class KeuanganView extends GetView<KeuanganController> {
  const KeuanganView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeuanganView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KeuanganView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
