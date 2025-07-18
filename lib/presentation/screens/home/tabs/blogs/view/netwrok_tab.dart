import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/data/blogs_models/user_info_item.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/connection_request_card_item.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/styles/light_app_style.dart';

class NetwrokTab extends StatefulWidget {
  const NetwrokTab({super.key});

  @override
  State<NetwrokTab> createState() => _NetwrokTabState();
}

class _NetwrokTabState extends State<NetwrokTab> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BlogsViewModel>(context, listen: false).fetchConnectionSuggestions();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<BlogsViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.suggestionConnectionsLoading && viewModel.suggestionConnections.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManger.newSecondaryColor,
            ),
          );
        }

        final suggestionsConnections = viewModel.suggestionConnections;

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: REdgeInsets.symmetric(vertical: 12, horizontal: 15),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, RoutesManger.invitations, arguments: viewModel),
                  child: Row(
                    children: [
                      Text(
                        'Invitations',
                        style: LightAppStyle.email.copyWith(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
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
                itemBuilder: (context, index) => ConnectionRequestCardItem(userInfo: suggestionsConnections[index]),
                padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
                itemCount: suggestionsConnections.length,
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
      },
    );
  }
}

class UserArgumentsModel {
  final String id;
  final BlogsViewModel viewModel;
  UserArgumentsModel(this.id, this.viewModel);
}