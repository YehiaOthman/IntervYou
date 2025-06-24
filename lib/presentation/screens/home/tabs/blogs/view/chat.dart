import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/message.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

List<Message> messages = [
  Message(isSentByMe: false),
  Message(isSentByMe: true),
  Message(isSentByMe: false),
  Message(isSentByMe: true),
  Message(isSentByMe: false),
  Message(isSentByMe: true),
  Message(isSentByMe: false),
  Message(isSentByMe: true),
  Message(isSentByMe: false),
  Message(isSentByMe: true),
  Message(isSentByMe: false),
  Message(isSentByMe: true),
  Message(isSentByMe: false),
];

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManger.newSecondaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            ClipRRect(
              child: Image.asset(
                AssetsManager.pp,
                width: 45.w,
                height: 45.h,
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Yehia Othman',
                    style: LightAppStyle.email.copyWith(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600
                    )),
                Text('Active 20 min ago',
                    style: LightAppStyle.email.copyWith(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400
                )),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: REdgeInsets.only(right: 20),
            child:  Icon(Icons.more_horiz,size: 28.sp,),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
        toolbarHeight: 75.h,

      ),
      body: Padding(
        padding:  REdgeInsets.only(left: 16,right: 16,bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: messages[index].isSentByMe?MainAxisAlignment.start:MainAxisAlignment.end,
                      children: [
                        messages[index],
                      ],
                    );
                  },
                  itemCount: messages.length,
                padding: REdgeInsets.only(top: 16,bottom: 16),
                separatorBuilder: (context, index) => SizedBox(height: 15.h),
              ),
            ),
            TextField(

              style: LightAppStyle.email.copyWith(
                  color: Colors.black,
                  fontSize: 15.sp
              ),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.attach_file),
                suffixIcon: Icon(Icons.send),
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.transparent, width: 2.w)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent
                    )
                ),
                hintText: 'Type something...',
                hintStyle: LightAppStyle.email.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 15.sp
                ),

              ),),
          ],
        ),
      ),
    );
  }
}
