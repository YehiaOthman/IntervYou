import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/chat_user_item.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/colors_manager.dart';
import '../../../../../../core/routes_manger.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 15.h),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.grey.withOpacity(0.2),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.transparent)),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30.sp,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  hintText: 'Search...',
                  hintStyle: LightAppStyle.email.copyWith(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp)),
            ),
          ),
          ListView.separated(
            itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.pushNamed(context, RoutesManger.userInfoProfile),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, RoutesManger.chat),
                    child: ChatUserItem())),
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
            itemCount: 10,
            shrinkWrap: true,
            physics:  NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: 15.h),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: ColorsManger.newSecondaryColor.withOpacity(0.2),
                  ),
                  SizedBox(height: 15.h),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
