import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/data/blogs_models/connections/SentConnections.dart';
import 'package:intervyou_app/data/blogs_models/connections/connections_items.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/cancel_connection_item.dart';

import '../../../../../../core/colors_manager.dart';
import '../../../../../../core/routes_manger.dart';
import '../widgets/connection_request_card_item.dart';

class Sent extends StatefulWidget {
   Sent({super.key, required this.sentConnections});

  @override
  State<Sent> createState() => _SentState();
  List<ConnectionsItem> sentConnections = [];
}

class _SentState extends State<Sent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(widget.sentConnections.isEmpty)
          Center(child: Text('No Sent Connections',style: TextStyle(color: ColorsManger.newSecondaryColor),),)
        else
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => CancelConnectionItem(SentUser: widget.sentConnections[index],),
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
            itemCount: widget.sentConnections.length,
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
