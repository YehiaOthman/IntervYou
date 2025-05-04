import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      length: 3, // Number of tabs
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: true,
              backgroundColor: Colors.transparent,
              // so the TabBar stays visible at top when scrolling
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(30),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsManger.newSecondaryColor
                    ),
                    child: TabBar(
                      labelColor: Colors.white,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      padding: REdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      tabs: [
                        Text('Posts'),
                        Text('Network'),
                        Text('Chat'),
                      ],
                    ),
                  ),
                ),
              )
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  Center(child: PostsTab()),
                  Center(child: NetwrokTab()),
                  Center(child: ChatTab()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
