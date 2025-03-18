import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/core/constants_string.dart';
import 'package:intervyou_app/presentation/screens/home/home.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/learn.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/widget/milestone_topic_item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/widget/widget.dart';

class MilestoneDetails extends StatefulWidget {
  const MilestoneDetails({super.key});

  @override
  State<MilestoneDetails> createState() => _MilestoneDetailsState();
}

class _MilestoneDetailsState extends State<MilestoneDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
            child: Row(
              children: [
                Text(
                  'Arrays',
                  style: LightAppStyle.email.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                        (route) => false);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 35.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Category Data Structure',
              style: LightAppStyle.email.copyWith(
                color: Colors.white.withOpacity(0.5),
                fontSize: 10.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      ConstantsString.arrayDoc,
                      style: LightAppStyle.email.copyWith(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      strutStyle: const StrutStyle(height: 1.5),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        print('documentation');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Documentation',
                            style: LightAppStyle.email.copyWith(
                              color:
                                  ColorsManger.secondaryColor.withOpacity(0.5),
                              fontSize: 13.sp,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_outlined,
                            color: ColorsManger.secondaryColor,
                            size: 30.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Container(
                    width: double.infinity,
                    height: 700.h,
                    decoration: BoxDecoration(
                      color: ColorsManger.semiBlack,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 30, right: 30, bottom: 10),
                          child: Row(
                            children: [
                              Text(
                                'Topic Details',
                                style: LightAppStyle.email,
                              ),
                              Spacer(),
                              Text(
                                '1/30',
                                style: LightAppStyle.email.copyWith(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15.h,
                            ),
                            itemBuilder: (context, index) =>
                                Center(child: MilestoneTopicItem( index: index+1)),
                            itemCount: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
