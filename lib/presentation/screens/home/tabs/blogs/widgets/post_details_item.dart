import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/blogs_models/post/PostDetailsDm.dart';
import '../../../../../../config/handler_functions.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';
import '../../../../../../data/api_manager.dart';

class PostDetailsItem extends StatefulWidget {
  PostDetailsItem({super.key, required this.post});
  @override
  State<PostDetailsItem> createState() => _PostDetailsItemState();
  PostDetailsDm post;
}

class _PostDetailsItemState extends State<PostDetailsItem> {
  num currentVote = 0;
  int votes = 50;

  @override
  void initState() {
    super.initState();
    currentVote = widget.post.currentUserVote ?? 0;
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: widget.post.author?.profilePictureUrl != null
                      ? Image.network(
                    'https://intervyouquestions.runasp.net${widget.post.author?.profilePictureUrl}',
                    width: 40.w.clamp(30, 50),
                    height: 40.h.clamp(30, 50),
                  )
                      : Image.asset(
                    AssetsManager.guestPp,
                    width: 40.w.clamp(30, 50),
                    height: 40.h.clamp(30, 50),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.author?.userName ?? '',
                      style: LightAppStyle.email.copyWith(
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${HandlerFunctions.formatSmartDate(widget.post.createdAt ?? '')}',
                      style: LightAppStyle.email.copyWith(
                        color: Colors.black,
                        fontSize: 11.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Text(widget.post.title ?? '',
                style: LightAppStyle.email.copyWith(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700)),
            Text(
              widget.post.content ?? '',
              style: LightAppStyle.email.copyWith(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w200,
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
                InkWell(
                  onTap: () => handleVote(widget.post.id??0,1,),
                  child: Container(
                    padding:
                    REdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: currentVote == 1
                          ? ColorsManger.newSecondaryColor.withOpacity(0.5)
                          : ColorsManger.newSecondaryColor.withOpacity(0.13),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        bottomLeft: Radius.circular(25.r),
                      ),
                    ),
                    child: Icon(Icons.arrow_upward,
                        color: ColorsManger.newSecondaryColor.withOpacity(0.8),
                        size: 22),
                  ),
                ),
                SizedBox(width: 2.w),
                InkWell(
                  onTap: () => handleVote(widget.post.id??0,-1),
                  child: Container(
                    padding:
                    REdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: currentVote == -1
                          ? ColorsManger.newSecondaryColor.withOpacity(0.5)
                          : ColorsManger.newSecondaryColor.withOpacity(0.13),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r),
                      ),
                    ),
                    child: Icon(Icons.arrow_downward,
                        color: ColorsManger.newSecondaryColor.withOpacity(0.8),
                        size: 22),
                  ),
                ),
                SizedBox(width: 10.w),
                if(widget.post.currentUserVote != null)Container(
                  padding: REdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                      color: ColorsManger.newSecondaryColor.withOpacity(0.13),
                      shape: BoxShape.circle
                  ),
                  child: Text('${widget.post.currentUserVote}',
                    style: LightAppStyle.email.copyWith(color: Colors.black.withOpacity(0.5),fontSize: 16.sp,fontWeight: FontWeight.w500),),
                ),
                Spacer(),
                InkWell(
                  onTap: () => print('reply'),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                      ColorsManger.newSecondaryColor.withOpacity(0.13),
                    ),
                    child: Icon(Icons.add,
                        color:
                        ColorsManger.newSecondaryColor.withOpacity(0.8),
                        size: 22),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  widget.post.comments?.length.toString() ?? '0',
                  style: LightAppStyle.email.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  'replies',
                  style: LightAppStyle.email.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
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

  void handleVote(num postId,num voteType,) async {
    num newVote = currentVote == voteType ? 0 : voteType;
    setState(() {
      currentVote = newVote;
    });
    await ApiManger.voteOnPost(postId: postId, type: newVote);
  }
}
