import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/styles/light_app_style.dart';
import '../../../../../core/assets_manager.dart';
import '../../../../../core/colors_manager.dart';
import '../../../../../core/strings_manager.dart';
import '../../widgets/custom_txt_field.dart';
import 'login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

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
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
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
                      StringsManger.resetPassword,
                      style: LightAppStyle.login,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      StringsManger.passwordConditions,
                      style: LightAppStyle.login.copyWith(
                          fontSize: 12.sp,
                          color: ColorsManger.primaryColor.withOpacity(0.4)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    CustomTxtField(
                      title: 'Enter your password',
                      label: 'New Password',
                      validator: (String? value) => null,
                      controller: passwordController,
                      icon: CupertinoIcons.lock,
                    ),
                    SizedBox(height: 30.h),
                    CustomTxtField(
                      title: 'Re-Enter your Password ',
                      label: 'Confirm Password',
                      validator: (String? value) => null,
                      controller: passwordController,
                      icon: CupertinoIcons.lock,
                    ),
                    SizedBox(height: 20.h),
                    FlutterPwValidator(
                      uppercaseCharCount: 3,
                      numericCharCount: 3,
                      specialCharCount: 3,
                      width: MediaQuery.of(context).size.width.w,
                      height: 170.h,
                      minLength: 8,
                      onSuccess: () => print('success'),
                      controller: passwordController,
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
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                            (route) => false);
                      },
                      child: Text(
                        StringsManger.resetPassword,
                        style: LightAppStyle.loggedIn,
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
