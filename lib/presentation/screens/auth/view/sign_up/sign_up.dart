import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../config/styles/light_app_style.dart';
import '../../../../../core/assets_manager.dart';
import '../../../../../core/colors_manager.dart';
import '../../../../../core/routes_manger.dart';
import '../../../../../core/strings_manager.dart';
import '../../widgets/custom_txt_field.dart';
import '../login/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isRememberMeChecked = false;
  bool isAgreeChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.newWhite,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 100.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create Account',
                style: LightAppStyle.login.copyWith(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.w),
              SvgPicture.asset(
                AssetsManager.svgLogo,
                width: 25.w,
                height: 25.h,
              )
            ],
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  StringsManger.createAccount,
                  style: LightAppStyle.login,
                  textAlign: TextAlign.center,
                ),
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
                SizedBox(height: 25.h),
                CustomTxtField(
                  title: 'Re-enter your password',
                  label: 'Confirm Password',
                  validator: (String? value) => null,
                  controller: confirmPasswordController,
                  icon: CupertinoIcons.lock,
                ),
                SizedBox(height: 28.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManger.newSecondaryColor,
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
                  child: Padding(
                    padding: REdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      StringsManger.signedUp,
                      style:
                          LightAppStyle.loggedIn.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.red,width: 0)
                        ),
                        checkColor: Colors.white,
                        value: isRememberMeChecked,
                        onChanged: (value) =>
                            setState(() => isRememberMeChecked = value!),
                        activeColor: ColorsManger.newSecondaryColor,
                      ),
                    ),
                    Text(
                      'Remember me',
                      style: LightAppStyle.email.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.red,width: 0)
                        ),
                        checkColor: Colors.white,
                        value: isAgreeChecked,
                        onChanged: (value) =>
                            setState(() => isAgreeChecked = value!),
                        activeColor: ColorsManger.newSecondaryColor,
                      ),
                    ),
                    Text(
                      'Agree with ',
                      style: LightAppStyle.email.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      'Terms & Conditions',
                      style: LightAppStyle.email.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorsManger.newSecondaryColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
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
                SizedBox(height: 5.h),
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
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: LightAppStyle.email.copyWith(fontSize: 14,color: Colors.black),
              ),
              SizedBox(width: 5.w),
              InkWell(
                onTap: () => Navigator.pushReplacementNamed(
                    context, RoutesManger.login),
                child: Text(
                  'Login',
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
    );
  }
}
