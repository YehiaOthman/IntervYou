import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/chat_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/netwrok_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/posts_tab.dart';

import '../../../../../../core/assets_manager.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: ColorsManger.newSecondaryColor,
                floating: true,
                snap: true,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                shadowColor: Colors.black,
                surfaceTintColor: ColorsManger.newWhite,
                toolbarHeight: 60,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorsManger.newWhite,
                          width: 1.5,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          AssetsManager.pp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBar(
                        labelColor: ColorsManger.newWhite,
                        dividerColor: Colors.transparent,
                        unselectedLabelColor: Colors.white.withOpacity(0.4),
                        indicatorColor: ColorsManger.newWhite,
                        labelStyle: LightAppStyle.email,
                        tabs: [
                          Tab(
                            text: 'Posts',
                          ),
                          Tab(text: 'Network'),
                          Tab(text: 'Chat'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Padding(
            padding:  REdgeInsets.symmetric(horizontal: 16),
            child: TabBarView(
              children: [PostsTab(), NetwrokTab(), ChatTab()],
            ),
          ),
        ),
      ),
    );
  }
}
