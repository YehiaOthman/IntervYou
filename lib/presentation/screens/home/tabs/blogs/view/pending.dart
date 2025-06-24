import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/pending_card_item.dart';

import '../../../../../../core/colors_manager.dart';
import '../../../../../../core/routes_manger.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.pushNamed(context, RoutesManger.userInfoProfile),
                child: PendingCardItem()),
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
