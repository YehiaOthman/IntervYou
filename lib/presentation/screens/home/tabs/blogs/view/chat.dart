import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view/netwrok_tab.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/message.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/assets_manager.dart';
import '../../../../../../core/colors_manager.dart';
import '../../../../../../data/blogs_models/chat/conversation_other_user_id_item.dart';
import '../view_model/blogs_viewmodel.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late UserArgumentsModel arguments;
  final TextEditingController _messageController = TextEditingController();
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      arguments =
          ModalRoute.of(context)?.settings.arguments as UserArgumentsModel;
      _initializeChat();
      _isInitialized = true;
    }
  }

  Future<void> _initializeChat() async {
    final viewModel = arguments.viewModel;
    const storage = FlutterSecureStorage();
    final userId = await storage.read(key: 'user_id');
    final token = await storage.read(key: 'access_token');

    if (userId != null && token != null && mounted) {
      viewModel.currentUserId = userId;
      viewModel.initializeSignalRConnection(token);
      viewModel.fetchConversationWithUser(arguments.id);
    }
  }

  @override
  void dispose() {
    final viewModel = Provider.of<BlogsViewModel>(context, listen: false);
    viewModel.currentOpenChatUserId = null;
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final viewModel = arguments.viewModel;
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      viewModel.sendMessage(text, arguments.id);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        (ModalRoute.of(context)?.settings.arguments as UserArgumentsModel)
            .viewModel;

    return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<BlogsViewModel>(builder: (context, value, child) {
          String otherUserName = 'User';
          String? otherUserPicUrl;

          final otherUserMessage = value.conversationMessages.firstWhere(
            (msg) => msg.senderId != value.currentUserId,
            orElse: () => ConversationOtherUserIdItem(),
          );

          otherUserName = otherUserMessage.senderName ?? 'User';
          otherUserPicUrl = otherUserMessage.senderProfilePictureUrl;

          return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorsManger.newSecondaryColor,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      backgroundImage: (otherUserPicUrl != null &&
                              otherUserPicUrl.isNotEmpty
                          ? NetworkImage(
                              'https://intervyouquestions.runasp.net$otherUserPicUrl')
                          : AssetImage(AssetsManager.guestPp)) as ImageProvider,
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(otherUserName,
                            style: LightAppStyle.email.copyWith(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600)),
                        Text('Active',
                            style: LightAppStyle.email.copyWith(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
                actions: [
                  Padding(
                      padding: REdgeInsets.only(right: 20),
                      child: Icon(Icons.more_horiz, size: 28.sp))
                ],
                iconTheme: const IconThemeData(color: Colors.white),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r))),
                toolbarHeight: 75.h,
              ),
              body: Padding(
                padding: REdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  children: [
                    if (value.conversationLoading &&
                        value.conversationMessages.isEmpty)
                      const Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: ColorsManger.newSecondaryColor)))
                    else
                      Expanded(
                        child: ListView.separated(
                          reverse: true,
                          itemBuilder: (context, index) {
                            final reversedIndex =
                                value.conversationMessages.length - 1 - index;
                            final message =
                                value.conversationMessages[reversedIndex];
                            final bool isSentByMe =
                                message.senderId == value.currentUserId;

                            return Row(
                              mainAxisAlignment: isSentByMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Message(
                                    conversationOtherUserIdItem: message,
                                    isSentByMe: isSentByMe)
                              ],
                            );
                          },
                          itemCount: value.conversationMessages.length,
                          padding: REdgeInsets.symmetric(vertical: 16),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 15.h),
                        ),
                      ),
                    TextField(
                      controller: _messageController,
                      onSubmitted: (_) => _sendMessage(),
                      style: LightAppStyle.email
                          .copyWith(color: Colors.black, fontSize: 15.sp),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.attach_file),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: _sendMessage),
                        fillColor: Colors.grey.withOpacity(0.2),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.w)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        hintText: 'Type something...',
                        hintStyle: LightAppStyle.email.copyWith(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
              ));
        }));
  }
}
