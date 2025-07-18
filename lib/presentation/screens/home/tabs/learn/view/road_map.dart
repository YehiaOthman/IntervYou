import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';

import 'package:provider/provider.dart';

import '../../../../../../config/styles/light_app_style.dart';

import '../view_model/learn_provider.dart';

class RoadMap extends StatefulWidget {
  const RoadMap({
    super.key,
  });

  @override
  State<RoadMap> createState() => _RoadMapState();
}

class _RoadMapState extends State<RoadMap> {
  late LearnViewModel vm;

  @override
  void didChangeDependencies() {
    vm = ModalRoute.of(context)!.settings.arguments as LearnViewModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<LearnViewModel>.value(
        value: vm,
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Road Map',
                style: LightAppStyle.email.copyWith(
                  color: ColorsManger.newSecondaryColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: vm.topics.length,
                  itemBuilder: (context, index) {
                    final topic = vm.topics[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 22.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                color: vm.currentTopicIndex == index
                                    ? ColorsManger.newSecondaryColor
                                        .withOpacity(0.5)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: ColorsManger.newSecondaryColor,
                                  width: 1.5,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: vm.currentTopicIndex == index
                                  ? Center(
                                      child: Container(
                                        width: 12.w,
                                        height: 12.h,
                                        decoration: BoxDecoration(
                                          color: ColorsManger.newSecondaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            if (index != vm.topics.length - 1)
                              Container(
                                width: 2.w,
                                height: 60.h,
                                color: ColorsManger.newSecondaryColor,
                              ),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        // In road_map.dart -> ListView.builder -> Row

                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: vm.currentTopicIndex == index
                                      ? ColorsManger.newSecondaryColor
                                      : ColorsManger.newSecondaryColor
                                      .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(35.r),
                                  border: Border.all(
                                    color: ColorsManger.newSecondaryColor
                                        .withOpacity(0.5),
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: REdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: REdgeInsets.all(8.0),
                                        child: Text(
                                          topic.name ?? '',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: vm.currentTopicIndex == index
                                                ? Colors.white
                                                : Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              if (topic.recommendedFocus ?? false)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: REdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(35.r),
                                        bottomLeft: Radius.circular(15.r),
                                      ),
                                    ),
                                    child: Text(
                                      'FOCUS',
                                      style: LightAppStyle.email.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
