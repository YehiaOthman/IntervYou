import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/colors_manager.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';

class PostItemWidget extends StatefulWidget {
  PostItemWidget({super.key, required this.postContent});

  @override
  _PostItemWidgetState createState() => _PostItemWidgetState();
  String postContent;
}

class _PostItemWidgetState extends State<PostItemWidget> {
  bool isAnswered = false;
  bool isVotedUp = false;
  bool isVotedDown = false;
  int votes = 50;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 175.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              color: Colors.black.withOpacity(0.2),
            ),
            padding: EdgeInsets.only(left: 65.w, right: 10.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.asset(
                        AssetsManager.pp,
                        width: 35.w.clamp(30, 50),
                        height: 35.h.clamp(30, 50),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yehia Othman',
                          style: LightAppStyle.email.copyWith(fontSize: 16.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '9:12 PM',
                          style: LightAppStyle.email.copyWith(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 10.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    PopupMenuButton<int>(
                      color: ColorsManger.semiBlack,
                      popUpAnimationStyle: AnimationStyle(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInCirc,
                        reverseCurve: Curves.easeInCirc,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        side: BorderSide(
                            color: ColorsManger.secondaryColor.withOpacity(0.3),
                            width: 2.w),
                      ),
                      icon: Icon(Icons.more_horiz,
                          color: Colors.white.withOpacity(0.4), size: 25.sp),
                      elevation: 6,
                      onSelected: (value) {
                        if (value == 1) {
                          print("Report clicked");
                        } else if (value == 2) {
                          print("Delete clicked");
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.share_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10.w),
                              Text('Share', style: LightAppStyle.email),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Row(
                            children: [
                              Icon(
                                Icons.block_flipped,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10.w),
                              Text('Block', style: LightAppStyle.email),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Row(
                            children: [
                              Icon(
                                Icons.report_gmailerrorred,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10.w),
                              Text('Report', style: LightAppStyle.email),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  widget.postContent,
                  style: LightAppStyle.email.copyWith(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 18.h),
                Row(
                  children: [
                    InkWell(
                      onTap: () => setState(() => isAnswered = !isAnswered),
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          color: isAnswered
                              ? ColorsManger.secondaryColor.withOpacity(0.4)
                              : Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: isAnswered
                            ? Center(
                                child: Icon(Icons.check,
                                    color: ColorsManger.secondaryColor,
                                    size: 16.sp))
                            : null,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      isAnswered ? 'Answered' : 'Mark as answered',
                      style: LightAppStyle.email.copyWith(
                        color: isAnswered
                            ? ColorsManger.secondaryColor
                            : Colors.white.withOpacity(0.4),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 50.w,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  bottomLeft: Radius.circular(25.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => toggleUpVote(),
                    child: Icon(
                      Icons.arrow_upward,
                      color: isVotedUp
                          ? ColorsManger.secondaryColor
                          : Colors.white,
                      size: 30.sp,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: Text(
                      votes.toString(),
                      style: LightAppStyle.email.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => toggleDownVote(),
                    child: Icon(
                      Icons.arrow_downward,
                      color: isVotedDown
                          ? ColorsManger.secondaryColor
                          : Colors.white,
                      size: 30.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void toggleUpVote() {
    setState(() {
      if (isVotedUp) {
        votes--;
        isVotedUp = false;
      } else {
        if (isVotedDown) {
          votes++;
          isVotedDown = false;
        }
        votes++;
        isVotedUp = true;
      }
    });
  }

  void toggleDownVote() {
    setState(() {
      if (isVotedDown) {
        votes++;
        isVotedDown = false;
      } else {
        if (isVotedUp) {
          votes--;
          isVotedUp = false;
        }
        votes--;
        isVotedDown = true;
      }
    });
  }
}
