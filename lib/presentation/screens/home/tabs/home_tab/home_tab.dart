import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/home_tab/widgets/widgets.dart';

import '../../../../../core/colors_manager.dart';

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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: false,
          snap: true,
          backgroundColor: Colors.black,
          elevation: 0,
          expandedHeight: 300.h,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorsManger.newSecondaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50.h),
                          homeHeader(),
                          SizedBox(height: 35.h),
                          Row(
                            children: [
                              Text('''Continue Your
Learning Adventure!''',
                                  style: LightAppStyle.email.copyWith(
                                    fontSize: 18.sp,
                                  )),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30.sp,
                              )
                            ],
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
