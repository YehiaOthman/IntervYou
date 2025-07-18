import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/data/api_manager.dart';
import 'package:intervyou_app/data/blogs_models/post/posts_item.dart';
import 'package:intervyou_app/data/blogs_models/profile/Profile_dm.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../view_model/blogs_viewmodel.dart';
import 'netwrok_tab.dart';

class UserInfoProfile extends StatefulWidget {
  const UserInfoProfile({super.key});

  @override
  State<UserInfoProfile> createState() => _UserInfoProfileState();
}

class _UserInfoProfileState extends State<UserInfoProfile> {
  late UserArgumentsModel arguments;
  late BlogsViewModel viewModel;
  late ProfileDataModel profile;
  late List<PostsItem> posts = [];
  bool pending = false;
  bool friend = false;

  @override
  void didChangeDependencies() {
    arguments =
        ModalRoute.of(context)?.settings.arguments as UserArgumentsModel;
    viewModel = arguments.viewModel;
    viewModel.fetchUserProfile(arguments.id);
    viewModel.fetchPostsByAuthor(arguments.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsManger.newSecondaryColor,
        body: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<BlogsViewModel>(
            builder: (context, value, child) {
              if (viewModel.profileLoading)
                return const Center(child: CircularProgressIndicator());
              else {
                profile = viewModel.userProfile!;
                posts = viewModel.authorPosts!;
                return SingleChildScrollView(
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
                        height: MediaQuery.of(context).size.height,
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
                                CircleAvatar(
                                    radius: 52.r,
                                    backgroundColor: Colors.white,
                                    child: profile.profilePictureUrl != null
                                        ? Image.network(
                                            'https://intervyouquestions.runasp.net${profile.profilePictureUrl}',
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset(
                                            AssetsManager.pp,
                                            fit: BoxFit.fill,
                                          )),
                                SizedBox(width: 15.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile.fullName ?? 'No Name',
                                      style: LightAppStyle.email.copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      profile.preferredRole ?? 'No Role',
                                      style: LightAppStyle.email.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      '${profile.connectionsCount} connections',
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
                            if (profile.connectionStatusWithCurrentUser)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      ApiManger.sendConnectionRequest(
                                          targetUserId: profile.userId ?? '');
                                      setState(() {
                                        pending = true;
                                      });
                                    },
                                    child: Container(
                                      padding: REdgeInsets.symmetric(
                                          horizontal: 30, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: pending
                                            ? ColorsManger.newSecondaryColor
                                                .withOpacity(0.5)
                                            : ColorsManger.newSecondaryColor,
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            pending
                                                ? Icons.check
                                                : Icons
                                                    .person_add_alt_1_outlined,
                                            color: Colors.white,
                                            size: 25.sp,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            pending ? 'Pending' : 'Connect',
                                            style: LightAppStyle.email
                                                .copyWith(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: REdgeInsets.symmetric(
                                        horizontal: 30, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: ColorsManger.newSecondaryColor,
                                      borderRadius: BorderRadius.circular(25.r),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                            Text(profile.summary ?? '',
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
                            // ListView.separated(
                            //   itemBuilder: (context, index) =>
                            //       BlogsActivityCardItem(posts[index]),
                            //   itemCount: posts.length,
                            //   padding: REdgeInsets.only(top: 10),
                            //   shrinkWrap: true,
                            //   physics: NeverScrollableScrollPhysics(),
                            //   separatorBuilder: (context, index) {
                            //     return Column(
                            //       children: [
                            //         SizedBox(height: 15.h),
                            //         Container(
                            //           width: double.infinity,
                            //           height: 1.h,
                            //           color: ColorsManger.newSecondaryColor
                            //               .withOpacity(0.2),
                            //         ),
                            //         SizedBox(height: 15.h),
                            //       ],
                            //     );
                            //   },
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}


