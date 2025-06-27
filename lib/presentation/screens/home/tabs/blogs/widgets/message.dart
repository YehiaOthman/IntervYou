import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/data/blogs_models/chat/conversation_other_user_id_item.dart';
import '../../../../../../config/styles/light_app_style.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.conversationOtherUserIdItem,
    required this.isSentByMe,
  });

  final ConversationOtherUserIdItem conversationOtherUserIdItem;
  final bool isSentByMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 250.w),
      padding: REdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isSentByMe ? ColorsManger.newSecondaryColor.withOpacity(0.4) : ColorsManger.newSecondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(25),
          topRight: const Radius.circular(25),
          bottomLeft: isSentByMe ? const Radius.circular(25) : const Radius.circular(0),
          bottomRight: isSentByMe ? const Radius.circular(0) : const Radius.circular(25),
        ),
      ),
      child: Text(
        conversationOtherUserIdItem.content ?? '',
        style: LightAppStyle.email.copyWith(
          color: isSentByMe ? Colors.black : Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        textWidthBasis: TextWidthBasis.longestLine,
      ),
    );
  }
}