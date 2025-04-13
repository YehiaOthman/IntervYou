import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      extendBody: true,
      backgroundColor: Colors.black,
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Container(
          height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              color: Colors.black.withOpacity(0.8),
            ),
            child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                currentIndex: selectedIndex,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                selectedItemColor: ColorsManger.secondaryColor,
                unselectedItemColor: ColorsManger.txtFillColor,
                selectedLabelStyle: const TextStyle(fontSize: 12),
                unselectedLabelStyle: const TextStyle(fontSize: 12),
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                elevation: 0,
                iconSize: 25,
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AssetsManager.home,
                        color: selectedIndex == 0
                            ? ColorsManger.secondaryColor
                            : ColorsManger.txtFillColor,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AssetsManager.blogs,
                        color: selectedIndex == 1
                            ? ColorsManger.secondaryColor
                            : ColorsManger.txtFillColor,
                      ),
                      label: 'Blogs'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AssetsManager.learn,
                        color: selectedIndex == 2
                            ? ColorsManger.secondaryColor
                            : ColorsManger.txtFillColor,
                      ),
                      label: 'Learning'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AssetsManager.profile,
                        color: selectedIndex == 3
                            ? ColorsManger.secondaryColor
                            : ColorsManger.txtFillColor,
                            
                      ),
                      label: 'Profile'),
                ])),
      )),
      body: tabs[selectedIndex],
    );
  }
}
