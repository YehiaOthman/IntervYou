import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/blogs_models/post/posts_item.dart';
import 'package:intervyou_app/data/blogs_models/user_info_item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/connection_item.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';
import '../../../../../../core/routes_manger.dart';
import '../widgets/blogs_actitvity_card_item.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<BlogsViewModel>(context, listen: false);
      final args = ModalRoute.of(context)?.settings.arguments as String?;
      if (args != null) {
        viewModel.fetchPostsByAuthor(args);
        viewModel.fetchConnections();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogsViewModel>(
      builder: (context, viewModel, child) {
        final userProfile = viewModel.userProfile;
        final List<UserInfoItem> connections = viewModel.connections;
        final List<PostsItem> posts = viewModel.authorPosts;

        if (viewModel.profileLoading || userProfile == null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorsManger.newSecondaryColor,
              title: Text('User Profile',
                  style: LightAppStyle.email.copyWith(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600)),
              iconTheme: const IconThemeData(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
              ),
              toolbarHeight: 75.h,
            ),
            backgroundColor: Colors.white,
            body: const Center(
              child: CircularProgressIndicator(color: ColorsManger.newSecondaryColor),
            ),
          );
        }

        return Scaffold(
          backgroundColor: ColorsManger.newWhite,
          appBar: AppBar(
            backgroundColor: ColorsManger.newSecondaryColor,
            title: Text('User Profile',
                style: LightAppStyle.email.copyWith(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600)),
            iconTheme: const IconThemeData(color: Colors.white),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: (userProfile.profilePictureUrl !=
                                null &&
                                userProfile.profilePictureUrl!.isNotEmpty)
                                ? NetworkImage(
                                'https://intervyouquestions.runasp.net${userProfile.profilePictureUrl}')
                                : const AssetImage(AssetsManager.guestPp)
                            as ImageProvider,
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userProfile.fullName ?? 'N/A',
                                  style: LightAppStyle.email.copyWith(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                Text(
                                  userProfile.preferredRole ??
                                      'No role specified',
                                  style: LightAppStyle.email.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  '${userProfile.connectionsCount ?? 0} connections',
                                  style: LightAppStyle.email.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text('About',
                          style: LightAppStyle.email.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600)),
                      Text(userProfile.summary ?? 'No summary provided.',
                          style: LightAppStyle.email.copyWith(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w200)),
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, RoutesManger.connectionsList, arguments: connections),
                        child: Row(
                          children: [
                            Text('Connections',
                                style: LightAppStyle.email.copyWith(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600)),
                            const Spacer(),
                            Text('See All',
                                style: LightAppStyle.email.copyWith(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w200)),
                            Icon(Icons.arrow_right,
                                color: ColorsManger.newSecondaryColor,
                                size: 28.sp)
                          ],
                        ),
                      ),
                      viewModel.connectionsLoading
                          ? const Center(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(color: ColorsManger.newSecondaryColor,),
                      ))
                          : ListView.separated(
                        itemBuilder: (context, index) =>
                            ConnectionItem(userProfile: connections[index],),
                        itemCount: connections.length > 4 ? 4 : connections.length,
                        padding: REdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15.h),
                      ),
                      SizedBox(height: 20.h),
                      Text('Blogs Activity',
                          style: LightAppStyle.email.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600)),
                      viewModel.authorPostsLoading
                          ? const Center(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(color: ColorsManger.newSecondaryColor,),
                      ))
                          : ListView.separated(
                        itemBuilder: (context, index) =>
                            BlogsActivityCardItem(post: posts[index],),
                        itemCount: posts.length,
                        padding: REdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(height: 15.h),
                              Container(
                                width: double.infinity,
                                height: 1.h,
                                color: ColorsManger.newSecondaryColor
                                    .withOpacity(0.2),
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
      },
    );
  }
}