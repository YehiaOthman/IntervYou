import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/colors_manager.dart';
import '../../../../../../core/routes_manger.dart';

class MilestoneItemWidget extends StatefulWidget {
  const MilestoneItemWidget({super.key});

  @override
  State<MilestoneItemWidget> createState() => _MilestoneItemWidgetState();
}

class _MilestoneItemWidgetState extends State<MilestoneItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365.w,
      decoration: BoxDecoration(
        color: ColorsManger.semiBlack,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today’s milestones',
              style: LightAppStyle.email,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesManger.milestoneTopic);
                    },
                    child: milestoneCard(ColorsManger.secondaryColor)),
                SizedBox(width: 10.w),
                milestoneCard(ColorsManger.pink),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                milestoneCard(ColorsManger.blue),
                SizedBox(width: 10.w),
                milestoneCard(ColorsManger.yellow),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Edit goals',
                  style: LightAppStyle.email.copyWith(
                      color: ColorsManger.secondaryColor,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Widget milestoneCard(Color color) {
  return Stack(children: [
    Container(
        height: 110.h,
        width: 155.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          border: Border.all(color: color, width: 2.5.w),
          borderRadius: BorderRadius.circular(25.r),
        )),
    Container(
      height: 110.h,
      width: 155.w,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        border: Border.all(color: color, width: 2.w),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 15.w,
              ),
              Text(
                '7',
                style: LightAppStyle.email.copyWith(
                    color: ColorsManger.semiBlack,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '/14',
                style: LightAppStyle.email.copyWith(
                    color: ColorsManger.semiBlack.withOpacity(0.4),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Arrays',
              style: LightAppStyle.email.copyWith(
                  color: ColorsManger.semiBlack,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    ),
  ]);
}
