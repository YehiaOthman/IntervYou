import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/home/home.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view/learn.dart';
import '../../../../../../core/colors_manager.dart';
import 'models/questions.dart';

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsManger.newWhite,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          SizedBox(width: 1000.h),
          Container(
              width: 140.w,
              height: 140.h,
              decoration: BoxDecoration(
                color: ColorsManger.newSecondaryColor,
                borderRadius: BorderRadius.circular(75.r),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 110.sp,
              )),
          SizedBox(height: 20.h),
          Text(
            'Quiz Completed',
            style: LightAppStyle.email.copyWith(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          Text(
            'You Answered $score out of ${questions.length} correctly.',
            style: LightAppStyle.email.copyWith(
                color: ColorsManger.newSecondaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: 350.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManger.newSecondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Confirm Submission',
                  style: LightAppStyle.email.copyWith(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ]));
  }
}
