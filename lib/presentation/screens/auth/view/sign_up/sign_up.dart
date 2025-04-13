import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          SizedBox(height: 100.h),
          Image.asset(
            AssetsManager.logo,
            width: 250.w,
            height: 60.h,
          ),
          SizedBox(height: 40.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManger.semiBlack.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r),
                ),
              ),
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 30.h),
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
                          backgroundColor: ColorsManger.secondaryColor,
                          fixedSize: Size(500.w, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login()),
                                  (route) => false);
                        },
                        child: Text(
                          StringsManger.signedUp,
                          style: LightAppStyle.loggedIn,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: 1.4,
                            child: Checkbox(
                              checkColor: Colors.black,
                              value: isRememberMeChecked,
                              onChanged: (value) =>
                                  setState(() => isRememberMeChecked = value!),
                              activeColor: ColorsManger.secondaryColor,
                            ),
                          ),
                          Text(
                            'Remember me',
                            style: LightAppStyle.email.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: 1.4,
                            child: Checkbox(
                              checkColor: Colors.black,
                              value: isAgreeChecked,
                              onChanged: (value) =>
                                  setState(() => isAgreeChecked = value!),
                              activeColor: ColorsManger.secondaryColor,
                            ),
                          ),
                          Text(
                            'Agree with ',
                            style: LightAppStyle.email.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            'Terms & Conditions',
                            style: LightAppStyle.email.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: ColorsManger.secondaryColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: ColorsManger.primaryColor,
                            width: 135,
                            height: 1,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'OR',
                            style: LightAppStyle.email.copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            color: ColorsManger.primaryColor,
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
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: LightAppStyle.email.copyWith(fontSize: 14),
                          ),
                          SizedBox(width: 5.w),
                          InkWell(
                            onTap: () => Navigator.pushReplacementNamed(context, RoutesManger.login),
                            child: Text(
                              'Login',
                              style: LightAppStyle.email.copyWith(
                                fontSize: 14,
                                color: ColorsManger.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
