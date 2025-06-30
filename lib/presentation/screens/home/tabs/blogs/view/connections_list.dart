import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/connection_item.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/colors_manager.dart';

class ConnectionsList extends StatelessWidget {
  const ConnectionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogsViewModel>(
      builder: (context, viewModel, child) {
        final connections = viewModel.connections;
        return Scaffold(
          backgroundColor: ColorsManger.newWhite,
          appBar: AppBar(
            backgroundColor: ColorsManger.newSecondaryColor,
            title: Text('Connections (${connections.length})',
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
          body: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 45.h,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey.withOpacity(0.2),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                              const BorderSide(color: Colors.transparent)),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
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
                  SizedBox(height: 10.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        itemBuilder: (context, index) =>
                            ConnectionItem(userProfile: connections[index]),
                        itemCount: connections.length,
                        padding: REdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15.h),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}