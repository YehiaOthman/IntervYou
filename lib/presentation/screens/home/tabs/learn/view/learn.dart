import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/data/models/SubTopics.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/widget/widget.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/colors_manager.dart';
import '../../home_tab/widgets/widgets.dart';
import '../view_model/learn_provider.dart';
import 'road_map.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  List<Color> colors = [
    ColorsManger.milestoneColor1,
    ColorsManger.milestoneColor2,
    ColorsManger.milestoneColor3,
    ColorsManger.milestoneColor4,
  ];
  late List<SubTopics> subTopics;
  late LearnViewModel viewModel;


  // @override
  // void initState() {
  //   viewModel = Provider.of<LearnViewModel>(context);
  //   viewModel.getLearnData();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<LearnViewModel>(context,listen: false);
    Future.microtask(() {
      viewModel.getLearnData();
    },);
    super.didChangeDependencies();
  }
  int getAllTasks(){
    int count = 0;
    for(int i = 0; i < subTopics.length; i++){
      count += subTopics[i].learningPoints!.length;
    }
    return count;
  }
  int getAllDoneTasks(){
    int count = 0;
    for(int i = 0; i < subTopics.length; i++){
      count += subTopics[i].learningPoints!.where((element) => element.status == 2).length;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: Consumer<LearnViewModel>(builder: (context, value, child) {
        if (viewModel.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManger.newSecondaryColor,
            ),
          );
        } else {
          subTopics =
              viewModel.topics[viewModel.currentTopicIndex].subTopics ?? [];
          int tasks = getAllTasks();
          int doneTasks = getAllDoneTasks();
          return Padding(
            padding: REdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 45.h),
                  learnHeader(tasks, doneTasks),
                  SizedBox(height: 15.h),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          routeSettings:
                          RouteSettings(arguments: viewModel),
                          builder: (context) {
                            return SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.7,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                  ),
                                  child: RoadMap()),
                            );
                          });
                    },
                    child: Container(
                      width: 365.w,
                      decoration: BoxDecoration(
                        color: ColorsManger.newSecondaryColor
                            .withOpacity(0.08),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: REdgeInsets.symmetric(
                                vertical: 15, horizontal: 22),
                            child: Text(
                              'Road Map',
                              style: LightAppStyle.email.copyWith(
                                color: ColorsManger.newSecondaryColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Padding(
                                padding: REdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(height: 12.h),
                                            Container(
                                              width: 22.w,
                                              height: 22.h,
                                              decoration: BoxDecoration(
                                                color: ColorsManger
                                                    .newSecondaryColor
                                                    .withOpacity(0.4),
                                                border: Border.all(
                                                  color: ColorsManger
                                                      .newSecondaryColor,
                                                  width: 1.5,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Container(
                                                  width: 12.w,
                                                  height: 12.h,
                                                  decoration: BoxDecoration(
                                                    color: ColorsManger
                                                        .newSecondaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 2.w,
                                              height: 40.h,
                                              color: ColorsManger
                                                  .newSecondaryColor,
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Container(
                                            padding: REdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  35.r),
                                              border: Border.all(
                                                  color: ColorsManger
                                                      .newSecondaryColor,
                                                  width: 2),
                                            ),
                                            child: Padding(
                                              padding: REdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    viewModel
                                                        .topics[viewModel
                                                        .currentTopicIndex]
                                                        .name ??
                                                        '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: 22.w,
                                              height: 22.h,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: ColorsManger
                                                      .newSecondaryColor,
                                                  width: 1.5,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Container(
                                            padding: REdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  35.r),
                                              border: Border.all(
                                                  color: ColorsManger
                                                      .newSecondaryColor,
                                                  width: 2),
                                            ),
                                            child: Padding(
                                              padding: REdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    viewModel
                                                        .topics[viewModel
                                                        .currentTopicIndex +
                                                        1]
                                                        .name ??
                                                        '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    width: 365.w,
                    decoration: BoxDecoration(
                      color:
                      ColorsManger.newSecondaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Padding(
                      padding: REdgeInsets.all(22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Today’s milestones',
                                style: LightAppStyle.email.copyWith(
                                  color: ColorsManger.newSecondaryColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Container(
                                padding: REdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorsManger.newSecondaryColor.withOpacity(0.5),
                                ),
                                child: Text(
                                  '${subTopics.length}',
                                  style: LightAppStyle.email.copyWith(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.29,
                            width: double.infinity,
                            child: GridView.builder(
                              padding:
                              REdgeInsets.symmetric(vertical: 12.h),
                              physics: subTopics.length > 4
                                  ? ScrollPhysics(
                                  parent: ClampingScrollPhysics())
                                  : NeverScrollableScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.w,
                                  mainAxisSpacing: 10.h,
                                  childAspectRatio: 1.3),
                              itemCount: subTopics.length,
                              itemBuilder: (context, index) {
                                final donePoints = countDoneTasks(index);
                                return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, RoutesManger.milestoneTopic,
                                      arguments: subTopics[index]),
                                  child: milestoneCard(
                                      colors[index % colors.length],
                                      subTopics[index].name ?? "",
                                      subTopics[index]
                                          .learningPoints
                                          ?.length ??
                                          0,
                                      donePoints),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 8.h),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    width: 365.w,
                    decoration: BoxDecoration(
                      color:
                      ColorsManger.newSecondaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Padding(
                      padding: REdgeInsets.all(22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Quiz and Test',
                                  style: LightAppStyle.email.copyWith(
                                    color: ColorsManger.newSecondaryColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  )),
                              SizedBox(width: 10.w),
                              Container(
                                padding: REdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorsManger.newSecondaryColor.withOpacity(0.5),
                                ),
                                child: Text(
                                  '${subTopics.length}',
                                  style: LightAppStyle.email.copyWith(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.22.h,
                            width: double.infinity,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              physics: subTopics.length > 2
                                  ? ScrollPhysics(
                                  parent: ClampingScrollPhysics())
                                  : NeverScrollableScrollPhysics(),
                              itemCount: subTopics.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      RoutesManger.quiz,
                                      arguments: {
                                        'subTopicId': subTopics[index].subTopicId,
                                        'subTopicName': subTopics[index].name,
                                      },),
                                    child: quizItemWidget(index + 1,
                                        subTopics[index].name ?? "",subTopics[index].isQuizPassed ?? false));
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15.h),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          );
        }
      },),
    );
  }

  int countDoneTasks(int index) {
    int count = 0;
    for (int i = 0; i < subTopics[index].learningPoints!.length; i++) {
      if (subTopics[index].learningPoints![i].status == 2) {
        count++;
      }
    }
    return count;
  }
}
