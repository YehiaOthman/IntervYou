import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';

Widget milestoneCard(Color color) {
  return Stack(children: [
    Container(
        height: 110.h,
        width: 155.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          border: Border.all(color: color, width: 2.5.w),
          borderRadius: BorderRadius.circular(25.r),
        )),
    Container(
      height: 110.h,
      width: 155.w,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        border: Border.all(color: color, width: 2.w),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 15.w,
              ),
              Text(
                '7',
                style: LightAppStyle.email.copyWith(
                    color: ColorsManger.semiBlack,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '/14',
                style: LightAppStyle.email.copyWith(
                    color: ColorsManger.semiBlack.withOpacity(0.4),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Arrays',
              style: LightAppStyle.email.copyWith(
                  color: ColorsManger.semiBlack,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    ),
  ]);
}

Widget quizItemWidget() {
  return Container(
    width: 325.w,
    height: 100.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.r),
      color: Colors.black,
      border: Border.all(color: ColorsManger.secondaryColor, width: 2.w),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: ColorsManger.secondaryColor,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Center(
                child: Text('1',
                    style: LightAppStyle.email.copyWith(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Widgets Types',
                  style: LightAppStyle.email.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,),
                ),
                Text(
                  '20',
                  style: LightAppStyle.email.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 8,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.timer_sharp, color: ColorsManger.secondaryColor,
                    size: 30.sp,),
                ),
                Text('30min',
                    style: LightAppStyle.email.copyWith(
                      color: ColorsManger.secondaryColor,
                      fontSize: 11.sp,
                    ))
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget milestoneTopicWidget(int index,) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.r)),
      color: ColorsManger.semiBlack.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$index', style: LightAppStyle.email.copyWith(
                color: Colors.white.withOpacity(0.5),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold), ),
            Text('Introduction to Arrays', style: LightAppStyle.email.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.normal

            )),
            Container(
              height: 25.h,
              width: 25.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: ColorsManger.secondaryColor.withOpacity(0.5)
              ),
              child: Icon(Icons.check,color: ColorsManger.secondaryColor,),
            )
          ],
        ),
      ),

    ),
  );
}

