import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/handler_functions.dart';
import 'package:intervyou_app/data/api_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';
import '../../../../../../data/blogs_models/timeline/time_line_item.dart';

class PostItemWidgetV2 extends StatefulWidget {
  PostItemWidgetV2({super.key, required this.item});

  final TimeLineItem item;

  @override
  State<PostItemWidgetV2> createState() => _PostItemWidgetV2State();
}

class _PostItemWidgetV2State extends State<PostItemWidgetV2> {
  num currentVote = 0;

  @override
  void initState() {
    super.initState();
    currentVote = widget.item.blogPostCurrentUserVote ?? 0;
  }

  void _showCommentBottomSheet(BuildContext context) {
    final viewModel = Provider.of<BlogsViewModel>(context, listen: false);
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
                    style: LightAppStyle.email.copyWith(
                        color: Colors.black,
                        fontSize: 15.sp
                    ),
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
                              color: Colors.grey.withOpacity(0.6), width: 2.w)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: ColorsManger.newSecondaryColor.withOpacity(
                                  0.6), width: 2.w)
                      ),
                      hintText: 'Write a comment...',
                      hintStyle: LightAppStyle.email.copyWith(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15.sp
                      ),

                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isPosting ? null : () async {
                        if (commentController.text.trim().isEmpty) return;

                        setModalState(() { isPosting = true; });

                        bool success = await viewModel.createCommentOnPost(
                          postId: widget.item.sourceItemId ?? 0,
                          content: commentController.text.trim(),
                        );

                        if (mounted) {
                          setModalState(() { isPosting = false; });
                          if (success) {
                            Navigator.pop(bottomSheetContext);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManger.newSecondaryColor),
                      child: isPosting
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Post Comment', style: TextStyle(color: Colors.white)),
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
                  child: widget.item.sourceUserProfilePictureUrl != null
                      ? Image.network(
                    'https://intervyouquestions.runasp.net${widget.item.sourceUserProfilePictureUrl}',
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
                      widget.item.sourceUserName ?? '',
                      style: LightAppStyle.email.copyWith(
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${HandlerFunctions.formatSmartDate(widget.item.timestamp ?? '')}',
                      style: LightAppStyle.email.copyWith(
                        color: Colors.black,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                PopupMenuButton<int>(
                  color: ColorsManger.newSecondaryColor,
                  popUpAnimationStyle: AnimationStyle(
                    duration: const Duration(milliseconds: 300),
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
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          const Icon(Icons.share_outlined, color: Colors.white),
                          SizedBox(width: 10.w),
                          Text('Share', style: LightAppStyle.email),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          const Icon(Icons.block_flipped, color: Colors.white),
                          SizedBox(width: 10.w),
                          Text('Block', style: LightAppStyle.email),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 3,
                      child: Row(
                        children: [
                          const Icon(Icons.report_gmailerrorred, color: Colors.white),
                          SizedBox(width: 10.w),
                          Text('Report', style: LightAppStyle.email),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Text(widget.item.blogPostTitle ?? '',
                style: LightAppStyle.email.copyWith(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700)),
            Text(
              widget.item.blogPostSnippet ?? '',
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
                  onTap: () => handleVote(widget.item.sourceItemId ?? 0, 1),
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
                  onTap: () => handleVote(widget.item.sourceItemId ?? 0, -1),
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
                if (widget.item.blogPostCurrentUserVote != null)
                  Container(
                    padding: REdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                        color: ColorsManger.newSecondaryColor.withOpacity(0.13),
                        shape: BoxShape.circle),
                    child: Text(
                      '${widget.item.blogPostCurrentUserVote}',
                      style: LightAppStyle.email.copyWith(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                const Spacer(),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () => _showCommentBottomSheet(context),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManger.newSecondaryColor.withOpacity(0.13),
                    ),
                    child: Icon(
                      Icons.add,
                      color: ColorsManger.newSecondaryColor.withOpacity(0.8),
                      size: 22,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Consumer<BlogsViewModel>(
                    builder: (context, viewModel, child){
                      final postInList = viewModel.timelineItems.firstWhere((p) => p.sourceItemId == widget.item.sourceItemId, orElse: ()=> widget.item);
                      return Text(
                        postInList.blogPostCommentCount.toString(),
                        style: LightAppStyle.email.copyWith(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }
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

  void handleVote(
      num postId,
      num voteType,
      ) async {
    num newVote = currentVote == voteType ? 0 : voteType;
    setState(() {
      currentVote = newVote;
    });
    await ApiManger.voteOnPost(postId: postId, type: newVote);
  }
}