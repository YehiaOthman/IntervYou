import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/profile/widget/profile_item_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../config/styles/light_app_style.dart';
import '../../../../../core/assets_manager.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfileData();
    });
  }

  Future<void> _loadProfileData() async {
    final viewModel = Provider.of<BlogsViewModel>(context, listen: false);
    const storage = FlutterSecureStorage();
    final userId = await storage.read(key: 'user_id');
    if (userId != null && mounted) {
      viewModel.fetchUserProfile(userId);
    }
  }

  void _showLogoutConfirmation(BuildContext context) {
    final viewModel = Provider.of<BlogsViewModel>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return Container(
          padding: REdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Logout',
                style: LightAppStyle.email.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.h),
              Divider(
                color: ColorsManger.newSecondaryColor.withOpacity(0.2),
                thickness: 1,),
              Text(
                'Are you sure you want to logout?',
                style: LightAppStyle.email.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bottomSheetContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.01),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text(
                        'Cancel',
                        style: LightAppStyle.email.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorsManger.newSecondaryColor,)
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await viewModel.logout();
                        if (mounted) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RoutesManger.login, (Route<dynamic> route) => false);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManger.newSecondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text(
                          'Yes, Logout',
                          style: LightAppStyle.email.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,)
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogsViewModel>(
      builder: (context, viewModel, child) {
        final userProfile = viewModel.userProfile;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    color: ColorsManger.newSecondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 55.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 52.r,
                            backgroundImage: (userProfile?.profilePictureUrl !=
                                null &&
                                userProfile!
                                    .profilePictureUrl!.isNotEmpty)
                                ? NetworkImage(
                                'https://intervyouquestions.runasp.net${userProfile.profilePictureUrl!}')
                                : const AssetImage(AssetsManager.pp)
                            as ImageProvider,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              viewModel.changeProfilePicture();
                            },
                            borderRadius: BorderRadius.circular(50.r),
                            child: Container(
                              padding: REdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: ColorsManger.newSecondaryColor,
                                shape: BoxShape.circle,
                                border:
                                Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(Icons.edit,
                                  color: Colors.white, size: 15.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      viewModel.profileLoading
                          ? ''
                          : (userProfile?.fullName ?? 'Guest User'),
                      style: LightAppStyle.email.copyWith(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      userProfile?.preferredRole ?? '',
                      style: LightAppStyle.email.copyWith(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: ProfileItemWidget(
                          icon1: Icons.person_outline,
                          title: 'Your Profile',
                          icon2: Icons.arrow_forward_ios),
                    ),
                    const Divider(
                        thickness: 1, indent: 20, endIndent: 20, height: 1),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {},
                      child: ProfileItemWidget(
                          icon1: Icons.help_outline,
                          title: 'Help Center',
                          icon2: Icons.arrow_forward_ios),
                    ),
                    const Divider(
                        thickness: 1, indent: 20, endIndent: 20, height: 1),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {},
                      child: ProfileItemWidget(
                          icon1: Icons.privacy_tip_outlined,
                          title: 'Privacy Policy',
                          icon2: Icons.arrow_forward_ios),
                    ),
                    const Divider(
                        thickness: 1, indent: 20, endIndent: 20, height: 1),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        _showLogoutConfirmation(context);
                      },
                      child: ProfileItemWidget(
                          icon1: Icons.logout_outlined,
                          title: 'Logout',
                          icon2: Icons.arrow_forward_ios),
                    ),
                    const Divider(
                        thickness: 1, indent: 20, endIndent: 20, height: 1),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}