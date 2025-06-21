import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/data/models/LearningPoints.dart';
import 'package:intervyou_app/presentation/screens/home/home.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/widget/milestone_topic_item.dart';
import 'package:url_launcher/link.dart';
import '../../../../../../data/models/SubTopics.dart';

class MilestoneDetails extends StatefulWidget {
  const MilestoneDetails({super.key});

  @override
  State<MilestoneDetails> createState() => _MilestoneDetailsState();
}

class _MilestoneDetailsState extends State<MilestoneDetails> {
  late List<LearningPoints> learningPoints;
  late var subtopic;
@override
  void didChangeDependencies() {
  subtopic = ModalRoute.of(context)!.settings.arguments as SubTopics;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    learningPoints = subtopic.learningPoints ?? [];
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.only(left: 20, top: 50, right: 20),
            child: Row(
              children: [
                Text(
                  subtopic.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: LightAppStyle.email.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                      color: Colors.black),
                ),
                Spacer(),
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
                    color: Colors.black,
                    size: 35.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: REdgeInsets.only(left: 20),
            child: Text(
              'Category Data Structure',
              style: LightAppStyle.email.copyWith(
                color: Colors.black.withOpacity(0.5),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      subtopic.description ?? '',
                      style: LightAppStyle.email.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      strutStyle: StrutStyle(height: 1.5),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: REdgeInsets.only(right: 15),
                    child: Link(
                      target: LinkTarget.self,
                      uri: Uri.parse(subtopic.contentUrl ?? ''),
                      builder: (context, followLink) => GestureDetector(
                        onTap: () {
                          print('documentation');
                          followLink?.call();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Documentation',
                              style: LightAppStyle.email.copyWith(
                                color: ColorsManger.newSecondaryColor,
                                fontSize: 15.sp,
                              ),
                            ),
                            Icon(
                              Icons.arrow_right_outlined,
                              color: ColorsManger.newSecondaryColor,
                              size: 30.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Container(
                    width: double.infinity,
                    height: 700.h,
                    decoration: BoxDecoration(
                      color: ColorsManger.newSecondaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: REdgeInsets.only(
                              top: 30, left: 30, right: 30, bottom: 10),
                          child: Row(
                            children: [
                              Text('Topic Details',
                                  style: LightAppStyle.email.copyWith(
                                    color: ColorsManger.newSecondaryColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  )),
                              Spacer(),
                              Text('1',// i need if the point statuts is 2 then add one to int var here and make it change
                                  style: LightAppStyle.email.copyWith(
                                      color: ColorsManger.newSecondaryColor,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                '/${learningPoints.length}',
                                style: LightAppStyle.email.copyWith(
                                  color: ColorsManger.newSecondaryColor
                                      .withOpacity(0.5),
                                  fontSize: 22.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15.h,
                            ),
                            itemBuilder: (context, index) => Center(
                                child: MilestoneTopicItem(
                              index: index + 1,
                              learnPoint: '${learningPoints[index].name}',
                              status: learningPoints[index].status ?? 0,
                              id: learningPoints[index].learningPointId ?? 0,
                            )),
                            itemCount: learningPoints.length,
                          ),
                        ),
                        SizedBox(height: 50.h),
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
