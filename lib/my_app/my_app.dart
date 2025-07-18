import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/theme/my_theme.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/auth/view/email_confirmation_otp/email_confirmation_otp.dart';
import 'package:intervyou_app/presentation/screens/auth/view/forgot_password_otp/forgot_password_otp.dart';
import 'package:intervyou_app/presentation/screens/auth/view/login/login.dart';
import 'package:intervyou_app/presentation/screens/auth/view/login/reset_password.dart';
import 'package:intervyou_app/presentation/screens/auth/view/sign_up/sign_up.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/add_post.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/blogs.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/chat.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/connections_list.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/invitations.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/post_details.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/user_info_profile.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/user_profile.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/home_tab/view/notifications_screen.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view/daily_quiz.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view/learn.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view/milestone_details.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/profile/profile.dart';
import 'package:intervyou_app/presentation/screens/prefrences/prefrences.dart';
import 'package:intervyou_app/presentation/screens/splash/splash.dart';
import '../presentation/screens/home/home.dart';
import '../presentation/screens/home/tabs/learn/view/road_map.dart';

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
          RoutesManger.forgotPasswordOtp:(_)=> ForgotPasswordOtp(),
          RoutesManger.resetPassword:(_)=> ResetPassword(),
          RoutesManger.quiz:(_)=> DailyQuiz(),
          RoutesManger.milestoneTopic:(_)=> MilestoneDetails(),
          RoutesManger.roadMap:(_)=> RoadMap(),
          RoutesManger.emailConfirmationOtp:(_)=> EmailConfirmationOtp(),
          RoutesManger.preferences:(_)=> Preferences(),
          RoutesManger.userInfoProfile:(_)=> UserInfoProfile(),
          RoutesManger.userProfile:(_)=> UserProfile(),
          RoutesManger.connectionsList:(_)=> ConnectionsList(),
          RoutesManger.addPost:(_)=> AddPost(),
          RoutesManger.postDetails:(_)=> PostDetails(),
          RoutesManger.invitations:(_)=> Invitations(),
          RoutesManger.chat:(_)=> Chat(),
          RoutesManger.notifications:(_)=> NotificationsScreen(),
        },
        initialRoute: RoutesManger.login ,
      ),
    );
  }
}
