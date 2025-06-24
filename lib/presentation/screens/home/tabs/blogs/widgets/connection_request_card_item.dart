import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class ConnectionRequestCardItem extends StatefulWidget {
   ConnectionRequestCardItem({super.key, required this.action});

  @override
  State<ConnectionRequestCardItem> createState() => _ConnectionRequestCardItemState();
  String action;
}

class _ConnectionRequestCardItemState extends State<ConnectionRequestCardItem> {
  bool isSend = false;

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
          onTap: () => WidgetsBinding.instance.addPostFrameCallback(
            (_) => setState(() => isSend = !isSend),
          ),
          child: Container(
            padding: REdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSend
                  ? ColorsManger.newSecondaryColor.withOpacity(0.2)
                  : ColorsManger.newSecondaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              widget.action,
              style: LightAppStyle.email.copyWith(
                  color: isSend ? Colors.black : Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w300),
            ),
          ),
        )
      ],
    );
  }
}
