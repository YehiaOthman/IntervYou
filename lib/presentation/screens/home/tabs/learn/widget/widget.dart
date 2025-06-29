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


Widget quizItemWidget(int index , String quizName,bool isDone) {
  return Container(
    width: 325.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.r),
      color: Colors.transparent,
      border: Border.all(color: ColorsManger.newSecondaryColor, width: 1.w),
    ),
    child: Padding(
      padding:  REdgeInsets.all(15),
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
                child: Text(index.toString(),
                    style: LightAppStyle.email.copyWith(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: REdgeInsets.only(top: 8, left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quizName.length > 20 ? '${quizName.substring(0, 17)}...' : quizName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: LightAppStyle.email.copyWith(
                    color: ColorsManger.newSecondaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 17.sp,
                  ),
                ),

                Row(
                  children: [
                    Text(
                      '10 ',
                      style: LightAppStyle.email.copyWith(
                        color: ColorsManger.newSecondaryColor,
                        fontSize: 18.sp,),
                    ),
                    Text(
                      'Questions',
                      style: LightAppStyle.email.copyWith(
                        color: ColorsManger.newSecondaryColor,
                        fontSize: 16.sp,),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          if (isDone)
            Container(
              width: 25.w,
              height: 25.h,
              decoration: BoxDecoration(
                color: ColorsManger.newSecondaryColor,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 20.sp
              ),
            ),
        ],
      ),
    ),
  );
}

