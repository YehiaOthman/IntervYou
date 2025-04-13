import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/tab_bar_tabs/chat_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/tab_bar_tabs/netwrok_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/post_item_widget.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/widgets.dart';

import '../../../../../config/styles/light_app_style.dart';
import '../../../../../core/assets_manager.dart';
import '../../../../../core/colors_manager.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  List<Widget> posts = [
    PostItemWidget(
      postContent:
          'Once upon a time, in a distant kingdom, there was a brave knight who embarked on an epic journey to save the land from darkness.',
    ),
    PostItemWidget(
      postContent:
          '''In a world where technology evolves at an unprecedented pace, humanity finds itself at the crossroads of innovation and tradition. Every day, new discoveries reshape the way we interact, communicate, and build our future. From the vast reaches of artificial intelligence to the intricate details of quantum computing, the possibilities seem endless. Yet, amidst all this progress, the fundamental values of curiosity, perseverance, and creativity remain at the heart of every great achievement. As we look ahead, the question is not just about what we can create, but how we can use our knowledge to build a better, more connected world for generations to come."''',
    ),
    PostItemWidget(
      postContent:
          '''Flutter هو إطار عمل مفتوح المصدر تم تطويره بواسطة Google، ويستخدم لإنشاء تطبيقات متعددة المنصات (Cross-Platform) بقاعدة كود واحدة. يتيح للمطورين بناء تطبيقات لأنظمة التشغيل Android و iOS، بالإضافة إلى الويب وسطح المكتب، باستخدام لغة البرمجة Dart.''',
    ),
    PostItemWidget(
      postContent:
          '''In a world where technology evolves at an unprecedented pace, humanity finds itself at the crossroads of innovation and tradition. Every day, new discoveries reshape the way we interact, communicate, and build our future. From the vast reaches of artificial intelligence to the intricate details of quantum computing, the possibilities seem endless. Yet, amidst all this progress, the fundamental values of curiosity, perseverance, and creativity remain at the heart of every great achievement. As we look ahead, the question is not just about what we can create, but how we can use our knowledge to build a better, more connected world for generations to come."''',
    ),
    PostItemWidget(
      postContent:
          '''In a world where technology evolves at an unprecedented pace, humanity finds itself at the crossroads of innovation and tradition. Every day, new discoveries reshape the way we interact, communicate, and build our future. From the vast reaches of artificial intelligence to the intricate details of quantum computing, the possibilities seem endless. Yet, amidst all this progress, the fundamental values of curiosity, perseverance, and creativity remain at the heart of every great achievement. As we look ahead, the question is not just about what we can create, but how we can use our knowledge to build a better, more connected world for generations to come."''',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorsManger.semiBlack,
        body: Column(
          children: [
            SizedBox(height: 30.h),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(children: [
                          Image.asset(AssetsManager.pp, width: 55.w),
                          Positioned(
                            left: 4.w,
                            top: 3.h,
                            child: Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                    color: Colors.white, width: 1.w),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                          ),
                        ]),
                        Expanded(
                          child: IntrinsicWidth(
                            child: TabBar(
                              indicatorColor: ColorsManger.secondaryColor,
                              unselectedLabelColor:
                                  Colors.white.withOpacity(0.6),
                              dividerColor: Colors.transparent,
                              labelColor: ColorsManger.secondaryColor,
                              labelStyle: LightAppStyle.email.copyWith(
                                fontSize: 15.sp
                              ),
                              isScrollable: false,
                              splashFactory: NoSplash.splashFactory,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              tabs: const [
                                Tab(text: 'Posts'),
                                Tab(text: 'Network'),
                                Tab(text: 'Chat'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: ListView.separated(
                                      itemBuilder: (context, index) =>
                                          posts[index],
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                      itemCount: posts.length))
                            ],
                          ),
                          NetwrokTab(),
                          ChatTab()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
