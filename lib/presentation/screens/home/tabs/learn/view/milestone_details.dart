import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view_model/learn_provider.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/widget/milestone_topic_item.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import '../../../../../../data/models/SubTopics.dart';

class MilestoneDetails extends StatelessWidget {
  const MilestoneDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final initialSubtopic =
    ModalRoute.of(context)!.settings.arguments as SubTopics;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Consumer<LearnViewModel>(
        builder: (context, viewModel, child) {
          SubTopics currentSubtopic = initialSubtopic;
          for (var topic in viewModel.topics) {
            var found = topic.subTopics?.firstWhere(
                    (st) => st.subTopicId == initialSubtopic.subTopicId,
                orElse: () => SubTopics());
            if (found?.subTopicId != null) {
              currentSubtopic = found!;
              break;
            }
          }

          final learningPoints = currentSubtopic.learningPoints ?? [];
          final completedPoints =
              learningPoints.where((p) => p.status == 2).length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: REdgeInsets.only(left: 20, top: 50, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        currentSubtopic.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: LightAppStyle.email.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                    children: [
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          currentSubtopic.description ?? '',
                          style: LightAppStyle.email.copyWith(
                              color: Colors.black, fontSize: 14.sp),
                          textAlign: TextAlign.center,
                          strutStyle: const StrutStyle(height: 1.5),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      if (currentSubtopic.contentUrl != null &&
                          currentSubtopic.contentUrl!.isNotEmpty)
                        Padding(
                          padding: REdgeInsets.only(right: 15),
                          child: Link(
                            target: LinkTarget.blank,
                            uri: Uri.parse(currentSubtopic.contentUrl!),
                            builder: (context, followLink) => GestureDetector(
                              onTap: followLink,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Documentation',
                                      style: LightAppStyle.email.copyWith(
                                          color:
                                          ColorsManger.newSecondaryColor,
                                          fontSize: 15.sp)),
                                  Icon(Icons.arrow_right_outlined,
                                      color:
                                      ColorsManger.newSecondaryColor,
                                      size: 30.sp),
                                ],
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 40.h),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: 500.h),
                        decoration: BoxDecoration(
                          color:
                          ColorsManger.newSecondaryColor.withOpacity(0.08),
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
                                          color:
                                          ColorsManger.newSecondaryColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500)),
                                  const Spacer(),
                                  Text(
                                    '$completedPoints',
                                    style: LightAppStyle.email.copyWith(
                                        color:
                                        ColorsManger.newSecondaryColor,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '/${learningPoints.length}',
                                    style: LightAppStyle.email.copyWith(
                                        color: ColorsManger
                                            .newSecondaryColor
                                            .withOpacity(0.5),
                                        fontSize: 22.sp),
                                  ),
                                ],
                              ),
                            ),
                            if (learningPoints.isEmpty)
                              const Padding(
                                padding: EdgeInsets.all(50.0),
                                child: Text(
                                    "No learning points available for this topic."),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 15.h),
                                itemBuilder: (context, index) => Center(
                                  child: MilestoneTopicItem(
                                    index: index + 1,
                                    learnPoint:
                                    '${learningPoints[index].name}',
                                    status:
                                    learningPoints[index].status ?? 0,
                                    id: learningPoints[index]
                                        .learningPointId ??
                                        0,
                                  ),
                                ),
                                itemCount: learningPoints.length,
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
          );
        },
      ),
    );
  }
}