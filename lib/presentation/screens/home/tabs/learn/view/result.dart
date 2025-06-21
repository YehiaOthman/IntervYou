import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/presentation/screens/home/home.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/data/models/SubmitQuizResponse.dart';

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.quizResult,
  });

  final submitQuizResponse quizResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsManger.newWhite,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              Container(
                  width: 140.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    color: quizResult.isPassed ? ColorsManger.newSecondaryColor : Colors.redAccent,
                    borderRadius: BorderRadius.circular(75.r),
                  ),
                  child: Icon(
                    quizResult.isPassed ? Icons.check : Icons.close_rounded,
                    color: Colors.white,
                    size: 110.sp,
                  )),
              SizedBox(height: 20.h),
              Text(
                quizResult.isPassed ? 'Quiz Completed!' : 'Quiz Failed',
                style: LightAppStyle.email.copyWith(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'You Answered ${quizResult.correctAnswers} out of ${quizResult.totalQuestions} correctly.',
                  style: LightAppStyle.email.copyWith(
                      color: ColorsManger.newSecondaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Your Score: ${quizResult.scorePercentage}%',
                style: LightAppStyle.email.copyWith(
                    color: ColorsManger.newSecondaryColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.h),
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
                    padding: REdgeInsets.all(12),
                    child: Text(
                      'Back to Home',
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