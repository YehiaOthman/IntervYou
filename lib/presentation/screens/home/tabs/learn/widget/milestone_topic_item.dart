import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view_model/learn_provider.dart';
import 'package:provider/provider.dart';

class MilestoneTopicItem extends StatelessWidget {
  final int index;
  final String learnPoint;
  final num status;
  final num id;

  const MilestoneTopicItem({
    super.key,
    required this.index,
    required this.learnPoint,
    required this.status,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDone = status == 2;
    final viewModel = Provider.of<LearnViewModel>(context, listen: false);

    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 20.w),
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.r)),
        color: isDone
            ? ColorsManger.newSecondaryColor.withOpacity(0.5)
            : ColorsManger.newSecondaryColor.withOpacity(0.1),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          child: Row(
            children: [
              SizedBox(width: 10.w),
              Text(
                index < 10 ? '0$index' : index.toString(),
                style: LightAppStyle.email.copyWith(
                  color: isDone ? Colors.white : Colors.white.withOpacity(0.8),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  learnPoint,
                  textAlign: TextAlign.center,
                  style: LightAppStyle.email.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color:
                    isDone ? Colors.white : Colors.white.withOpacity(0.8),
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  viewModel.updateLearningPointStatus(id);
                },
                child: Container(
                  height: 25.h,
                  width: 25.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: isDone
                          ? Colors.transparent
                          : ColorsManger.newSecondaryColor.withOpacity(0.5),
                      width: isDone ? 0 : 1.w,
                    ),
                    color: isDone
                        ? ColorsManger.newSecondaryColor.withOpacity(0.5)
                        : Colors.transparent,
                  ),
                  child: isDone
                      ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20.sp,
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
}