import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class PendingCardItem extends StatefulWidget {
  const PendingCardItem({super.key});

  @override
  State<PendingCardItem> createState() => _PendingCardItemState();
}

class _PendingCardItemState extends State<PendingCardItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            child: Image.asset(AssetsManager.pp, width: 55.w, height: 55.h)),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yehia Othman',
              style: LightAppStyle.email.copyWith(
                  color: Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'UI/UX Designer',
              style: LightAppStyle.email.copyWith(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () => print('Accept'),
          child: Container(
            padding: REdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManger.newSecondaryColor
            ),
            child: Icon(Icons.check, color: Colors.white, size: 28.sp,),
          ),
        ),
        SizedBox(width: 10.w),
        InkWell(
          onTap: () => print('Remove'),
          child: Container(
            padding: REdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: ColorsManger.newSecondaryColor, width: 1.5)
            ),
            child: Icon(Icons.close, color: ColorsManger.newSecondaryColor, size: 28.sp,),
          ),
        ),
      ],
    );;
  }
}
