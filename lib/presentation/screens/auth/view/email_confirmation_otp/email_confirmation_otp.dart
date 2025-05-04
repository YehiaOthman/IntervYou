import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/handler_functions.dart';
import 'package:pinput/pinput.dart';
import '../../../../../config/styles/light_app_style.dart';
import '../../../../../core/colors_manager.dart';
import '../../../../../core/strings_manager.dart';

class EmailConfirmationOtp extends StatefulWidget {
  const EmailConfirmationOtp({super.key});

  @override
  State<EmailConfirmationOtp> createState() => _EmailConfirmationOtpState();
}

class _EmailConfirmationOtpState extends State<EmailConfirmationOtp> {
  late String email = "";
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: ColorsManger.newWhite,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:  REdgeInsets.symmetric(horizontal: 20.0),
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
              StringsManger.verifyCode,
              style: LightAppStyle.login.copyWith(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              StringsManger.otpMail,
              style: LightAppStyle.login.copyWith(
                  fontSize: 12.sp,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            Text(
              email,
              style: LightAppStyle.login.copyWith(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.h),
            Pinput(
              controller: otpController,
              focusedPinTheme: PinTheme(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: ColorsManger.newSecondaryColor, width: 2.w),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              length: 6,
              defaultPinTheme: PinTheme(
                width: 50.w,
                height: 50.h,
                textStyle: LightAppStyle.login.copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorsManger.newSecondaryColor.withOpacity(0.5), width: 3.w),

                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              separatorBuilder: (index) => SizedBox(width: 20.w),
            ),
            SizedBox(height: 25.h),
            Text(
              StringsManger.otpTimer,
              style: LightAppStyle.login
                  .copyWith(fontSize: 13.sp, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
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
              onPressed: () {
               if(otpController.text.isEmpty) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Please enter otp')),
                 );
               } else {
                 HandlerFunctions.handleEmailConfirmation(context, email, otpController.text);
               }
              },
              child: Text(
                StringsManger.verify,
                style: LightAppStyle.loggedIn.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 35.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: Size(500.w, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                      color: ColorsManger.newSecondaryColor, width: 2.w),
                ),
              ),
              onPressed: () {
              setState(() {
                HandlerFunctions.handleResendEmailConfirmationOtp(context, email);
              });
              },
              child: Text(
                StringsManger.sendAgain,
                style: LightAppStyle.loggedIn
                    .copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
