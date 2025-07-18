import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/api_manager.dart';
import 'package:intervyou_app/data/blogs_models/connections/SentConnections.dart';
import 'package:intervyou_app/data/blogs_models/connections/connections_items.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class CancelConnectionItem extends StatefulWidget {
   CancelConnectionItem({super.key, required this.SentUser});

  @override
  State<CancelConnectionItem> createState() => _CancelConnectionItemState();
  ConnectionsItem SentUser;
}

class _CancelConnectionItemState extends State<CancelConnectionItem> {
  bool isSend = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: widget.SentUser.profilePictureUrl != null ? Image.network(
              'https://intervyouquestions.runasp.net${widget.SentUser.profilePictureUrl}',
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
        Text(
          widget.SentUser.userName ?? '',
          style: LightAppStyle.email.copyWith(
              color: Colors.black,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
        InkWell(
          onTap: () {
            ApiManger.declineConnectionRequest(connectionId: widget.SentUser.connectionId??0);
            WidgetsBinding.instance.addPostFrameCallback(
                  (_) => setState(() => isSend = !isSend),
            );
          },
          child: Container(
            padding: REdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSend
                  ? ColorsManger.newSecondaryColor.withOpacity(0.2)
                  : ColorsManger.newSecondaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Cancel',
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
