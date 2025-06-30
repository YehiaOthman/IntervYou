import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/handler_functions.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/assets_manager.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/data/blogs_models/notifications/notifications_Item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/posts_tab.dart'; // For ArgumentsModel
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:provider/provider.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationsItem notification;
  const NotificationItemWidget({super.key, required this.notification});

  void _handleTap(BuildContext context) {
    final viewModel = Provider.of<BlogsViewModel>(context, listen: false);

    // Mark the notification as read
    viewModel.markNotificationAsRead(notification);

    // Navigate based on the notification type
    // Note: You might need to adjust the routes and arguments based on your app's structure
    switch (notification.type) {
      case 1: // New Connection Request
        if (notification.sourceUserId != null) {
          // Assuming you have a route for user profiles that takes a userId
          Navigator.pushNamed(context, RoutesManger.userProfile, arguments: notification.sourceUserId);
        }
        break;
      case 2: // New Comment
      case 3: // New Upvote
        if (notification.relatedEntityId != null) {
          // Assuming you have a route for post details
          final arguments = ArgumentsModel(notification.relatedEntityId, viewModel);
          Navigator.pushNamed(context, RoutesManger.postDetails, arguments: arguments);
        }
        break;
    // Add more cases for other notification types if needed
      default:
        debugPrint("Tapped on notification with unhandled type: ${notification.type}");
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData getIconForType(num? type) {
      switch (type) {
        case 1:
          return Icons.person_add;
        case 2:
          return Icons.comment;
        case 3:
          return Icons.thumb_up;
        case 4:
          return Icons.alternate_email;
        default:
          return Icons.notifications;
      }
    }

    return InkWell(
      onTap: () => _handleTap(context),
      child: Container(
        color: (notification.isRead ?? true)
            ? Colors.transparent
            : ColorsManger.newSecondaryColor.withOpacity(0.05),
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage:
                  notification.sourceUserProfilePictureUrl != null &&
                      notification.sourceUserProfilePictureUrl!.isNotEmpty
                      ? NetworkImage(
                      'https://intervyouquestions.runasp.net${notification.sourceUserProfilePictureUrl}')
                      : const AssetImage(AssetsManager.guestPp)
                  as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: REdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: ColorsManger.newSecondaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Icon(
                      getIconForType(notification.type),
                      color: Colors.white,
                      size: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: LightAppStyle.email
                          .copyWith(color: Colors.black, fontSize: 14.sp),
                      children: [
                        TextSpan(
                          text: '${notification.sourceUserName ?? 'Someone'} ',
                          style: LightAppStyle.email.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 14.sp, color: Colors.black),
                        ),
                        TextSpan(
                          text: notification.message ?? '',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    HandlerFunctions.formatSmartDate(
                        notification.createdAt ?? ''),
                    style: LightAppStyle.email.copyWith(
                      color: Colors.black54,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}