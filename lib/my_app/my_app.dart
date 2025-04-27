import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/theme/my_theme.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/auth/view/login/login.dart';
import 'package:intervyou_app/presentation/screens/auth/view/login/reset_password.dart';
import 'package:intervyou_app/presentation/screens/auth/view/sign_up/sign_up.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/blogs.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/daily_quiz/daily_quiz.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view/learn.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/milestone_details/milestone_details.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/profile/profile.dart';
import 'package:intervyou_app/presentation/screens/splash/splash.dart';
import '../presentation/screens/auth/view/otp/otp.dart';
import '../presentation/screens/home/home.dart';
import '../presentation/screens/home/tabs/learn/road_map/road_map.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412,870),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: MyTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          RoutesManger.home: (_) =>  Home(),
          RoutesManger.splash:(_)=> Splash(),
          RoutesManger.blogs:(_)=> Blogs(),
          RoutesManger.learn:(_)=> Learn(),
          RoutesManger.profile:(_)=> Profile(),
          RoutesManger.login:(_)=> Login(),
          RoutesManger.signup:(_)=> SignUp(),
          RoutesManger.otp:(_)=> Otp(),
          RoutesManger.resetPassword:(_)=> ResetPassword(),
          RoutesManger.quiz:(_)=> DailyQuiz(),
          RoutesManger.milestoneTopic:(_)=> MilestoneDetails(),
          RoutesManger.roadMap:(_)=> RoadMap(),
        },
        initialRoute: RoutesManger.splash,
      ),
    );
  }
}
