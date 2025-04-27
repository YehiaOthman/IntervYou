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
            padding:  REdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.white.withOpacity(0.1),
              hoverColor: Colors.white.withOpacity(0.1),
              gap: 8,
              activeColor: ColorsManger.newSecondaryColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 300),
              tabBackgroundColor: Colors.white.withOpacity(0.1),
              color: Colors.black,
              textStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
              tabs: [
                GButton(
                  leading: SvgPicture.asset(
                    AssetsManager.home,
                    color: Colors.white
                  ),
                  text: 'Home', icon: Icons.circle,
                ),
                GButton(
                  leading: SvgPicture.asset(
                    AssetsManager.blogs,
                    color: Colors.white,
                  ),
                  text: 'Blogs', icon: Icons.circle,
                ),
                GButton(
                  leading: SvgPicture.asset(
                    AssetsManager.learn,
                    color: Colors.white,
                  ),
                  text: 'Learning', icon: Icons.circle,
                ),
                GButton(
                  leading: SvgPicture.asset(
                    AssetsManager.profile,
                    color:  Colors.white,
                  ),
                  text: 'Profile', icon: Icons.circle,
                ),
              ],
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
}
// bottomNavigationBar: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//         child: Container(
//           height: 60.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25.r),
//               color: Colors.black.withOpacity(0.8),
//             ),
//             child: BottomNavigationBar(
//                 backgroundColor: Colors.transparent,
//                 currentIndex: selectedIndex,
//                 onTap: (index) {
//                   setState(() {
//                     selectedIndex = index;
//                   });
//                 },
//                 selectedItemColor: ColorsManger.secondaryColor,
//                 unselectedItemColor: ColorsManger.txtFillColor,
//                 selectedLabelStyle: const TextStyle(fontSize: 12),
//                 unselectedLabelStyle: const TextStyle(fontSize: 12),
//                 type: BottomNavigationBarType.fixed,
//                 showSelectedLabels: true,
//                 showUnselectedLabels: false,
//                 elevation: 0,
//                 iconSize: 25,
//                 items: [
//                   BottomNavigationBarItem(
//                       icon: SvgPicture.asset(
//                         AssetsManager.home,
//                         color: selectedIndex == 0
//                             ? ColorsManger.secondaryColor
//                             : ColorsManger.txtFillColor,
//                       ),
//                       label: 'Home'),
//                   BottomNavigationBarItem(
//                       icon: SvgPicture.asset(
//                         AssetsManager.blogs,
//                         color: selectedIndex == 1
//                             ? ColorsManger.secondaryColor
//                             : ColorsManger.txtFillColor,
//                       ),
//                       label: 'Blogs'),
//                   BottomNavigationBarItem(
//                       icon: SvgPicture.asset(
//                         AssetsManager.learn,
//                         color: selectedIndex == 2
//                             ? ColorsManger.secondaryColor
//                             : ColorsManger.txtFillColor,
//                       ),
//                       label: 'Learning'),
//                   BottomNavigationBarItem(
//                       icon: SvgPicture.asset(
//                         AssetsManager.profile,
//                         color: selectedIndex == 3
//                             ? ColorsManger.secondaryColor
//                             : ColorsManger.txtFillColor,
//
//                       ),
//                       label: 'Profile'),
//                 ])),
//       )),
