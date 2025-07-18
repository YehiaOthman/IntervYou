import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import '../../../../../../config/styles/light_app_style.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    required this.icon1,
    required this.title,
    required this.icon2,
  });

  final IconData? icon1;
  final String? title;
  final IconData? icon2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Icon(
            icon1,
            color: ColorsManger.newSecondaryColor,
            size: 30.sp,
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Text(
              title ?? '',
              style: LightAppStyle.email.copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Icon(
            icon2,
            color: Colors.grey,
            size: 22.sp,
          ),
        ],
      ),
    );
  }
}