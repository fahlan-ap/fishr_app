import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:fishr_app/pages/home/home_screen.dart';
import 'package:fishr_app/pages/home/rent_screen.dart';
import 'package:fishr_app/pages/setting/history_screen.dart';
import 'package:fishr_app/pages/setting/profile_screen.dart';

class NavButton extends StatefulWidget {
  const NavButton({super.key});

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  int _pagesIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    RentScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  final iconList = <IconData>[
    Icons.home_rounded,
    Icons.list_alt_outlined,
    Icons.history_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pagesIndex],

      bottomNavigationBar: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: const Color(0xFF012748),
                width: 2.0,
              ),
            ),
          ),
          child: AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: _pagesIndex,
            activeColor: const Color(0xFF7965C1),
            inactiveColor: Colors.grey.shade400,
            backgroundColor: Colors.white,
            elevation: 0,
            iconSize: 28,
            gapLocation: GapLocation.none,
            onTap: (index) => setState(() => _pagesIndex = index),
          ),
        ),
      ),
    );
  }
}