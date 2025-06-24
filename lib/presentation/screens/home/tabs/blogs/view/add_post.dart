import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/user_profile.dart';

import '../../../../../../config/styles/light_app_style.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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
            ElevatedButton(onPressed:() => print("posted") ,
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
