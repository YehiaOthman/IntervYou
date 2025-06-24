import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/user_info_profile.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';
import '../../../../../../core/routes_manger.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManger.newSecondaryColor,
        title: Text('User Profile',
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
      body: SingleChildScrollView(
        child: Padding(
          padding:  REdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          AssetsManager.pp,
                          width: 100.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yehia Othman',
                            style: LightAppStyle.email.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Text(
                            'UI/UX Designer',
                            style: LightAppStyle.email.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '+200 connections',
                            style: LightAppStyle.email.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text('About',
                      style: LightAppStyle.email.copyWith(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600)),
                  Text(
                      'Passionate back-end developer with experience in .Net Skilled in building APIs, optimizing databases, and writing clean, efficient code. Eager to learn, collaborate, and contribute to projects. Let’s connect and create innovative solutions!',
                      style: LightAppStyle.email.copyWith(
                          color: Colors.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w200)),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, RoutesManger.connectionsList),
                    child: Row(
                      children: [
                        Text('Connections',
                            style: LightAppStyle.email.copyWith(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600)),
                        Spacer(),
                        Text('See All',
                            style: LightAppStyle.email.copyWith(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w200)),
                        Icon(Icons.arrow_right, color: ColorsManger.newSecondaryColor, size: 28.sp)
                      ],
                    ),
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) => connectionsItem(),
                    itemCount: 4,
                    padding: REdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    physics:  NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(height: 15.h),
                  ),
                  SizedBox(height: 20.h),
                  Text('Blogs Activity',
                      style: LightAppStyle.email.copyWith(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600)),
                  ListView.separated(
                    itemBuilder: (context, index) => BlogsActivityCardItem(),
                    itemCount: 10,
                    padding: REdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    physics:  NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(height: 15.h),
                          Container(
                            width: double.infinity,
                            height: 1.h,
                            color: ColorsManger.newSecondaryColor.withOpacity(0.2),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
Widget connectionsItem() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ClipRRect(
          child: Image.asset(AssetsManager.pp, width: 35.w, height: 35.h)),
      SizedBox(width: 10.w),
      Text(
        'Yehia Othman',
        style: LightAppStyle.email.copyWith(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600),
      ),
      Spacer(),
      Icon(Icons.more_horiz, color: ColorsManger.newSecondaryColor, size: 28.sp)
    ],
  );
}
