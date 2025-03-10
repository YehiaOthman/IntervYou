import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intervyou_app/core/assets_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/blogs.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/home_tab/home_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/learn.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/profile/profile.dart';
import '../../../core/colors_manager.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    Blogs(),
    Learn(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              blurRadius: 13,
              spreadRadius: -2,
              offset: Offset(0, 2.5),
              blurStyle: BlurStyle.solid,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedItemColor: ColorsManger.secondaryColor,
          unselectedItemColor: ColorsManger.txtFillColor,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsManager.home,
                width: 25,
                height: 25,
                color: selectedIndex == 0
                    ? ColorsManger.secondaryColor
                    : ColorsManger.txtFillColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsManager.blogs,
                width: 20,
                height: 20,
                color: selectedIndex == 1
                    ? ColorsManger.secondaryColor
                    : ColorsManger.txtFillColor,
              ),
              label: 'Blogs',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsManager.learn,
                width: 25,
                height: 25,
                color: selectedIndex == 2
                    ? ColorsManger.secondaryColor
                    : ColorsManger.txtFillColor,
              ),
              label: 'Learning',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsManager.profile,
                width: 25,
                height: 25,
                color: selectedIndex == 3
                    ? ColorsManger.secondaryColor
                    : ColorsManger.txtFillColor,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
}
