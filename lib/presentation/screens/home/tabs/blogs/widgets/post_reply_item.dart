import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/blogs_models/post/Comments.dart';
import '../../../../../../config/handler_functions.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class PostReplyItem extends StatefulWidget {
   PostReplyItem({super.key, required this.comment});

  @override
  State<PostReplyItem> createState() => _PostReplyItemState();
  Comments comment;
}

class _PostReplyItemState extends State<PostReplyItem> {
  bool isVotedUp = false;
  bool isVotedDown = false;
  int votes = 50;
  int comments = 50;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 175.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: widget.comment.author?.profilePictureUrl != null ? Image.network(
                      'https://intervyouquestions.runasp.net${widget.comment.author?.profilePictureUrl}',
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
                      widget.comment.author?.userName ?? '',
                      style: LightAppStyle.email.copyWith(
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${HandlerFunctions.formatSmartDate(widget.comment.createdAt ?? '')}',
                      style: LightAppStyle.email.copyWith(
                        color: Colors.black,
                        fontSize: 11.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                PopupMenuButton<int>(
                  color: ColorsManger.newSecondaryColor,
                  popUpAnimationStyle: AnimationStyle(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInCirc,
                    reverseCurve: Curves.easeInCirc,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r),
                    ),
                    side: BorderSide(
                        color: ColorsManger.newSecondaryColor.withOpacity(0.3),
                        width: 2.w),
                  ),
                  icon: Icon(Icons.more_horiz,
                      color: ColorsManger.newSecondaryColor, size: 30.sp),
                  elevation: 6,
                  onSelected: (value) {
                    if (value == 1) {
                      print("Report clicked");
                    } else if (value == 2) {
                      print("Delete clicked");
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10.w),
                          Text('Share', style: LightAppStyle.email),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.block_flipped,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10.w),
                          Text('Block', style: LightAppStyle.email),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.report_gmailerrorred,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10.w),
                          Text('Report', style: LightAppStyle.email),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              widget.comment.content ??'no comments',
              style: LightAppStyle.email.copyWith(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              width: double.infinity,
              height: 1.h,
              color: ColorsManger.newSecondaryColor.withOpacity(0.3),
            ),
            SizedBox(height: 15.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                InkWell(
                  onTap: toggleUpVote,
                  child: Container(
                    padding: REdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: isVotedUp? ColorsManger.newSecondaryColor.withOpacity(0.5) : ColorsManger.newSecondaryColor.withOpacity(0.13),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        bottomLeft: Radius.circular(25.r),
                      ),
                    ),
                    child: Icon(Icons.arrow_upward, color: ColorsManger.newSecondaryColor.withOpacity(0.8),size: 22,),
                  ),
                ),
                SizedBox(width: 2.w),
                InkWell(
                  onTap: toggleDownVote,
                  child: Container(
                    padding: REdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: isVotedDown? ColorsManger.newSecondaryColor.withOpacity(0.5) : ColorsManger.newSecondaryColor.withOpacity(0.13),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r),
                      ),
                    ),
                    child: Icon(Icons.arrow_downward, color: ColorsManger.newSecondaryColor.withOpacity(0.8),size: 22,),
                  ),
                ),

              ],
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  void toggleUpVote() {
    setState(() {
      if (isVotedUp) {
        votes--;
        isVotedUp = false;
      } else {
        if (isVotedDown) {
          votes++;
          isVotedDown = false;
        }
        votes++;
        isVotedUp = true;
      }
    });
  }

  void toggleDownVote() {
    setState(() {
      if (isVotedDown) {
        votes++;
        isVotedDown = false;
      } else {
        if (isVotedUp) {
          votes--;
          isVotedUp = false;
        }
        votes--;
        isVotedDown = true;
      }
    });
  }
}
