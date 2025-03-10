import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/home_tab/widgets/widgets.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Widget> widgets = [
    buildTasksItem(),
    buildDailyQuizTaskItem(),
    buildTasksItem(),
    buildTasksItem(),
    buildDailyQuizTaskItem(),
    buildDailyQuizTaskItem(),
    buildTasksItem(),
    buildTasksItem(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            backgroundColor: Colors.black,
            elevation: 0,
            expandedHeight: 110.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 45.h),
                  homeHeader(),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RoutesManger.milestoneTopic);
                    },
                    child: widgets[index]),
              ),
              childCount: widgets.length,
            ),
          ),
        ],
      ),
    );
  }
}
