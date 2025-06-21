import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.questionText,
    required this.isSelected,
  });

  final String questionText;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Container(
        padding: REdgeInsets.all(25.0),
        decoration: BoxDecoration(
            color: isSelected ? ColorsManger.newSecondaryColor.withOpacity(0.7) : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: isSelected ? Border.all(color: ColorsManger.newSecondaryColor, width: 2) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset:  Offset(0, 3),
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              child: Text(
                questionText,
                style: LightAppStyle.email.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}