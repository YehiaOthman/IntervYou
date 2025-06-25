import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';

class UserInfoProfile extends StatefulWidget {
  const UserInfoProfile({super.key});

  @override
  State<UserInfoProfile> createState() => _UserInfoProfileState();
}

class _UserInfoProfileState extends State<UserInfoProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.newSecondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Padding(
              padding: REdgeInsets.only(left: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorsManger.newWhite,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'User Info',
                    style: LightAppStyle.email.copyWith(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              padding: REdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  )),
              child: Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            REdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        decoration: BoxDecoration(
                          color: ColorsManger.newSecondaryColor,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person_add_alt_1_outlined,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Connect',
                              style: LightAppStyle.email
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            REdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        decoration: BoxDecoration(
                          color: ColorsManger.newSecondaryColor,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.message_outlined,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Contact',
                              style: LightAppStyle.email
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget BlogsActivityCardItem() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              child: Image.asset(AssetsManager.pp, width: 35.w, height: 35.h)),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yehia Othman',
                style: LightAppStyle.email.copyWith(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '9:10 AM',
                style: LightAppStyle.email.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.more_horiz_outlined,
              color: ColorsManger.newSecondaryColor, size: 25.sp),
        ],
      ),
      Padding(
        padding: REdgeInsets.only(left: 45),
        child:
            Text('I’m getting a CORS error in my React app.How can I fix it?',
                style: LightAppStyle.email.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                )),
      )
    ],
  );
}
