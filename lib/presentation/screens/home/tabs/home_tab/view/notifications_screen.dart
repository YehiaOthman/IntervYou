import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/colors_manager.dart';
import '../widgets/notification_item_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BlogsViewModel>(context, listen: false).fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.newWhite,
      appBar: AppBar(
        backgroundColor: ColorsManger.newSecondaryColor,
        title: Text('Notifications',
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
      body: Consumer<BlogsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.notificationsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                  color: ColorsManger.newSecondaryColor),
            );
          }

          if (viewModel.notifications.isEmpty) {
            return Center(
              child: Text(
                'You have no notifications.',
                style: LightAppStyle.email.copyWith(
                  color: Colors.grey,
                  fontSize: 16.sp,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: REdgeInsets.symmetric(vertical: 10),
            itemCount: viewModel.notifications.length,
            itemBuilder: (context, index) {
              final notification = viewModel.notifications[index];
              return NotificationItemWidget(notification: notification);
            },
            separatorBuilder: (context, index) => Divider(
              height: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.grey.shade300,
            ),
          );
        },
      ),
    );
  }
}