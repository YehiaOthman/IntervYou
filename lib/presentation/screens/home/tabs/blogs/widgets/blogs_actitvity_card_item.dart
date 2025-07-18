import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/handler_functions.dart';
import 'package:intervyou_app/data/blogs_models/post/posts_item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class BlogsActivityCardItem extends StatelessWidget {
  BlogsActivityCardItem({super.key, required this.post});

  final PostsItem post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: post.author?.profilePictureUrl != null
                    ? Image.network(
                    'https://intervyouquestions.runasp.net${post.author?.profilePictureUrl}',
                    width: 35.w,
                    height: 35.h)
                    : Image.asset(AssetsManager.pp, width: 35.w, height: 35.h)),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.author?.userName ?? '',
                  style: LightAppStyle.email.copyWith(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  HandlerFunctions.formatSmartDate(post.createdAt ?? ''),
                  style: LightAppStyle.email.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      backgroundColor: ColorsManger.newSecondaryColor,
                      title:  Text('Delete Post',
                        style: LightAppStyle.email.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),),
                      content:  Text(
                          'Are you sure you want to delete this post?',
                        style: LightAppStyle.email.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child:  Text('Cancel',
                            style: LightAppStyle.email.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                        ),
                        TextButton(
                          child:  Text('Delete',
                              style: LightAppStyle.email.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                              )),
                          onPressed: () {
                            final viewModel = Provider.of<BlogsViewModel>(
                                context,
                                listen: false);
                            if (post.id != null) {
                              viewModel.deleteExistingPost(post.id!).then((_) {
                                if (post.author?.userId != null) {
                                  viewModel
                                      .fetchPostsByAuthor(post.author!.userId!);
                                }
                              });
                            }
                            Navigator.of(dialogContext).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.delete_outline,
                  color: ColorsManger.newSecondaryColor, size: 25.sp),
            ),
          ],
        ),
        Padding(
          padding: REdgeInsets.only(left: 45),
          child: Text(post.title ?? '',
              textAlign: TextAlign.start,
              style: LightAppStyle.email.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
        Padding(
          padding: REdgeInsets.only(left: 45),
          child: Text(post.snippet ?? '',
              style: LightAppStyle.email.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              )),
        )
      ],
    );
  }
}