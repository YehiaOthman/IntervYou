import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intervyou_app/core/assets_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/blogs.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/home_tab/view/home_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view/learn.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/profile/profile.dart';

import '../../../core/colors_manager.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  late final List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    tabs = [
      HomeTab(onNavigateToLearn: () => _changeTab(2)),
      const Blogs(),
      const Learn(),
      const Profile(),
    ];
  }

  void _changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorsManger.newSecondaryColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.white.withOpacity(0.1),
              hoverColor: Colors.white.withOpacity(0.1),
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 300),
              tabBackgroundColor: Colors.white.withOpacity(0.1),
              color: Colors.white.withOpacity(0.7),
              textStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              tabs: [
                GButton(
                  leading: SvgPicture.asset(AssetsManager.home, colorFilter: ColorFilter.mode(selectedIndex == 0 ? Colors.white : Colors.white.withOpacity(0.7), BlendMode.srcIn)),
                  text: 'Home',
                  icon: Icons.home,
                ),
                GButton(
                  leading: SvgPicture.asset(AssetsManager.blogs, colorFilter: ColorFilter.mode(selectedIndex == 1 ? Colors.white : Colors.white.withOpacity(0.7), BlendMode.srcIn)),
                  text: 'Blogs',
                  icon: Icons.article,
                ),
                GButton(
                  leading: SvgPicture.asset(AssetsManager.learn, colorFilter: ColorFilter.mode(selectedIndex == 2 ? Colors.white : Colors.white.withOpacity(0.7), BlendMode.srcIn)),
                  text: 'Learning',
                  icon: Icons.school,
                ),
                GButton(
                  leading: SvgPicture.asset(AssetsManager.profile, colorFilter: ColorFilter.mode(selectedIndex == 3 ? Colors.white : Colors.white.withOpacity(0.7), BlendMode.srcIn)),
                  text: 'Profile',
                  icon: Icons.person,
                ),
              ],
              selectedIndex: selectedIndex,
              onTabChange: _changeTab,
            ),
          ),
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
}