import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/connection_request_card_item.dart';

import '../../../../../../config/styles/light_app_style.dart';

class NetwrokTab extends StatefulWidget {
  const NetwrokTab({super.key});

  @override
  State<NetwrokTab> createState() => _NetwrokTabState();
}

class _NetwrokTabState extends State<NetwrokTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, RoutesManger.invitations),
              child: Row(
                children: [
                  Text(
                    'Invitations',
                    style: LightAppStyle.email.copyWith(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 28.sp,
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 2.h,
            color: ColorsManger.newSecondaryColor.withOpacity(0.2),
          ),
          ListView.separated(
            itemBuilder: (context, index) => InkWell(
              onTap: () => Navigator.pushNamed(context, RoutesManger.userInfoProfile),
                child: ConnectionRequestCardItem(action: 'Connect',)),
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
