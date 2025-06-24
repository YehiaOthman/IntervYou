import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/post_reply_item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/post_tiem_widget_v2.dart';

import '../../../../../../config/styles/light_app_style.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorsManger.newSecondaryColor,
          title: Text('Post Details',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Column(
            children: [
              PostItemWidgetV2(
                  postContent: 'In recent'
                      ' decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
              SizedBox(height: 15.h),
              Text('Replies',
                  style: LightAppStyle.email.copyWith(
                      color: ColorsManger.newSecondaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold
              )),
              ListView.separated(itemBuilder:(context, index) =>  PostReplyItem(postContent: 'yes'),
                  separatorBuilder: (context, index) => SizedBox(height: 15.h),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 15),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10)
            ],
          ),
        ),
      ),
    );
  }
}
