import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/blogs_models/post/PostDetailsDm.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/handler_functions.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class PostDetailsItem extends StatelessWidget {
  PostDetailsItem({super.key, required this.post});

  final PostDetailsDm post;

  void _showCommentBottomSheet(BuildContext context, BlogsViewModel viewModel) {
    final commentController = TextEditingController();
    bool isPosting = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 20,
                  right: 20,
                  top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: commentController,
                    autofocus: true,
                    style: LightAppStyle.email
                        .copyWith(color: Colors.black, fontSize: 15.sp),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.6),
                              width: 2.w)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: ColorsManger.newSecondaryColor
                                  .withOpacity(0.6),
                              width: 2.w)),
                      hintText: 'Write a comment...',
                      hintStyle: LightAppStyle.email.copyWith(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15.sp),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isPosting
                          ? null
                          : () async {
                        if (commentController.text.trim().isEmpty) return;

                        setModalState(() {
                          isPosting = true;
                        });

                        bool success = await viewModel.createCommentOnPost(
                          postId: post.id ?? 0,
                          content: commentController.text.trim(),
                        );

                        if (Navigator.canPop(bottomSheetContext)) {
                          if (success) {
                            Navigator.pop(bottomSheetContext);
                          } else {
                            setModalState(() {
                              isPosting = false;
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManger.newSecondaryColor),
                      child: isPosting
                          ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                          : const Text('Post Comment',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BlogsViewModel>(context, listen: false);

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
                  child: post.author?.profilePictureUrl != null
                      ? Image.network(
                    'https://intervyouquestions.runasp.net${post.author?.profilePictureUrl}',
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
                      post.author?.userName ?? '',
                      style: LightAppStyle.email.copyWith(
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      HandlerFunctions.formatSmartDate(post.createdAt ?? ''),
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
            Text(post.title ?? '',
                style: LightAppStyle.email.copyWith(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700)),
            Text(
              post.content ?? '',
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
                  onTap: () {
                    final currentVote = post.currentUserVote ?? 0;
                    final newVote = currentVote == 1 ? 0 : 1;
                    viewModel.voteOnPost(post.id!, newVote);
                  },
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    bottomLeft: Radius.circular(25.r),
                  ),
                  child: Container(
                    padding:
                    REdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: (post.currentUserVote ?? 0) == 1
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
                SizedBox(
                  width: 2.w,
                ),
                InkWell(
                  onTap: () {
                    final currentVote = post.currentUserVote ?? 0;
                    final newVote = currentVote == -1 ? 0 : -1;
                    viewModel.voteOnPost(post.id!, newVote);
                  },
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.r),
                    bottomRight: Radius.circular(25.r),
                  ),
                  child: Container(
                    padding:
                    REdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: (post.currentUserVote ?? 0) == -1
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
                const Spacer(),
                InkWell(
                  onTap: () => _showCommentBottomSheet(context, viewModel),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManger.newSecondaryColor.withOpacity(0.13),
                    ),
                    child: Icon(Icons.add,
                        color: ColorsManger.newSecondaryColor.withOpacity(0.8),
                        size: 22),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  post.comments?.length.toString() ?? '0',
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
}