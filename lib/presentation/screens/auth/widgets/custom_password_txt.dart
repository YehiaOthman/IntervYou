import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';

class CustomPasswordTxt extends StatefulWidget {
  CustomPasswordTxt({
    super.key,
    required this.label,
    required this.title,
    required this.validator,
    required this.controller,
    required this.icon,
  });

  final String label;
  final String title;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final IconData icon;

  @override
  State<CustomPasswordTxt> createState() => _CustomPasswordTxtState();
}

class _CustomPasswordTxtState extends State<CustomPasswordTxt> {
  bool _isObscured = true;

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: TextFormField(
            obscureText: _isObscured,
            style: LightAppStyle.email.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
            cursorColor: ColorsManger.secondaryColor,
            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              prefixIcon: Icon(
                widget.icon,
                color: Colors.black.withOpacity(0.3),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black.withOpacity(0.5),
                ),
                onPressed: _toggleVisibility,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.3), width: 2.w),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.3), width: 2.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.3), width: 2.w),
              ),
              hintText: widget.title,
              hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.3), width: 2.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}