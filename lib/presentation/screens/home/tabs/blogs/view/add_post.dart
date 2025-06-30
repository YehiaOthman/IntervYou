import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/colors_manager.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool _isPosting = false;

  Future<void> _createPost() async {
    final viewModel = Provider.of<BlogsViewModel>(context, listen: false);
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title and content cannot be empty")),
      );
      return;
    }

    if (content.length < 50) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Content must be at least 50 characters")),
      );
      return;
    }

    setState(() {
      _isPosting = true;
    });

    bool success = await viewModel.createNewPost(title: title, content: content);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Post created successfully!")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to create post.")),
        );
        setState(() {
          _isPosting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManger.newSecondaryColor,
        title: Text('Add New Post',
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Title',
                style: LightAppStyle.email.copyWith(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),
            TextField(
              maxLines: 2,
              minLines: 1,
              controller: titleController,
              style: LightAppStyle.email
                  .copyWith(color: Colors.black, fontSize: 15.sp),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.6), width: 2.w)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color:
                        ColorsManger.newSecondaryColor.withOpacity(0.6),
                        width: 2.w)),
                hintText: 'Enter post title...',
                hintStyle: LightAppStyle.email.copyWith(
                    color: Colors.black.withOpacity(0.5), fontSize: 15.sp),
              ),
            ),
            SizedBox(height: 25.h),
            Text('Content',
                style: LightAppStyle.email.copyWith(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),
            TextField(
              controller: contentController,
              maxLines: 10,
              minLines: 10,
              style: LightAppStyle.email
                  .copyWith(color: Colors.black, fontSize: 15.sp),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.6), width: 2.w)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color:
                        ColorsManger.newSecondaryColor.withOpacity(0.6),
                        width: 2.w)),
                hintText: 'Enter post details...',
                hintStyle: LightAppStyle.email.copyWith(
                    color: Colors.black.withOpacity(0.5), fontSize: 15.sp),
              ),
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
                onPressed: _isPosting ? null : _createPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManger.newSecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: REdgeInsets.symmetric(vertical: 12),
                  child: _isPosting
                      ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white))
                      : Text(
                    'Post',
                    style: LightAppStyle.email.copyWith(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}