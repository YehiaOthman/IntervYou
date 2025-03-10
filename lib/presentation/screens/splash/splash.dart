import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/assets_manager.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/core/strings_manager.dart';

import '../../../config/styles/light_app_style.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RoutesManger.login);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Image.asset(AssetsManager.logo, width: 300.w),
          ),
          Center(
            child: Text(
              StringsManger.splash,
              style: LightAppStyle.splash,
            ),
          ),
          Spacer(),

          Center(
            child: Text(
              StringsManger.splashBottom,
              style: LightAppStyle.splashBottom,
            ),
          ),
        ],
      ),
    );
  }
}
