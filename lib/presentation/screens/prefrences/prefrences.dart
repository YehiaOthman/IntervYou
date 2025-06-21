import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.newWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 25.h,),
          Text('Preferences',textAlign: TextAlign.center, style: LightAppStyle.email.copyWith(
            color: Colors.black,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold
          ),)
        ],
      ),
    );
  }
}
