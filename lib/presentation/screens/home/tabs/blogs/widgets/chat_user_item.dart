import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/blogs_models/chat/conversation_item.dart';

import '../../../../../../config/handler_functions.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class ChatUserItem extends StatefulWidget {
   ChatUserItem({super.key, required this.conversations});

  @override
  State<ChatUserItem> createState() => _ChatUserItemState();
  ConversationsItem conversations;
}

class _ChatUserItemState extends State<ChatUserItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: widget.conversations.otherUserProfilePictureUrl != null ? Image.network(
              'https://intervyouquestions.runasp.net${widget.conversations.otherUserProfilePictureUrl}',
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
              widget.conversations.otherUserName ?? '',
              style: LightAppStyle.email.copyWith(
                  color: Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if(widget.conversations.lastMessageSnippet != null)Row(
              children: [
                Icon(Icons.circle, color: ColorsManger.newSecondaryColor, size: 10.sp),
                SizedBox(width: 5.w),
                Text(
                  (widget.conversations.lastMessageSnippet ?? '').length > 15
                      ? '${widget.conversations.lastMessageSnippet!.substring(0, 15)}...'
                      : widget.conversations.lastMessageSnippet ?? '',
                  style: LightAppStyle.email.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
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
            Text('${HandlerFunctions.formatSmartDate(widget.conversations.lastMessageAt ?? '')}',
              style: LightAppStyle.email.copyWith(color: Colors.black.withOpacity(0.5), fontSize: 13.sp, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),
            if(widget.conversations.unreadMessagesCount != 0) Container(
              padding: REdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green
              ),
              child: Text(widget.conversations.unreadMessagesCount.toString(), style: LightAppStyle.email.copyWith(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),
            )
        ],)
      ],
    );
  }
}
