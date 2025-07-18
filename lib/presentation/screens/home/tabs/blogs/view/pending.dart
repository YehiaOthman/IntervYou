import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/pending_card_item.dart';

import '../../../../../../core/colors_manager.dart';
import '../../../../../../core/routes_manger.dart';
import '../../../../../../data/blogs_models/connections/connections_items.dart';

class Pending extends StatefulWidget {
   Pending({super.key, required this.pendingConnections});

  @override
  State<Pending> createState() => _PendingState();
  List<ConnectionsItem> pendingConnections = [];
}

class _PendingState extends State<Pending> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(widget.pendingConnections.isEmpty)
          Center(child: Text('No Pending Connections',style: TextStyle(color: ColorsManger.newSecondaryColor),),)
        else
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => PendingCardItem(pendingUser: widget.pendingConnections[index],),
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
            itemCount: widget.pendingConnections.length,
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
