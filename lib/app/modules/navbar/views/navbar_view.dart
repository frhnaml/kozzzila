import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kozzzila/app/modules/home/views/home_view.dart';
import 'package:kozzzila/app/modules/kosan/views/kosan_view.dart';
import 'package:kozzzila/app/modules/komplain/views/komplain_view.dart';
import 'package:kozzzila/app/modules/keuangan/views/keuangan_view.dart';
import 'package:kozzzila/app/modules/akun/views/akun_view.dart';

class NavbarView extends StatefulWidget {
  @override
  _NavbarViewState createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  int _selectedIndex = 0;

  final List<Widget> _views = [
    HomeView(),
    KosanView(),
    KomplainView(),
    KeuanganView(),
    AkunView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.cyan,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GNav(
          backgroundColor: Colors.cyan,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.cyan.shade700,
          gap: 8,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          selectedIndex: _selectedIndex,
          onTabChange: _onItemTapped,
          tabs: [
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
    );
  }
}
