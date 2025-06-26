import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/api_manager.dart';
import 'package:intervyou_app/data/blogs_models/connections/connections_items.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class PendingCardItem extends StatefulWidget {
   PendingCardItem({super.key, required this.pendingUser});

  @override
  State<PendingCardItem> createState() => _PendingCardItemState();
  ConnectionsItem pendingUser;
}

class _PendingCardItemState extends State<PendingCardItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: widget.pendingUser.profilePictureUrl != null ? Image.network(
              'https://intervyouquestions.runasp.net${widget.pendingUser.profilePictureUrl}',
              width: 40.w.clamp(30, 50),
              height: 40.h.clamp(30, 50),
            )
                :Image.asset(
              AssetsManager.guestPp,
              width: 40.w.clamp(30, 50),
              height: 40.h.clamp(30, 50),
            )
        ),
        SizedBox(width: 15.w),
        Text(
          widget.pendingUser.userName ?? '',
          style: LightAppStyle.email.copyWith(
              color: Colors.black,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
        InkWell(
          onTap: () => ApiManger.acceptConnectionRequest(connectionId: widget.pendingUser.connectionId??0),
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
          onTap: () => ApiManger.declineConnectionRequest(connectionId: widget.pendingUser.connectionId??0),
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
