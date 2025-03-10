import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../../config/styles/light_app_style.dart';
import '../../../../../core/assets_manager.dart';
import '../../../../../core/colors_manager.dart';
import '../../../../../core/routes_manger.dart';
import '../../../../../core/strings_manager.dart';
import '../../widgets/custom_txt_field.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 20),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: ColorsManger.secondaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(Icons.arrow_back, color: Colors.black,),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              AssetsManager.logoV2,
              width: 170.w,
              height: 60.h,
            ),
          ),
          SizedBox(height: 40.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManger.semiBlack.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      StringsManger.verifyCode,
                      style: LightAppStyle.login,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      StringsManger.otpMail,
                      style: LightAppStyle.login.copyWith(fontSize: 10.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25.h),
                    Pinput(
                      focusedPinTheme: PinTheme(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: ColorsManger.semiBlack,
                          border: Border.all(color: ColorsManger.secondaryColor,
                              width: 2.w),

                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      length: 4,
                      defaultPinTheme: PinTheme(
                        width: 50.w,
                        height: 50.h,
                        textStyle: LightAppStyle.email,
                        decoration: BoxDecoration(
                          color: ColorsManger.semiBlack,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      separatorBuilder: (index) => SizedBox(width: 20.w),
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      StringsManger.otpTimer,
                      style: LightAppStyle.login.copyWith(
                          fontSize: 13.sp, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManger.secondaryColor,
                        fixedSize: Size(500.w, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () =>Navigator.pushNamed(context, RoutesManger.resetPassword),
                      child: Text(
                        StringsManger.verify,
                        style: LightAppStyle.loggedIn,
                      ),
                    ),
                    SizedBox(height: 35.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManger.semiBlack.withOpacity(
                            0.8),
                        fixedSize: Size(500.w, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(color: ColorsManger.secondaryColor,
                              width: 2.w),
                        ),
                      ),
                      onPressed: () => print('done'),
                      child: Text(
                        StringsManger.sendAgain,
                        style: LightAppStyle.loggedIn.copyWith(
                            color: ColorsManger.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
