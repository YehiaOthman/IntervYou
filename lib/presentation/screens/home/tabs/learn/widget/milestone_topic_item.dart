import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/colors_manager.dart';

class MilestoneTopicItem extends StatefulWidget {
   MilestoneTopicItem({super.key,
    required this.index
  });

  @override
  State<MilestoneTopicItem> createState() => _MilestoneTopicItemState();
  int index;
}

class _MilestoneTopicItemState extends State<MilestoneTopicItem> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.r)),
        color: flag ? ColorsManger.secondaryColor.withOpacity(0.2) : ColorsManger.semiBlack.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text( widget.index < 10
                  ? '0${widget.index}'
                  : widget.index.toString(),
        style: LightAppStyle.email.copyWith(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold), ),
              Text('Introduction to Arrays', style: LightAppStyle.email.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal

              )),
              InkWell(
                onTap: (){setState(() {flag = !flag;});},
                child: Container(
                  height: 25.h,
                  width: 25.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: ColorsManger.secondaryColor.withOpacity(0.2)
                  ),
                  child: flag ? Icon(Icons.check,color: ColorsManger.secondaryColor,) : null,
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
