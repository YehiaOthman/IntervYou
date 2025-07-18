import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/assets_manager.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({super.key, required this.name, required this.imageUrl});
  final String name;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 23.r,
          backgroundImage: imageUrl != null
              ? NetworkImage("https://intervyouquestions.runasp.net$imageUrl")
              : const AssetImage(AssetsManager.guestPp) as ImageProvider,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 13.sp,
              ),
            ),
            Text(
              name,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
        const Spacer(),
        Consumer<BlogsViewModel>(
          builder: (context, viewModel, child) {
            final unreadCount = viewModel.unreadNotificationCount?.unreadCount ?? 0;
            return InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, RoutesManger.notifications),
              child: Stack(
                children: [
                  Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 15.w,
                          minHeight: 15.h,
                        ),
                        child: Center(
                            child: Text(
                              unreadCount.toString(),
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 10.sp),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}