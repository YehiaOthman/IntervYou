import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intervyou_app/core/colors_manager.dart';

class LightAppStyle {
  static  TextStyle splash = GoogleFonts.poppins(
    color: ColorsManger.primaryColor.withOpacity(0.7),
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
  );
  static  TextStyle splashBottom = GoogleFonts.poppins(
    color: ColorsManger.primaryColor,
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
  );
  static  TextStyle login = GoogleFonts.poppins(
    color: ColorsManger.primaryColor,
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
  );
  static  TextStyle loggedIn = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );
  static  TextStyle email = GoogleFonts.poppins(
    color: ColorsManger.primaryColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
}
