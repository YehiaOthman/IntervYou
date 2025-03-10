import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';

class CustomTxtField extends StatelessWidget {
  CustomTxtField(
      {super.key,
      required this.label,
      required this.title,
      required this.validator,
      required this.controller,
      required this.icon});

  String label;
  String title;
  FormFieldValidator<String> validator;
  TextEditingController controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: LightAppStyle.email.copyWith(fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: double.infinity,
          height: 50,
          child: TextFormField(
            style: LightAppStyle.email,
            cursorColor: ColorsManger.secondaryColor,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorsManger.txtFillColor.withOpacity(0.2),
              prefixIcon: Icon(
                icon,
                color: ColorsManger.txtFillColor.withOpacity(0.4),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: ColorsManger.secondaryColor,width: 2.w),
              ),
              hintText: title,
              hintStyle: TextStyle(
                  color: ColorsManger.txtFillColor.withOpacity(0.4),
                  fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
