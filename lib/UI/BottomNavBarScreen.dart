import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igreen_flutter/UI/Profile/ProfileScreen.dart';

import '../../forms/theme.dart';

import 'Screens/AttendenceScreen.dart';
import 'Screens/HomeScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PageController pageController = PageController(initialPage: 1) ;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView(
          controller: pageController,
          children: <Widget>[
            AttendanceScreen(),
            HomeScreen(),
            ProfileScreen(),
          ],
          onPageChanged: (int index) {
            setState(() {
              pageController.jumpToPage(index);
            });
          }),
      bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          animationCurve: Curves.easeInOut,
          color: AppTheme.secondaryColor,
          backgroundColor: Colors.transparent,
          height: 60,
          onTap: (int index) {
            setState(() {
              pageController.jumpToPage(index);
            });
          },
          items: [
            Icon(
              Icons.list,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ]),
    ));
  }
}
