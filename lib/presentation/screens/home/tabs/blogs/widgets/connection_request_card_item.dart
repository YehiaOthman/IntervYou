import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/api_manager.dart';
import 'package:intervyou_app/data/blogs_models/user_info_item.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class ConnectionRequestCardItem extends StatefulWidget {
   ConnectionRequestCardItem({super.key, required this.userInfo});

  @override
  State<ConnectionRequestCardItem> createState() => _ConnectionRequestCardItemState();
  UserInfoItem userInfo;

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
            borderRadius: BorderRadius.circular(50.r),
            child: widget.userInfo.profilePictureUrl != null ? Image.network(
              'https://intervyouquestions.runasp.net${widget.userInfo.profilePictureUrl}',
              width: 40.w.clamp(30, 50),
              height: 40.h.clamp(30, 50),
            )
                :Image.asset(
              AssetsManager.guestPp,
              width: 40.w.clamp(30, 50),
              height: 40.h.clamp(30, 50),
            )
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.userInfo.userName ?? '',
              style: LightAppStyle.email.copyWith(
                  color: Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.userInfo.currentRoleOrHeadline ?? '',
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
          onTap: () {
            ApiManger.sendConnectionRequest(targetUserId: widget.userInfo.userId??'');
    WidgetsBinding.instance.addPostFrameCallback(
    (_) => setState(() => isSend = !isSend),
    );
          } ,
          child: Container(
            padding: REdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSend
                  ? ColorsManger.newSecondaryColor.withOpacity(0.2)
                  : ColorsManger.newSecondaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Connect',
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
