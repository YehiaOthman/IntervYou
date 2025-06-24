import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class ChatUserItem extends StatefulWidget {
  const ChatUserItem({super.key});

  @override
  State<ChatUserItem> createState() => _ChatUserItemState();
}

class _ChatUserItemState extends State<ChatUserItem> {
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
            Row(
              children: [
                Icon(Icons.circle, color: ColorsManger.newSecondaryColor, size: 10.sp),
                SizedBox(width: 5.w),
                Text(
                  'Yehia sent a message',
                  style: LightAppStyle.email.copyWith(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

              ],
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            Text('Jan 10',
              style: LightAppStyle.email.copyWith(color: Colors.black.withOpacity(0.5), fontSize: 13.sp, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),
            Container(
              padding: REdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green
              ),
              child: Text('4', style: LightAppStyle.email.copyWith(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),
            )
        ],)
      ],
    );
  }
}
