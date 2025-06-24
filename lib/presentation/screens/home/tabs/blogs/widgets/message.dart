import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';

import '../../../../../../config/styles/light_app_style.dart';

class Message extends StatelessWidget {
  Message({super.key, required this.isSentByMe});

  bool isSentByMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 250.w),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isSentByMe?ColorsManger.newSecondaryColor.withOpacity(0.4): ColorsManger.newSecondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: isSentByMe ?Radius.circular(0): Radius.circular(25),
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          topRight: isSentByMe ?Radius.circular(25): Radius.circular(0),
        ),
      ),
      child: Text(
        'Not yet , I’m almost doneI just need to double-check the numbers',
        style: LightAppStyle.email.copyWith(
            color: isSentByMe?Colors.black:Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400

        ),
        textWidthBasis: TextWidthBasis.longestLine,
      ),
    );
  }
}
