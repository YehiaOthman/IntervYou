import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/home_tab/widgets/widgets.dart';
import '../../../../../../core/colors_manager.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Widget> tasks = List.generate(10, (_) => buildCardItem());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 230.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManger.newSecondaryColor,
              ),
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    homeHeader(),
                    SizedBox(height: 40.h),
                    Text(
                      'Continue Your',
                      style: LightAppStyle.email.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Learning Adventure!',
                          style: LightAppStyle.email.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Text(
                    'Current Topics',
                    style: LightAppStyle.email.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'See all',
                    style: LightAppStyle.email.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: ColorsManger.newSecondaryColor,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 185.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: tasks.length,
                padding: REdgeInsets.symmetric(horizontal: 10),
                separatorBuilder: (_, __) => SizedBox(
                  width: 8.w,
                ),
                itemBuilder: (_, index) => tasks[index],
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Daily Quizzes',
                style: LightAppStyle.email.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
