import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/assets_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart'; // Import BlogsViewModel
import 'package:intervyou_app/presentation/screens/home/tabs/home_tab/widgets/widgets.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view_model/learn_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/colors_manager.dart';
import '../../../../../../data/models/SubTopics.dart';

class HomeTab extends StatefulWidget {
  final VoidCallback onNavigateToLearn;
  const HomeTab({super.key, required this.onNavigateToLearn});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late List<SubTopics> subTopics;
  late LearnViewModel viewModel;
  late int finishedTasks;
  late int totalTasks;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  Future<void> _loadInitialData() async {
    final learnViewModel = Provider.of<LearnViewModel>(context, listen: false);
    final blogsViewModel = Provider.of<BlogsViewModel>(context, listen: false);

    learnViewModel.getLearnData();

    const storage = FlutterSecureStorage();
    final userId = await storage.read(key: 'user_id');
    if (userId != null && mounted) {
      blogsViewModel.fetchUserProfile(userId);
    }
  }

  int finishedTasksCount(int index) {
    int count = 0;
    for (int i = 0; i < subTopics[index].learningPoints!.length; i++) {
      if (subTopics[index].learningPoints![i].status == 2) {
        count++;
      }
    }
    return count;
  }

  int totalTasksCount(int index) {
    int count = subTopics[index].learningPoints!.length;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Consumer<LearnViewModel>(
        builder: (context, learnViewModel, child) {
          viewModel = learnViewModel;

          if (viewModel.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorsManger.newSecondaryColor,
              ),
            );
          } else {
            subTopics = viewModel.topics.isNotEmpty
                ? (viewModel.topics[viewModel.currentTopicIndex].subTopics ??
                [])
                : [];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 230.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorsManger.newSecondaryColor,
                    ),
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50.h),
                          Consumer<BlogsViewModel>(
                            builder: (context, blogsViewModel, _) {
                              final userProfile = blogsViewModel.userProfile;
                              return homeHeader(
                                userProfile?.fullName ?? 'Guest',
                                userProfile?.profilePictureUrl,
                              );
                            },
                          ),
                          SizedBox(height: 40.h),
                          GestureDetector(
                            onTap: widget.onNavigateToLearn,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Continue Your',
                                  style: LightAppStyle.email.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Learning Adventure!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'Current Topics Progress',
                      style: LightAppStyle.email.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 170.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: subTopics.length,
                      shrinkWrap: true,
                      padding: REdgeInsets.symmetric(horizontal: 10),
                      separatorBuilder: (_, __) => SizedBox(width: 8.w),
                      itemBuilder: (context, index) {
                        finishedTasks = finishedTasksCount(index);
                        totalTasks = totalTasksCount(index);
                        return buildCardItem(
                            subTopics[index].name ?? '',
                            subTopics[index].description ?? '',
                            finishedTasks,
                            totalTasks);
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'Daily Quizzes',
                      style: LightAppStyle.email.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  if (subTopics.isNotEmpty)
                    ListView.separated(
                      itemCount: subTopics.length,
                      shrinkWrap: true,
                      physics:NeverScrollableScrollPhysics(),
                      padding: REdgeInsets.symmetric(horizontal: 10),
                      separatorBuilder: (_, __) => SizedBox(width: 8.w),
                      itemBuilder: (context, index) => buildQuizCard(
                          subTopics[index].name ?? '',
                          subTopics[index].isQuizPassed ?? false),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildQuizCard(String quizName, bool isDone) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      color: Colors.white,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Text(
              quizName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: LightAppStyle.email.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            if (isDone)
              Container(
                width: 25.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: ColorsManger.newSecondaryColor,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Icon(Icons.done, color: Colors.white, size: 20.sp),
              ),
          ],
        ),
      ),
    );
  }
}