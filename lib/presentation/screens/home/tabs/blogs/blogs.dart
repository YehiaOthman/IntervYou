import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/post_item_widget.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/widgets.dart';

import '../../../../../config/styles/light_app_style.dart';
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
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: blogsHeader(),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorsManger.semiBlack,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.r),
                    topRight: Radius.circular(35.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      TabBar(
                        indicatorColor: ColorsManger.secondaryColor,
                        unselectedLabelColor: Colors.white.withOpacity(0.6),
                        dividerColor: Colors.transparent,
                        labelColor: ColorsManger.secondaryColor,
                        labelStyle: LightAppStyle.email,
                        isScrollable: false,
                        tabs: const [
                          Tab(text: 'Posts'),
                          Tab(text: 'Network'),
                          Tab(text: 'Chat'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20.h),
                                TextFormField(
                                    style: LightAppStyle.email.copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.sp),
                                    cursorColor: ColorsManger.secondaryColor,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.image,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.emoji_emotions,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      hintText: 'Write something....',
                                      hintStyle: LightAppStyle.email.copyWith(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 14.sp),
                                      fillColor: Colors.black.withOpacity(0.1),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.r),
                                        borderSide: BorderSide(
                                          color: ColorsManger.secondaryColor,
                                          width: 1.w,
                                        ),
                                      ),
                                    )),
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
                            Center(
                                child: Text('Network Content',
                                    style: TextStyle(color: Colors.white))),
                            Center(
                                child: Text('Chat Content',
                                    style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
