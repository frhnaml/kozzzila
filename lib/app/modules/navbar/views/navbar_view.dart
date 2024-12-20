import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kozzzila/app/modules/authentication/controllers/authentication_controller.dart';

import '../controllers/navbar_controller.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavbarController controller = Get.put(NavbarController());
    

    return Obx(() => Scaffold(
          body: controller.views[controller.selectedIndex.value],
          bottomNavigationBar: Container(
            color: Colors.cyan,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GNav(
              backgroundColor: Colors.cyan,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.cyan.shade700,
              gap: 8,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              selectedIndex: controller.selectedIndex.value,
              onTabChange: controller.onItemTapped,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.business,
                  text: 'Kosan',
                ),
                GButton(
                  icon: Icons.report,
                  text: 'Komplain',
                ),
                GButton(
                  icon: Icons.attach_money,
                  text: 'Keuangan',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Akun',
                ),
              ],
            ),
          ),
        ));
  }
}
