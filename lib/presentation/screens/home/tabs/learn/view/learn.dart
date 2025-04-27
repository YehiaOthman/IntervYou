import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/widget/widget.dart';
import '../../../../../../core/colors_manager.dart';
import '../../home_tab/widgets/widgets.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
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
                  color: ColorsManger.newSecondaryColor.withOpacity(0.08),
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
                        style: LightAppStyle.email.copyWith(
                          color: ColorsManger.newSecondaryColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),

                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesManger.milestoneTopic);
                              },
                              child: milestoneCard(ColorsManger.milestoneColor1)),
                          SizedBox(width: 10.w),
                          milestoneCard(ColorsManger.milestoneColor2),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          milestoneCard(ColorsManger.milestoneColor3),
                          SizedBox(width: 10.w),
                          milestoneCard(ColorsManger.milestoneColor4),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Edit goals',
                            style: LightAppStyle.email.copyWith(
                                color: ColorsManger.newSecondaryColor,
                                fontSize: 18.sp,
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

                decoration: BoxDecoration(
                  color: ColorsManger.newSecondaryColor.withOpacity(0.08),
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
                          Text('Quiz and Test', style: LightAppStyle.email.copyWith(
                            color: ColorsManger.newSecondaryColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          )),
                          Spacer(),
                          Text(
                            '0',
                            style: LightAppStyle.email
                                .copyWith(color: ColorsManger.newSecondaryColor, fontSize: 22.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('/2',
                              style: LightAppStyle.email.copyWith(
                                color: ColorsManger.newSecondaryColor.withOpacity(0.5),
                                fontSize: 22.sp,
                              ))
                        ],
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesManger.quiz);
                          },
                          child: quizItemWidget()),
                      SizedBox(height: 20.h),
                      quizItemWidget()

                    ],
                  ),
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}
