// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/pending.dart';
// import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/sent.dart';
//
// import '../../../../../../config/styles/light_app_style.dart';
// import '../../../../../../core/colors_manager.dart';
//
//
// class Invitations extends StatefulWidget {
//   const Invitations({super.key});
//
//   @override
//   State<Invitations> createState() => _InvitationsState();
// }
//
// class _InvitationsState extends State<Invitations> with TickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorsManger.newSecondaryColor,
//         title: Text(
//           'Invitations',
//           style: LightAppStyle.email.copyWith(
//             color: Colors.white,
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         iconTheme:  IconThemeData(color: Colors.white),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(30.r),
//             bottomRight: Radius.circular(30.r),
//           ),
//         ),
//         toolbarHeight: 75.h,
//         actions: [
//           Padding(
//             padding: REdgeInsets.only(right: 20),
//             child:  Icon(Icons.search),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: Colors.white,
//             child: TabBar(
//               controller: _tabController,
//               labelColor: Colors.black,
//               dividerColor: Colors.transparent,
//               unselectedLabelColor: Colors.black.withOpacity(0.5),
//               indicatorColor: Colors.black,
//               labelStyle: LightAppStyle.email.copyWith(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//               padding: REdgeInsets.symmetric(horizontal: 30),
//               tabs:  [
//                 Tab(text: 'Pending'),
//                 Tab(text: 'Sent'),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children:  [
//                 Pending(),
//                 Sent(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/pending.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/sent.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/colors_manager.dart';


class Invitations extends StatefulWidget {
  const Invitations({super.key});

  @override
  State<Invitations> createState() => _InvitationsState();
}

class _InvitationsState extends State<Invitations> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManger.newSecondaryColor,
          title: Text(
            'Invitations',
            style: LightAppStyle.email.copyWith(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme:  IconThemeData(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
          ),
          actions: [
            Padding(
              padding: REdgeInsets.only(right: 20),
              child:  Icon(Icons.search),
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
              dividerColor: Colors.transparent,
              unselectedLabelColor: Colors.white.withOpacity(0.5),
              indicatorColor: Colors.white,
              labelStyle: LightAppStyle.email.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              padding: REdgeInsets.symmetric(horizontal: 30),
            tabs:  [
              Tab(text: 'Pending'),
              Tab(text: 'Sent'),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            Pending(),
            Sent(),
          ],
        ),
      ),
    );
  }
}
