// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intervyou_app/learn_provider/learn_provider.dart';
// import 'package:intervyou_app/presentation/screens/home/tabs/learn/widget/widget.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../config/styles/light_app_style.dart';
// import '../../../../../../core/colors_manager.dart';
// import '../../../../../../core/routes_manger.dart';
// import '../../home_tab/widgets/widgets.dart';
// import '../view/road_map.dart';
//
// class LearnBody extends StatefulWidget {
//   const LearnBody({super.key});
//
//   @override
//   State<LearnBody> createState() => _LearnBodyState();
// }
//
// class _LearnBodyState extends State<LearnBody> {
//
//  late var viewModel ;
//
//   @override
// void didChangeDependencies() {
//     viewModel = Provider.of<LearnViewModel>(context);
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: REdgeInsets.only(left: 20, right: 20),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 45.h),
//             learnHeader(),
//             SizedBox(height: 15.h),
//             GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (context) => SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.7,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20.r),
//                           topRight: Radius.circular(20.r),
//                         ),
//                         child: RoadMap()),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: 365.w,
//                 decoration: BoxDecoration(
//                   color: ColorsManger.newSecondaryColor.withOpacity(0.08),
//                   borderRadius: BorderRadius.circular(25.r),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Padding(
//                       padding:
//                           REdgeInsets.symmetric(vertical: 15, horizontal: 22),
//                       child: Text(
//                         'Road Map',
//                         style: LightAppStyle.email.copyWith(
//                           color: ColorsManger.newSecondaryColor,
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: REdgeInsets.symmetric(horizontal: 15),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(25.r),
//                         ),
//                         child: Padding(
//                           padding: REdgeInsets.all(15),
//                           child: Column(
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       SizedBox(height: 12.h),
//                                       Container(
//                                         width: 22.w,
//                                         height: 22.h,
//                                         decoration: BoxDecoration(
//                                           color: ColorsManger.newSecondaryColor
//                                               .withOpacity(0.4),
//                                           border: Border.all(
//                                             color:
//                                                 ColorsManger.newSecondaryColor,
//                                             width: 1.5,
//                                           ),
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: Center(
//                                           child: Container(
//                                             width: 12.w,
//                                             height: 12.h,
//                                             decoration: BoxDecoration(
//                                               color: ColorsManger
//                                                   .newSecondaryColor,
//                                               shape: BoxShape.circle,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         width: 2.w,
//                                         height: 80.h,
//                                         color: ColorsManger.newSecondaryColor,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(width: 10.w),
//                                   Expanded(
//                                     child: Container(
//                                       padding: REdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         color: Colors.transparent,
//                                         borderRadius:
//                                             BorderRadius.circular(35.r),
//                                         border: Border.all(
//                                             color:
//                                                 ColorsManger.newSecondaryColor,
//                                             width: 2),
//                                       ),
//                                       child: Padding(
//                                         padding: REdgeInsets.only(left: 10),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'title',
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             Text(
//                                               'description',
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                   color: Colors.black
//                                                       .withOpacity(0.5),
//                                                   fontSize: 13,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Container(
//                                         width: 22.w,
//                                         height: 22.h,
//                                         decoration: BoxDecoration(
//                                           color: Colors.transparent,
//                                           border: Border.all(
//                                             color:
//                                                 ColorsManger.newSecondaryColor,
//                                             width: 1.5,
//                                           ),
//                                           shape: BoxShape.circle,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(width: 10.w),
//                                   Expanded(
//                                     child: Container(
//                                       padding: REdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         color: Colors.transparent,
//                                         borderRadius:
//                                             BorderRadius.circular(35.r),
//                                         border: Border.all(
//                                             color:
//                                                 ColorsManger.newSecondaryColor,
//                                             width: 2),
//                                       ),
//                                       child: Padding(
//                                         padding: REdgeInsets.only(left: 10),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'title',
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             Text(
//                                               'description',
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                   color: Colors.black
//                                                       .withOpacity(0.5),
//                                                   fontSize: 13,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 25.h),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 15.h),
//             Container(
//               width: 365.w,
//               decoration: BoxDecoration(
//                 color: ColorsManger.newSecondaryColor.withOpacity(0.08),
//                 borderRadius: BorderRadius.circular(25.r),
//               ),
//               child: Padding(
//                 padding: REdgeInsets.all(22),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Today’s milestones',
//                       style: LightAppStyle.email.copyWith(
//                         color: ColorsManger.newSecondaryColor,
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.29,
//                       width: double.infinity,
//                       child: GridView(
//                           physics: NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   crossAxisSpacing: 10.w,
//                                   mainAxisSpacing: 10.h,
//                                   childAspectRatio: 1.5),
//                           children: List.generate(
//                             4,
//                             (index) =>
//                                 milestoneCard(Colors.red, 'Arrays', 7, 17),
//                           )),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           'Edit goals',
//                           style: LightAppStyle.email.copyWith(
//                               color: ColorsManger.newSecondaryColor,
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 15.h),
//             Container(
//               width: 365.w,
//               decoration: BoxDecoration(
//                 color: ColorsManger.newSecondaryColor.withOpacity(0.08),
//                 borderRadius: BorderRadius.circular(25.r),
//               ),
//               child: Padding(
//                 padding: REdgeInsets.all(22),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text('Quiz and Test',
//                             style: LightAppStyle.email.copyWith(
//                               color: ColorsManger.newSecondaryColor,
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w500,
//                             )),
//                         Spacer(),
//                         Text(
//                           '0',
//                           style: LightAppStyle.email.copyWith(
//                               color: ColorsManger.newSecondaryColor,
//                               fontSize: 22.sp,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text('/2',
//                             style: LightAppStyle.email.copyWith(
//                               color: ColorsManger.newSecondaryColor
//                                   .withOpacity(0.5),
//                               fontSize: 22.sp,
//                             ))
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//                     GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, RoutesManger.quiz);
//                         },
//                         child: quizItemWidget()),
//                     SizedBox(height: 20.h),
//                     quizItemWidget()
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 100.h),
//           ],
//         ),
//       ),
//     );
//   }
// }
