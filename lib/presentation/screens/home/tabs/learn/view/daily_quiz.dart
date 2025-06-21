import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/presentation/screens/home/home.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view/result.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/widget/answer_item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/widget/next_btn.dart';
import 'package:intervyou_app/data/models/SubmitQuizResponse.dart';
import '../../../../../../data/api_manager.dart';
import '../../../../../../data/models/DailyQuiz.dart';

class DailyQuiz extends StatefulWidget {
  const DailyQuiz({super.key});

  @override
  State<DailyQuiz> createState() => _DailyQuizState();
}

class _DailyQuizState extends State<DailyQuiz> {
  late int _subTopicId;
  String? _subTopicName;

  List<DailyQuizzes> _questions = [];
  bool _isLoading = true;
  String? _errorMessage;
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndexForUi;
  Map<String, int> _answers = {};
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is int) {
        _subTopicId = arguments;
      } else if (arguments is Map<String, dynamic>) {
        _subTopicId = arguments['subTopicId'] as int;
        _subTopicName = arguments['subTopicName'] as String?;
      } else {
        _subTopicId = 0;
        if (mounted) {
          setState(() {
            _errorMessage = "SubTopic ID not provided or invalid.";
            _isLoading = false;
          });
        }
        _isInitialized = true;
        return;
      }
      _fetchQuizData();
      _isInitialized = true;
    }
  }

  Future<void> _fetchQuizData() async {
    if (_subTopicId == 0 && _errorMessage != null) return;

    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }
    try {
      final questions = await ApiManger.getQuiz(_subTopicId);
      if (mounted) {
        if (questions != null && questions.isNotEmpty) {
          setState(() {
            _questions = questions;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = "Failed to load quiz questions or quiz is empty.";
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage =
              "An error occurred while fetching quiz: ${e.toString()}";
          _isLoading = false;
        });
      }
    }
  }

  void _pickAnswer(int optionIndex, int questionId, int optionId) {
    if (mounted) {
      setState(() {
        _selectedOptionIndexForUi = optionIndex;
        _answers[questionId.toString()] = optionId;
      });
    }
  }

  void _goToNextQuestionOrSubmit() async {
    if (!mounted) return;

    if (_questions.isNotEmpty &&
        _currentQuestionIndex < _questions.length &&
        (_questions[_currentQuestionIndex].options?.isNotEmpty ?? false) &&
        _selectedOptionIndexForUi == null) {
      return;
    }

    bool isLastQuestion = _currentQuestionIndex == _questions.length - 1;

    if (isLastQuestion) {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      try {
        final submitQuizResponse? result =
            await ApiManger.submitQuizAnswers(_subTopicId, _answers);

        if (!mounted) return;

        if (result != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => Result(quizResult: result),
            ),
          );
        } else {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to submit quiz. API returned no result.')),
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error submitting quiz: ${e.toString()}')),
          );
        }
      }
    } else {
      if (_currentQuestionIndex < _questions.length - 1) {
        if (mounted) {
          setState(() {
            _currentQuestionIndex++;
            _selectedOptionIndexForUi = null;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized && _isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        body: Center(
            child: CircularProgressIndicator(
                color: ColorsManger.newSecondaryColor)),
      );
    }

    if (_isLoading && _questions.isEmpty && _errorMessage == null) {
      return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        body: Center(
            child: CircularProgressIndicator(
                color: ColorsManger.newSecondaryColor)),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        appBar: AppBar(
          backgroundColor: ColorsManger.newSecondaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(_subTopicName ?? "Quiz",
              style: TextStyle(color: Colors.white)),
        ),
        body: Center(
          child: Padding(
            padding: REdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _errorMessage!,
                  style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                if (_subTopicId != 0 &&
                    _errorMessage != "SubTopic ID not provided or invalid.")
                  ElevatedButton(
                    onPressed: _fetchQuizData,
                    child: Text("Retry"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManger.newSecondaryColor,
                        foregroundColor: Colors.white),
                  )
              ],
            ),
          ),
        ),
      );
    }

    if (_questions.isEmpty && !_isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        appBar: AppBar(
          backgroundColor: ColorsManger.newSecondaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(_subTopicName ?? "Quiz",
              style: TextStyle(color: Colors.white)),
        ),
        body: Center(
            child: Padding(
          padding: REdgeInsets.all(20.0),
          child: Text("No questions available for this quiz.",
              style: TextStyle(fontSize: 16.sp), textAlign: TextAlign.center),
        )),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    bool isLastQuestion = _currentQuestionIndex == _questions.length - 1;

    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                  color: ColorsManger.newSecondaryColor,
                ),
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Text('Quiz',
                              style: LightAppStyle.email.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                           Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                  (route) => false,
                                );
                              }
                            },
                            child: Icon(Icons.close,
                                color: Colors.white, size: 35.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(_subTopicName ?? 'Questions',
                          style: LightAppStyle.email.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.white)),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: (_questions.isNotEmpty
                                  ? (_currentQuestionIndex + 1) /
                                      _questions.length
                                  : 0),
                              color: ColorsManger.newSecondaryColor
                                  .withOpacity(0.5),
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
                        padding: REdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Text(
                          currentQuestion.text ?? "No question text",
                          style: LightAppStyle.email.copyWith(
                              fontSize: 18.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              if (_isLoading && isLastQuestion)
                Padding(
                    padding: REdgeInsets.symmetric(vertical: 20.h),
                    child: CircularProgressIndicator(
                        color: ColorsManger.newSecondaryColor))
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: currentQuestion.options?.length ?? 0,
                  itemBuilder: (context, index) {
                    final option = currentQuestion.options![index];
                    return GestureDetector(
                      onTap: (_selectedOptionIndexForUi == null &&
                              !(_isLoading && isLastQuestion))
                          ? () => _pickAnswer(
                              index,
                              currentQuestion.quizQuestionId!.toInt(),
                              option.quizOptionId!.toInt())
                          : null,
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 20),
                        child: AnswerCard(
                          questionText: option.text ?? "No option text",
                          isSelected: _selectedOptionIndexForUi == index,
                        ),
                      ),
                    );
                  },
                ),
              SizedBox(height: 30.h),
              if (!(_isLoading && isLastQuestion))
                if (_questions.isNotEmpty)
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 20),
                    child: RectangularButton(
                      onPressed: (_selectedOptionIndexForUi != null ||
                              (currentQuestion.options?.isEmpty ?? true))
                          ? _goToNextQuestionOrSubmit
                          : null,
                      label: isLastQuestion ? 'Finish' : 'Next Question',
                    ),
                  ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
