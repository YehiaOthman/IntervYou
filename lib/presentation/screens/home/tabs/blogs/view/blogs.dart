import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/chat_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/netwrok_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/post_tiem_widget_v2.dart';
import '../../../../../../core/assets_manager.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  String currentTab = 'Posts';
  final List<String> tabs = ['Posts', 'Network', 'Chat'];
  List<Widget> posts = [
    PostItemWidgetV2(
        postContent:
            '''Struggling to kickstart your day? Try these 5 quick tips to own your mornings:

Wake up 30 minutes earlier.

Drink a full glass of water.

Avoid checking your phone immediately.

Write down 3 goals for the day.

Move your body – even 5 minutes of stretching helps.
Start small, stay consistent, and you’ll notice the difference within a week! 🌞💪'''),
    PostItemWidgetV2(
        postContent:
            '''Struggling to kickstart your day? Try these 5 quick tips to own your mornings:

Wake up 30 minutes earlier.

Drink a full glass of water.

Avoid checking your phone immediately.

Write down 3 goals for the day.

Move your body – even 5 minutes of stretching helps.
Start small, stay consistent, and you’ll notice the difference within a week! 🌞💪'''),
    PostItemWidgetV2(postContent: '''العنوان: ٣ عادات صباحية لتبدأ يومك بنشاط
المحتوى:
هل تشعر بالخمول في الصباح؟ جرب هذه العادات السهلة لتبدأ يومك بطاقة إيجابية:
١. استيقظ مبكرًا بـ ٢٠ دقيقة.
٢. اغسل وجهك واشرب كوب ماء بارد.
٣. رتب سريرك فورًا – سيعطيك إحساس بالإنجاز.
ابدأ بخطوة صغيرة، وراقب التغيير في طاقتك طوال اليوم! ☀️✨'''),
    PostItemWidgetV2(
        postContent:
            '''Struggling to kickstart your day? Try these 5 quick tips to own your mornings:

Wake up 30 minutes earlier.

Drink a full glass of water.

Avoid checking your phone immediately.

Write down 3 goals for the day.

Move your body – even 5 minutes of stretching helps.
Start small, stay consistent, and you’ll notice the difference within a week! 🌞💪'''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        toolbarHeight: 80.h,
        title: Row(
          children: [
            Image.asset(AssetsManager.appBarLogo, height: 30.h),
            Spacer(),
            Container(
              padding: REdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: ColorsManger.newSecondaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(25.r),
                value: currentTab,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      currentTab = value;
                    });
                  }
                },
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
                items: tabs.map((tab) {
                  return DropdownMenuItem<String>(
                    value: tab,
                    child: Text(
                      tab,
                      style: LightAppStyle.email
                          .copyWith(color: Colors.black, fontSize: 16.sp),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 10.w),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image.asset(
                    AssetsManager.pp,
                    width: 45.w,
                    height: 45.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 2.w,
                  top: 2.h,
                  child: Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.white, width: 1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Expanded(child: _buildTabContent()),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 'Network':
        return NetwrokTab();
      case 'Chat':
        return ChatTab();
      case 'Posts':
      default:
        return ListView.separated(
          itemBuilder: (context, index) => posts[index],
          separatorBuilder: (context, index) => SizedBox(height: 20.h),
          itemCount: posts.length,
        );
    }
  }
}
