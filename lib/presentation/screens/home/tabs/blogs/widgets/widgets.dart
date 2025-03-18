import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/assets_manager.dart';
import 'package:intervyou_app/core/colors_manager.dart';

import '../../../../../../config/styles/light_app_style.dart';

Widget blogsHeader() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Stack(clipBehavior: Clip.none, children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: Image.asset(AssetsManager.pp, width: 60.w, height: 60.h)),
        Positioned(
            left: 5.w,
            top: 4.h,
            child: Container(
              width: 12.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: Colors.white, width: 1.w),
                borderRadius: BorderRadius.circular(15.r),
              ),
            )),
      ]),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 7),
            child: Text(
              'Yehia Othman',
              style: LightAppStyle.email.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17, top: 5),
            child: Text(
              '105 Friends Online',
              style: LightAppStyle.email.copyWith(
                  color: ColorsManger.secondaryColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    ],
  );
}




