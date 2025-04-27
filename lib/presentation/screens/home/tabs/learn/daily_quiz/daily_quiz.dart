import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/presentation/screens/home/home.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/daily_quiz/result.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/daily_quiz/widget/answer_item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/daily_quiz/widget/next_btn.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view/learn.dart';

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

    return Scaffold(
          backgroundColor: Color(0xFFF0F0F0),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorsManger.newSecondaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Padding(
                      padding:  REdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Text('Quiz 1', style: LightAppStyle.email.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                color: Colors.white
                              )),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                        (route) => false,
                                  );
                                },
                                child: Icon(Icons.close, color: Colors.white, size: 35.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text('Widgets Types',
                              style: LightAppStyle.email.copyWith(
                                  fontSize: 18.sp, fontWeight: FontWeight.normal,
                                color: Colors.white)),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: (questionIndex + 1) / questions.length,
                                  color: ColorsManger.newSecondaryColor.withOpacity(0.5),
                                  backgroundColor: Colors.white,
                                  minHeight: 10.h,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                children: [
                                  Icon(Icons.access_time_outlined,
                                      color: Colors.white, size: 25.sp),
                                  Text(
                                    '10:00',
                                    style: LightAppStyle.email.copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Container(
                            width: double.infinity,
                            padding:  REdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color:  Colors.white,

                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              question.question,
                              style: LightAppStyle.email.copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 60.h),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: selectedAnswerIndex == null
                            ? () => pickAnswer(index)
                            : null,
                        child: Padding(
                          padding:  REdgeInsets.symmetric(horizontal: 20),
                          child: AnswerCard(
                            currentIndex: index,
                            question: question.options[index],
                            isSelected: selectedAnswerIndex == index,
                            selectedAnswerIndex: selectedAnswerIndex,
                            correctAnswerIndex: question.correctAnswerIndex,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30.h),
                  RectangularButton(
                    onPressed: selectedAnswerIndex != null
                        ? () {
                      if (isLastQuestion) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => Result(score: score),
                          ),
                        );
                      } else {
                        goToNextQuestion();
                      }
                    }
                        : null,
                    label: isLastQuestion ? 'Finish' : 'Next Question',
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        );

  }

}
