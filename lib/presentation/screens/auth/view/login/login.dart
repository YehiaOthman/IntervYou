import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/assets_manager.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/core/strings_manager.dart';
import '../../widgets/custom_txt_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.newWhite,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 100.h),
          Text(
            'Login to your Account',
            style: LightAppStyle.login.copyWith(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Padding(
              padding:  REdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 25.h),
                  CustomTxtField(
                    title: 'Enter your username e-mail',
                    label: 'Email',
                    validator: (String? value) => null,
                    controller: emailController,
                    icon: Icons.email_outlined,
                  ),
                  SizedBox(height: 25.h),
                  CustomTxtField(
                    title: 'Enter your password',
                    label: 'Password',
                    validator: (String? value) => null,
                    controller: passwordController,
                    icon: CupertinoIcons.lock,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, RoutesManger.otp),
                        child: Text(
                          StringsManger.forgotPassword,
                          style: LightAppStyle.email.copyWith(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: isChecked,
                          inactiveThumbColor:
                              ColorsManger.newSecondaryColor,
                          activeColor: Colors.white,
                          activeTrackColor: ColorsManger.newSecondaryColor,
                          inactiveTrackColor:
                              ColorsManger.txtFillColor.withOpacity(0.2),
                          onChanged: (value) {
                            setState(() {
                              isChecked = value;
                            });
                          },
                        ),
                      ),
                      Text(
                        StringsManger.rememberMe,
                        style: LightAppStyle.email.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 15.5.sp,                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManger.newSecondaryColor,
                      fixedSize: Size(500.w, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, RoutesManger.home),
                    child: Text(
                      StringsManger.loggedIn,
                      style: LightAppStyle.loggedIn.copyWith(
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 28.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: ColorsManger.newSecondaryColor.withOpacity(0.3),
                        width: 135,
                        height: 1,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'OR',
                        style: LightAppStyle.email.copyWith(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        color: ColorsManger.newSecondaryColor.withOpacity(0.3),
                        width: 135,
                        height: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => print('Navigate to facebook'),
                        child: Image.asset(AssetsManager.facebook),
                      ),
                      SizedBox(width: 16.w),
                      GestureDetector(
                        onTap: () => print('Navigate to google'),
                        child: Image.asset(AssetsManager.chrome),
                      ),
                      SizedBox(width: 16.w),
                      GestureDetector(
                        onTap: () => print('Navigate to linkedin'),
                        child: Image.asset(AssetsManager.linkedin),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account ?',
                        style: LightAppStyle.email.copyWith(fontSize: 14,color: Colors.black),
                      ),
                      SizedBox(width: 5.w),
                      InkWell(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, RoutesManger.signup),
                        child: Text(
                          'Sign up',
                          style: LightAppStyle.email.copyWith(
                            fontSize: 14,
                            color: ColorsManger.newSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
