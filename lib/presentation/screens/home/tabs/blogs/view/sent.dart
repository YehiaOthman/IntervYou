import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/colors_manager.dart';
import '../../../../../../core/routes_manger.dart';
import '../widgets/connection_request_card_item.dart';

class Sent extends StatefulWidget {
  const Sent({super.key});

  @override
  State<Sent> createState() => _SentState();
}

class _SentState extends State<Sent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.pushNamed(context, RoutesManger.userInfoProfile),
                child: ConnectionRequestCardItem(action: 'Cancel',)),
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
            itemCount: 20,
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
          ),
        )
      ],
    );
  }
}
