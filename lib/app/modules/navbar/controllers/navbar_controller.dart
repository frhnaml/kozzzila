import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../../kosan/views/kosan_view.dart';
import '../../komplain/views/komplain_view.dart';
import '../../keuangan/views/keuangan_view.dart';
import '../../akun/views/akun_view.dart';

class NavbarController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> views = [
    HomeView(),
    KosanView(),
    KomplainView(),
    KeuanganView(),
    AkunView(),
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
