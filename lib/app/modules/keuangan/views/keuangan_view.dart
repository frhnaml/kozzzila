import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/keuangan_controller.dart';

class KeuanganView extends GetView<KeuanganController> {
  const KeuanganView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeuanganView', textAlign: TextAlign.start,),
        backgroundColor: Colors.lightBlue[200],
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: (){
          }, icon: const Icon(Icons.download, color: Colors.black, weight: 2,))
        ],
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
