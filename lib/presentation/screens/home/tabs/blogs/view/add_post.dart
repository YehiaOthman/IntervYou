import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/data/api_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/user_profile.dart';

import '../../../../../../config/styles/light_app_style.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
   late  TextEditingController titleController = TextEditingController();
   late TextEditingController contentController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManger.newSecondaryColor,
        title: Text('Add New Post',
            style: LightAppStyle.email.copyWith(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600
            )),
        iconTheme: IconThemeData(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
        toolbarHeight: 75.h,

      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Title', style: LightAppStyle.email.copyWith(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600
            )),
            SizedBox(height: 10.h),
            TextField(
              maxLines: 2,
              minLines: 1,
              controller:titleController,
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
                  hintText: 'Enter post title...',
                hintStyle: LightAppStyle.email.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 15.sp
                ),

              ),),
            SizedBox(height: 25.h),
            Text('Content', style: LightAppStyle.email.copyWith(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600
            )),
            SizedBox(height: 10.h),
            TextField(
              controller: contentController,
              maxLines: 10,
              minLines: 10,
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
                hintText: 'Enter post details...',
                hintStyle: LightAppStyle.email.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 15.sp
                ),

              ),),
            SizedBox(height: 30.h),
            ElevatedButton(
                onPressed: () async {
                  final title = titleController.text.trim();
                  final content = contentController.text.trim();

                  if (title.isEmpty || content.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Title and content cannot be empty")),
                    );
                    return;
                  }

                  if (content.length < 50) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Content must be at least 50 characters")),
                    );
                    return;
                  }

                  final response = await ApiManger.createPost(title: title, content: content);

                  if (response == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something went wrong. Try again.")),
                    );
                    return;
                  }

                  if (response.statusCode == 201 || response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Post created successfully!")),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to create post.")),
                    );
                  }
                }
                ,
                child: Padding(
                  padding:  REdgeInsets.symmetric(vertical: 12,),
                  child: Text('Post', style: LightAppStyle.email.copyWith(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600
                  ),),
                ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManger.newSecondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

          ))
          ],
        ),
      ),
    );
  }
}
