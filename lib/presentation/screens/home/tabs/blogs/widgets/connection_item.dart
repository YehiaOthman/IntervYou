import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/blogs_models/user_info_item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class ConnectionItem extends StatelessWidget {
  ConnectionItem({super.key, required this.userProfile});
  final UserInfoItem userProfile;

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: ColorsManger.newSecondaryColor,
          title: Text(
            'Remove Connection',
            style: LightAppStyle.email.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          content: Text(
            'Are you sure you want to remove ${userProfile.userName ?? 'this user'}?',
            style: LightAppStyle.email.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: LightAppStyle.email.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text('Remove',
                  style: LightAppStyle.email.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  )),
              onPressed: () {
                final viewModel =
                Provider.of<BlogsViewModel>(context, listen: false);
                if (userProfile.userId != null) {
                  viewModel.removeExistingConnection(userProfile.userId!);
                }
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: (userProfile.profilePictureUrl != null &&
              userProfile.profilePictureUrl!.isNotEmpty)
              ? NetworkImage(
              'https://intervyouquestions.runasp.net${userProfile.profilePictureUrl}')
              : const AssetImage(AssetsManager.guestPp) as ImageProvider,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            userProfile.userName ?? 'N/A',
            style: LightAppStyle.email.copyWith(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        PopupMenuButton<String>(
          color: ColorsManger.newSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          menuPadding: EdgeInsets.zero,
          icon: Icon(Icons.more_horiz,
              color: ColorsManger.newSecondaryColor, size: 28.sp),
          onSelected: (String result) {
            if (result == 'remove') {
              _showConfirmationDialog(context);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'remove',
              child: Text('Remove Connection',
                  style: LightAppStyle.email.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}