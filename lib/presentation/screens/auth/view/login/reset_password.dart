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
      backgroundColor: ColorsManger.newWhite,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:  REdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 35.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: ColorsManger.newSecondaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              StringsManger.resetPassword,
              style: LightAppStyle.login.copyWith(
                  fontSize: 24.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.h),
            Text(
              StringsManger.passwordConditions,
              style: LightAppStyle.login.copyWith(
                  fontSize: 13.sp,
                  color: Colors.black .withOpacity(0.3),
                  fontWeight: FontWeight.bold
              ),
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
            // SizedBox(height: 20.h),
            // FlutterPwValidator(
            //   uppercaseCharCount: 3,
            //   numericCharCount: 3,
            //   specialCharCount: 3,
            //   width: MediaQuery.of(context).size.width.w,
            //   height: 170.h,
            //   minLength: 8,
            //   onSuccess: () => print('success'),
            //   controller: passwordController,
            // ),
            SizedBox(height: 50.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManger.newSecondaryColor,
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
                style: LightAppStyle.loggedIn.copyWith(
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
