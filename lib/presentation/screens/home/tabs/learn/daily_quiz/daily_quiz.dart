import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/presentation/screens/home/home.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/daily_quiz/result.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/daily_quiz/widget/answer_item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/daily_quiz/widget/next_btn.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/learn.dart';

import '../../../../../../core/assets_manager.dart';
import 'models/questions.dart';

class DailyQuiz extends StatefulWidget {
  const DailyQuiz({super.key});

  @override
  State<DailyQuiz> createState() => _DailyQuizState();
}

class _DailyQuizState extends State<DailyQuiz> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];
    bool isLastQuestion = questionIndex == questions.length - 1;

    return Stack(
      children: [
        Container(color: Colors.black),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 320.h,
          child: Container(
            decoration: BoxDecoration(
                color: ColorsManger.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r),
                )),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(height: 35.h),
              Row(
                children: [
                Text('Quiz 1', style: LightAppStyle.email,
                textAlign: TextAlign.center,),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => Home()),
                        (route) => false);
                  },
                  child: Icon(Icons.close, color: Colors.black, size: 35.sp)),
          ],
        ),
        Text('Widgets Types',
            style: LightAppStyle.email.copyWith(
                fontSize: 18.sp, fontWeight: FontWeight.normal)),
        Row(
          children: [
            SizedBox(
              width: 260.w,
              child: LinearProgressIndicator(
                value: (questionIndex + 1) / questions.length,
                color: Colors.black,
                backgroundColor: Colors.white,
                minHeight: 10.h,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            Spacer(),
            Column(
              children: [
                Icon(Icons.access_time_outlined,
                    color: Colors.black, size: 25.sp),
                Text(
                  '10:00',
                  style: LightAppStyle.email.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 35.h),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            question.question,
            style: LightAppStyle.email.copyWith(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 50.h),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: question.options.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: selectedAnswerIndex == null
                    ? () => pickAnswer(index)
                    : null,
                child: AnswerCard(
                  currentIndex: index,
                  question: question.options[index],
                  isSelected: selectedAnswerIndex == index,
                  selectedAnswerIndex: selectedAnswerIndex,
                  correctAnswerIndex: question.correctAnswerIndex,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50.h),
          child: Center(
            child: SizedBox(
              child: isLastQuestion
                  ? RectangularButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => Result(score: score),
                    ),
                  );
                },
                label: 'Finish',
              )
                  : RectangularButton(

                onPressed: selectedAnswerIndex != null
                    ? goToNextQuestion
                    : null,
                label: 'Next Question',
              ),
            ),
          ),
        ),
      ],
    ),)
    ,
    )
    ,
    ]
    ,
    );
  }
}
