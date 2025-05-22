import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/api_manager.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/colors_manager.dart';

class MilestoneTopicItem extends StatefulWidget {
  final int index;
  final String learnPoint;
  num status;
  final num id;

   MilestoneTopicItem(
      {super.key,
      required this.index,
      required this.learnPoint,
      required this.status, required this.id});

  @override
  State<MilestoneTopicItem> createState() => _MilestoneTopicItemState();
}

class _MilestoneTopicItemState extends State<MilestoneTopicItem> {
  late bool flag;

  @override
  void initState() {
    isPointDone();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 20.w),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.r)),
        color: flag
            ? ColorsManger.newSecondaryColor.withOpacity(0.5)
            : ColorsManger.newSecondaryColor.withOpacity(0.1),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10.w),
              Text(
                widget.index < 10
                    ? '0${widget.index}'
                    : widget.index.toString(),
                style: LightAppStyle.email.copyWith(
                  color: flag ? Colors.white : Colors.white.withOpacity(0.8),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Wrap(
                  children: [
                    Center(
                      child: Text(
                        widget.learnPoint,
                        textAlign: TextAlign.center,
                        style: LightAppStyle.email.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: flag
                              ? Colors.white
                              : Colors.white.withOpacity(0.8),
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  setState(() {
                    changePointProgress();
                    flag = !flag;
                  });
                },
                child: Container(
                  height: 25.h,
                  width: 25.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: flag
                          ? Colors.transparent
                          : ColorsManger.newSecondaryColor.withOpacity(0.5),
                      width: flag ? 0 : 1.w,
                    ),
                    color: flag
                        ? ColorsManger.newSecondaryColor.withOpacity(0.5)
                        : Colors.transparent,
                  ),
                  child: flag
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20.sp, // Responsive icon size
                        )
                      : null,
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }
  void isPointDone() {
    if (widget.status == 2) {
      flag = true;
    } else {
      flag = false;
    }
  }
  void changePointProgress() {
    if(widget.status == 2) {
      widget.status = 1;
      ApiManger.updateLearningPointProgress(widget.id, widget.status);
    }else {
      widget.status = 2;
      ApiManger.updateLearningPointProgress(widget.id, widget.status);
    }
  }
}
