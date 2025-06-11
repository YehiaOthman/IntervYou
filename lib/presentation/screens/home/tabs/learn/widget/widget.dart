import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';

Widget milestoneCard(Color color , String title , int taskTodo , int taskDone) {
  return Stack(children: [
    Container(
      height: 110.h,
      width: 155.w,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: color, width: 2.w),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                taskDone.toString(),
                style: LightAppStyle.email.copyWith(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                '/$taskTodo',
                style: LightAppStyle.email.copyWith(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Padding(
            padding:  REdgeInsets.only(left: 12.0),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: LightAppStyle.email.copyWith(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    ),
    Positioned(
      left: 2.5.w,
      top: 2.h,
      child: Container(
          height: 105.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.w),
            borderRadius: BorderRadius.circular(25.r),
          )),
    ),
  ]);
}
Widget quizItemWidget() {
  return Container(
    width: 325.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.r),
      color: Colors.transparent,
      border: Border.all(color: ColorsManger.newSecondaryColor, width: 1.w),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: ColorsManger.newSecondaryColor,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Center(
                child: Text('1',
                    style: LightAppStyle.email.copyWith(
                        color: Colors.white,
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
                    color: ColorsManger.newSecondaryColor,
                    fontSize: 18.sp,),
                ),
                Text(
                  '20',
                  style: LightAppStyle.email.copyWith(
                    color: ColorsManger.newSecondaryColor,
                    fontSize: 18.sp,),
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
                    Icons.timer_sharp, color: ColorsManger.newSecondaryColor,
                    size: 30.sp,),
                ),
                Text('30min',
                    style: LightAppStyle.email.copyWith(
                      color: ColorsManger.newSecondaryColor,
                      fontSize: 12.sp,
                    ))
              ],
            ),
          )
        ],
      ),
    ),
  );
}

