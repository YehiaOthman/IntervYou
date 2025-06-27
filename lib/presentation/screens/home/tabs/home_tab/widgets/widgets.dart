import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/assets_manager.dart';
import 'package:intervyou_app/core/colors_manager.dart';

Widget buildCardItem(String subTopicName, String subTopicDescription, int finishedTasks, int totalTasks) {
  int taskProgress = ((finishedTasks / totalTasks) * 100).toInt() ;
  return SizedBox(
    width: 200.w,
    child: Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: REdgeInsets.only(left: 12.w, right: 12.w),
            height: 55.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManger.newSecondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              subTopicName,
              style: LightAppStyle.email.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          Center(
            child: Text(
              subTopicDescription,
              style: LightAppStyle.email.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              textWidthBasis: TextWidthBasis.longestLine,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Spacer(),
          Padding(
            padding: REdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              children: [
                Text(
                  'Topic ${finishedTasks}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '/${totalTasks}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
                Spacer(),
                Text(
                  '$taskProgress%',
                  style: TextStyle(
                    color: ColorsManger.secondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
          Spacer()

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

Widget homeHeader(String name) {
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
              fontSize: 13.sp,
            ),
          ),
          Text(
            name,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
      Spacer(),
      Icon(
        Icons.notifications_none,
        color: Colors.white,
        size: 30.sp,
      ),
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
                color: Colors.black.withOpacity(0.5),
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Keep it up!",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Colors.black,
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
            color: ColorsManger.newSecondaryColor,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Icon(
            Icons.bookmark_border_rounded,
            color: Colors.white,
            size: 35.sp,
          ),
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
