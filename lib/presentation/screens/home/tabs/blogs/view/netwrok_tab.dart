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
  // REMOVE the viewModel and list instances from here.
  // Let the Consumer manage it.

  // Use initState for one-time setup.
  @override
  void initState() {
    super.initState();
    // Use a post-frame callback to safely access the provider
    // after the first frame has been built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get the provider but DO NOT LISTEN.
      // We only want to call the function once.
      Provider.of<BlogsViewModel>(context, listen: false).fetchConnectionSuggestions();
    });
  }

  // REMOVE didChangeDependencies. It's not needed for this.

  @override
  Widget build(BuildContext context) {
    // Let the Consumer handle getting the ViewModel and rebuilding on change.
    return Consumer<BlogsViewModel>(
      builder: (context, viewModel, child) {
        // Now, you get the viewModel directly from the builder.
        // It will always be the latest, correct instance.

        if (viewModel.suggestionConnectionsLoading && viewModel.suggestionConnections.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManger.newSecondaryColor,
            ),
          );
        }

        // You don't need the local `suggestionsConnections` variable anymore.
        // Just use `viewModel.suggestionConnections` directly.
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
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      // Note: It's better not to pass the whole viewModel in arguments
                      // if the destination screen can access it with Provider.of itself.
                      // But for now, this is fine.
                      final argumentsModel = UserArgumentsModel(suggestionsConnections[index].userId ?? '', viewModel);
                      Navigator.pushNamed(context, RoutesManger.userInfoProfile, arguments: argumentsModel);
                    },
                    child: ConnectionRequestCardItem(userInfo: suggestionsConnections[index])),
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