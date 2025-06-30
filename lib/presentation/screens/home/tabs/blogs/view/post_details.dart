import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/data/blogs_models/post/Comments.dart';
import 'package:intervyou_app/data/blogs_models/post/PostDetailsDm.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/posts_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/post_details_item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/post_reply_item.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/styles/light_app_style.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  late ArgumentsModel arguments;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      arguments = ModalRoute.of(context)?.settings.arguments as ArgumentsModel;
      final viewModel = arguments.viewModel;
      viewModel.fetchPostDetails(arguments.id);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = (ModalRoute.of(context)?.settings.arguments as ArgumentsModel).viewModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorsManger.newSecondaryColor,
        title: Text('Post Details',
            style: LightAppStyle.email.copyWith(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
        toolbarHeight: 75.h,
      ),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<BlogsViewModel>(
          builder: (context, value, child) {
            if (value.postDetailsLoading || value.postDetails == null) {
              return const Center(child: CircularProgressIndicator(color: ColorsManger.newSecondaryColor,));
            }

            final PostDetailsDm post = value.postDetails!;
            final List<Comments> comments = value.postDetails?.comments ?? [];

            return SingleChildScrollView(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: Column(
                  children: [
                    PostDetailsItem(post: post),
                    SizedBox(height: 15.h),
                    if (comments.isNotEmpty)
                      Text('Replies',
                          style: LightAppStyle.email.copyWith(
                              color: ColorsManger.newSecondaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold)),
                    ListView.separated(
                        itemBuilder: (context, index) => PostReplyItem(comment: comments[index]),
                        separatorBuilder: (context, index) => SizedBox(height: 15.h),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 15),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: comments.length)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}