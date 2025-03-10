import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/widget/widget.dart';
import '../../../../../core/colors_manager.dart';
import '../home_tab/widgets/widgets.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
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
            expandedHeight: 1200.h,
            flexibleSpace: FlexibleSpaceBar(
              background: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 45.h),
                    learnHeader(),
                    SizedBox(height: 15.h),
                    Container(
                      width: 365.w,
                      decoration: BoxDecoration(
                        color: ColorsManger.semiBlack,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today’s milestones',
                              style: LightAppStyle.email,
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,RoutesManger.milestoneTopic);
                                    },
                                    child: milestoneCard(ColorsManger.secondaryColor)),
                                SizedBox(width: 10.w),
                                milestoneCard(ColorsManger.pink),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                milestoneCard(ColorsManger.blue),
                                SizedBox(width: 10.w),
                                milestoneCard(ColorsManger.yellow),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Edit goals',
                                  style: LightAppStyle.email.copyWith(
                                      color: ColorsManger.secondaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Container(
                      width: 365.w,
                      height: 330.h,
                      decoration: BoxDecoration(
                        color: ColorsManger.semiBlack,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Quiz and Test',
                                    style: LightAppStyle.email),
                                Spacer(),
                                Text(
                                  '0',
                                  style: LightAppStyle.email.copyWith(
                                      color: Colors.white, fontSize: 20.sp),
                                ),
                                Text(
                                  '/2',
                                  style: LightAppStyle.email.copyWith(
                                    color: Colors.white.withOpacity(0.5),
                                  )
                                )
                              ],
                            ),
                            SizedBox(height: 20.h),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context,RoutesManger.quiz);
                                },
                                child: quizItemWidget()),
                            SizedBox(height: 20.h),
                            quizItemWidget(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
