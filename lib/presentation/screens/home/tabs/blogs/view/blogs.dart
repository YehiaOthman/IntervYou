import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/chat_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/netwrok_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/posts_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/routes_manger.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  String currentUserId = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }


  Future<void> _loadInitialData() async {

    final viewModel = Provider.of<BlogsViewModel>(context, listen: false);
    const storage = FlutterSecureStorage();
    final userId = await storage.read(key: 'user_id');
    if(mounted){
      setState(() {
        currentUserId = userId ?? '';
      });
    }
    if (userId != null && mounted) {
      viewModel.fetchUserProfile(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogsViewModel>(
      builder: (context, viewModel, child) {
        final userProfile = viewModel.userProfile;

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [

                  SliverAppBar(
                    backgroundColor: ColorsManger.newSecondaryColor,
                    floating: true,
                    snap: true,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    shadowColor: Colors.black,
                    surfaceTintColor: ColorsManger.newWhite,
                    toolbarHeight: 75.h,
                    automaticallyImplyLeading: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, RoutesManger.userProfile,arguments: currentUserId),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorsManger.newWhite,
                                width: 1.5,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: (userProfile?.profilePictureUrl != null && userProfile!.profilePictureUrl!.isNotEmpty
                                  ? NetworkImage('https://intervyouquestions.runasp.net${userProfile.profilePictureUrl!}')
                                  : const AssetImage(AssetsManager.guestPp)) as ImageProvider,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBar(
                            labelColor: ColorsManger.newWhite,
                            dividerColor: Colors.transparent,
                            unselectedLabelColor: Colors.white.withOpacity(0.4),
                            indicatorColor: ColorsManger.newWhite,
                            labelStyle: LightAppStyle.email,
                            tabs: const [
                              Tab(text: 'Posts'),
                              Tab(text: 'Network'),
                              Tab(text: 'Chat'),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, RoutesManger.addPost,arguments: viewModel),
                          child: Container(
                            padding: REdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            child: Icon(Icons.add, color: ColorsManger.newWhite),
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: const TabBarView(
                children: [PostsTab(), NetwrokTab(), ChatTab()],
              ),
            ),
          ),
        );
      },
    );
  }
}