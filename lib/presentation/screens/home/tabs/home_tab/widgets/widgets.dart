import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intervyou_app/core/assets_manager.dart';
import 'package:intervyou_app/core/colors_manager.dart';

Widget buildTasksItem() {
  return Card(
    color: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorsManger.semiBlack,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Problem Solving *(STL)',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            '''The Standard Template Library in C++ is a powerful and widely-used library that provides a set of tools to help programmers solve problems efficiently.''',
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Work progress',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Text(
                '56%',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          LinearProgressIndicator(
            value: 0.56,
            color: ColorsManger.secondaryColor,
            backgroundColor: Colors.white,
            minHeight: 20.h,
            borderRadius: BorderRadius.circular(10),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ppItemWidget(),
                    Positioned(
                      left: 20,
                      child: ppItemWidget(),
                    ),
                    Positioned(
                      left: 40,
                      child: ppItemWidget(),
                    ),
                    Positioned(
                      left: 60,
                      child: Container(
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Center(
                          child: Text(
                            "2+",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
Widget buildDailyQuizTaskItem() {
  return Card(
    color: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorsManger.semiBlack,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Daily Quiz',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Work progress',
                  style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
              Text('0%',
                  style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            ],
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: 0.1,
            color: ColorsManger.secondaryColor,
            backgroundColor: Colors.white,
            minHeight: 20,
            borderRadius: BorderRadius.circular(10),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    ),
  );
}
Widget homeHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 23.r,
        backgroundImage: AssetImage(
          AssetsManager.pp,
        ),
      ),
      SizedBox(width: 10.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back",
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 12.sp,
            ),
          ),
          Text(
            "Yehia Mohamed Othman",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
      Spacer(),
      Icon(Icons.notifications_none, color: Colors.white,size: 30.sp,),
    ],
  );
}
Widget learnHeader() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "25/53",
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 20.sp,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Keep it up!",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  WidgetSpan(
                    child: Text("🚀",
                        style: GoogleFonts.notoColorEmoji(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Icon(Icons.bookmark_border_rounded, color: Colors.black,size: 40.sp,),
        )
      ],
    ),
  );
}
Widget ppItemWidget() {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(
            color: Colors.white,
            width: 2.w,
          )),
      child: Image.asset(
        AssetsManager.pp,
        width: 23.w,
        height: 23.h,
      ));
}
