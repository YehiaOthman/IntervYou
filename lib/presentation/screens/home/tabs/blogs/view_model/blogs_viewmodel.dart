import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:intervyou_app/data/api_manager.dart';
import '../../../../../../data/blogs_models/Pagination.dart';
import '../../../../../../data/blogs_models/chat/conversation_item.dart';
import '../../../../../../data/blogs_models/chat/conversation_other_user_id_item.dart';
import '../../../../../../data/blogs_models/connections/ConnectionStatus.dart';
import '../../../../../../data/blogs_models/connections/connections_items.dart';
import '../../../../../../data/blogs_models/notifications/UnReadCountNotifications.dart';
import '../../../../../../data/blogs_models/notifications/notifications_Item.dart';
import '../../../../../../data/blogs_models/post/Comments.dart';
import '../../../../../../data/blogs_models/post/PostDetailsDm.dart';
import '../../../../../../data/blogs_models/post/posts_item.dart';
import '../../../../../../data/blogs_models/profile/Profile_dm.dart';
import '../../../../../../data/blogs_models/timeline/time_line_item.dart';
import '../../../../../../data/blogs_models/user_info_item.dart';

class BlogsViewModel extends ChangeNotifier {
  HubConnection? _hubConnection;
  String? currentUserId;
  String? currentOpenChatUserId;

  bool postsLoading = false;
  bool postsLoadingMore = false;
  String? postsError;
  List<PostsItem> posts = [];
  int _postsPage = 1;
  bool _postsHasNextPage = true;
  bool postDetailsLoading = false;
  String? postDetailsError;
  PostDetailsDm? postDetails;
  bool authorPostsLoading = false;
  bool authorPostsLoadingMore = false;
  String? authorPostsError;
  List<PostsItem> authorPosts = [];
  int _authorPostsPage = 1;
  bool _authorPostsHasNextPage = true;
  bool commentsLoading = false;
  bool commentsLoadingMore = false;
  String? commentsError;
  List<Comments> postComments = [];
  int _commentsPage = 1;
  bool _commentsHasNextPage = true;
  bool timelineLoading = false;
  bool timelineLoadingMore = false;
  String? timelineError;
  List<TimeLineItem> timelineItems = [];
  int _timelinePage = 1;
  bool _timelineHasNextPage = true;
  bool profileLoading = false;
  String? profileError;
  ProfileDataModel? userProfile;
  bool searchLoading = false;
  bool searchLoadingMore = false;
  String? searchError;
  List<UserInfoItem> searchResults = [];
  String _searchQuery = "";
  int _searchPage = 1;
  bool _searchHasNextPage = true;
  bool notificationsLoading = false;
  bool notificationsLoadingMore = false;
  String? notificationsError;
  List<NotificationsItem> notifications = [];
  int _notificationsPage = 1;
  bool _notificationsHasNextPage = true;
  bool unreadCountLoading = false;
  String? unreadCountError;
  UnReadCountNotifications? unreadNotificationCount;
  bool connectionsLoading = false;
  bool connectionsLoadingMore = false;
  String? connectionsError;
  List<UserInfoItem> connections = [];
  int _connectionsPage = 1;
  bool _connectionsHasNextPage = true;
  bool pendingConnectionsLoading = false;
  bool pendingConnectionsLoadingMore = false;
  String? pendingConnectionsError;
  List<ConnectionsItem> pendingConnections = [];
  int _pendingConnectionsPage = 1;
  bool _pendingConnectionsHasNextPage = true;
  bool sentConnectionsLoading = false;
  bool sentConnectionsLoadingMore = false;
  String? sentConnectionsError;
  List<ConnectionsItem> sentConnections = [];
  int _sentConnectionsPage = 1;
  bool _sentConnectionsHasNextPage = true;
  bool suggestionConnectionsLoading = false;
  bool suggestionConnectionsLoadingMore = false;
  String? suggestionConnectionsError;
  List<UserInfoItem> suggestionConnections = [];
  int _suggestionConnectionsPage = 1;
  bool _suggestionConnectionsHasNextPage = true;
  bool connectionStatusLoading = false;
  String? connectionStatusError;
  ConnectionStatus? connectionStatus;
  bool conversationLoading = false;
  bool conversationLoadingMore = false;
  String? conversationError;
  List<ConversationOtherUserIdItem> conversationMessages = [];
  int _conversationPage = 1;
  bool _conversationHasNextPage = true;
  bool allConversationsLoading = false;
  bool allConversationsLoadingMore = false;
  String? allConversationsError;
  List<ConversationsItem> allConversations = [];
  int _allConversationsPage = 1;
  bool _allConversationsHasNextPage = true;

  static const int _pageSize = 100;

  bool _checkHasNextPage(Pagination? pagination) {
    if (pagination == null || pagination.page == null || pagination.pages == null) return false;
    return pagination.page! < pagination.pages!;
  }

  Future<bool> createNewPost({required String title, required String content}) async {
    // ACT: Call the API
    final response = await ApiManger.createPost(title: title, content: content);

    // Check the result
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
      // REFRESH: On success, refetch the timeline
      await fetchTimeline();
      return true; // Return true for success
    }

    // If the response is null or the status code is not a success code...
    return false; // Return false for failure
  }

  Future<bool> updateExistingPost({required num postId, required String title, required String content}) async {
    final response = await ApiManger.updatePost(postId: postId, title: title, content: content);
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
      await fetchPostDetails(postId);
      await fetchTimeline();
      return true;
    }
    return false;
  }

  Future<void> deleteExistingPost(num postId) async {
    final response = await ApiManger.deletePost(postId);
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
      timelineItems.removeWhere((item) => item.sourceItemId == postId);
      notifyListeners();
    }
  }


  Future<bool> createCommentOnPost({required num postId, required String content}) async {
    final response = await ApiManger.createCommentOnPost(postId: postId, content: content);
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
      int postIndex = timelineItems.indexWhere((p) => p.sourceItemId == postId);
      if (postIndex != -1) {
        timelineItems[postIndex].blogPostCommentCount = (timelineItems[postIndex].blogPostCommentCount ?? 0) + 1;
      }

      await fetchPostDetails(postId);

      return true;
    }
    return false;
  }

  Future<void> deleteExistingComment(String commentId, int postId) async {
    final response = await ApiManger.deleteComment(commentId);
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
      postComments.removeWhere((c) => c.id == commentId);
      await fetchCommentsForPost(postId);
    }
  }

  Future<void> voteOnPost(num postId, num voteType) async {
    // --- Part 1: Optimistic update for PostDetails screen ---
    PostDetailsDm? originalPostDetails;
    if (postDetails != null && postDetails!.id == postId) {
      originalPostDetails = PostDetailsDm.fromJson(postDetails!.toJson());

      final oldVote = originalPostDetails.currentUserVote ?? 0;
      num upvoteChange = 0;
      num downvoteChange = 0;

      if (oldVote == 1) upvoteChange -= 1;
      if (oldVote == -1) downvoteChange -= 1;
      if (voteType == 1) upvoteChange += 1;
      if (voteType == -1) downvoteChange += 1;

      postDetails!.currentUserVote = voteType;
      postDetails!.upvotes = (postDetails!.upvotes ?? 0) + upvoteChange;
      postDetails!.downvotes = (postDetails!.downvotes ?? 0) + downvoteChange;
    }

    // --- Part 2: Optimistic update for Timeline screen ---
    int timelineIndex = timelineItems.indexWhere((p) => p.sourceItemId == postId);
    TimeLineItem? originalTimelineItem;
    if (timelineIndex != -1) {
      final post = timelineItems[timelineIndex];
      originalTimelineItem = TimeLineItem.fromJson(post.toJson()); // Assuming you have a toJson method

      final oldVote = originalTimelineItem.blogPostCurrentUserVote ?? 0;
      num upvoteChange = 0;
      num downvoteChange = 0;

      if (oldVote == 1) upvoteChange -= 1;
      if (oldVote == -1) downvoteChange -= 1;
      if (voteType == 1) upvoteChange += 1;
      if (voteType == -1) downvoteChange += 1;

      post.blogPostCurrentUserVote = voteType;
      post.blogPostUpvotes = (post.blogPostUpvotes ?? 0) + upvoteChange;
      post.blogPostDownvotes = (post.blogPostDownvotes ?? 0) + downvoteChange;
    }

    // --- Part 3: Notify UI and make API call ---
    notifyListeners();

    try {
      final response = await ApiManger.voteOnPost(postId: postId, type: voteType);

      if (response == null || response.statusCode >= 400) {
        // Revert both if API fails
        if (originalPostDetails != null) {
          postDetails = originalPostDetails;
        }
        if (originalTimelineItem != null && timelineIndex != -1) {
          timelineItems[timelineIndex] = originalTimelineItem;
        }
        notifyListeners();
      }
    } catch (e) {
      // Revert both on error
      if (originalPostDetails != null) {
        postDetails = originalPostDetails;
      }
      if (originalTimelineItem != null && timelineIndex != -1) {
        timelineItems[timelineIndex] = originalTimelineItem;
      }
      notifyListeners();
    }
  }

  Future<void> sendConnectionRequest(String targetUserId) async {
    final response = await ApiManger.sendConnectionRequest(targetUserId: targetUserId);
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
      await fetchConnectionSuggestions();
      await fetchSentConnections();
    }
  }

  Future<void> acceptConnectionRequest(num connectionId) async {
    final response = await ApiManger.acceptConnectionRequest(connectionId: connectionId);
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
      await fetchPendingConnections();
      await fetchConnections();
    }
  }

  Future<void> declineConnectionRequest(num connectionId) async {
    final response = await ApiManger.declineConnectionRequest(connectionId: connectionId);
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
      await fetchPendingConnections();
    }
  }

  Future<void> removeExistingConnection(String targetUserIdToRemove) async {
    final response = await ApiManger.removeConnection(targetUserIdToRemove: targetUserIdToRemove);
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {

      if(userProfile != null && userProfile!.connectionsCount != null) {
        userProfile!.connectionsCount = userProfile!.connectionsCount! - 1;
      }

      await fetchConnections();
    }
  }

  Future<void> updateProfileSummary(String summary) async {
    final response = await ApiManger.ProfileSummary(summary: summary);
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
      if(userProfile != null) {
        userProfile!.summary = summary;
        notifyListeners();
      }
    }
  }

  Future<void> changeProfilePicture() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickedFile == null) return;
      final response = await ApiManger.uploadProfilePicture(pickedFile.path);
      if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        final newUrl = responseBody['profilePictureUrl'] as String?;
        if (newUrl != null && userProfile != null) {
          final relativeUrl = newUrl.replaceFirst('https://intervyouquestions.runasp.net', '');
          userProfile!.profilePictureUrl = relativeUrl;
          notifyListeners();
        } else {
          if (currentUserId != null) await fetchUserProfile(currentUserId!);
        }
      }
    } catch (e) {
      debugPrint("Error changing profile picture: $e");
    }
  }


  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    userProfile = null;
    allConversations.clear();
    timelineItems.clear();
    notifyListeners();
  }

  void initializeSignalRConnection(String accessToken) {
    if (_hubConnection != null && _hubConnection?.state != HubConnectionState.disconnected) return;
    const hubUrl = "https://intervyouquestions.runasp.net/chathub";
    _hubConnection = HubConnectionBuilder()
        .withUrl(hubUrl, HttpConnectionOptions(accessTokenFactory: () async => accessToken))
        .withAutomaticReconnect().build();
    _hubConnection?.onclose((error) => debugPrint("SignalR Connection Closed: $error"));
    _hubConnection?.on('ReceiveMessage', (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        try {
          final newMessageData = arguments[0] as Map<String, dynamic>;
          final newMessage = ConversationOtherUserIdItem.fromJson(newMessageData);
          if (newMessage.senderId == currentUserId) return;
          _handleNewMessage(newMessage, isIncoming: true);
        } catch (e) {
          debugPrint('Error processing received message: $e');
        }
      }
    });
    startSignalRConnection();
  }

  void _handleNewMessage(ConversationOtherUserIdItem message, {bool isIncoming = false}) {
    final partnerId = message.senderId == currentUserId ? message.receiverId : message.senderId;
    if (partnerId == null) return;
    int convoIndex = allConversations.indexWhere((c) => c.otherUserId == partnerId);
    if (convoIndex != -1) {
      final conversation = allConversations[convoIndex];
      conversation.lastMessageSnippet = message.content;
      conversation.lastMessageAt = message.sentAt;
      if (isIncoming && partnerId != currentOpenChatUserId) {
        conversation.unreadMessagesCount = (conversation.unreadMessagesCount ?? 0) + 1;
      }
      allConversations.removeAt(convoIndex);
      allConversations.insert(0, conversation);
    } else {
      if (isIncoming) fetchAllConversations();
    }
    if (partnerId == currentOpenChatUserId) {
      conversationMessages.add(message);
    }
    notifyListeners();
  }

  Future<void> startSignalRConnection() async {
    if (_hubConnection?.state == HubConnectionState.disconnected) {
      try {
        await _hubConnection?.start();
      } catch (e) {
        debugPrint("Error starting SignalR connection: $e");
      }
    }
  }

  Future<void> stopSignalRConnection() async { await _hubConnection?.stop(); }

  @override
  void dispose() {
    stopSignalRConnection();
    super.dispose();
  }

  Future<void> sendMessage(String text, String receiverId) async {
    final optimisticMessage = ConversationOtherUserIdItem(
        content: text, senderId: currentUserId, receiverId: receiverId, sentAt: DateTime.now().toIso8601String());
    _handleNewMessage(optimisticMessage, isIncoming: false);
    try {
      await ApiManger.sendMessage(receiverId: receiverId, content: text);
    } catch (e) {
      debugPrint("Error sending message via HTTP: $e");
    }
  }

  Future<void> markConversationAsRead(String otherParticipantUserId) async {
    try {
      await ApiManger.markMessageAsRead(otherParticipantUserId: otherParticipantUserId);
      final convoIndex = allConversations.indexWhere((c) => c.otherUserId == otherParticipantUserId);
      if(convoIndex != -1){
        allConversations[convoIndex].unreadMessagesCount = 0;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error marking conversation as read: $e");
    }
  }

  Future<void> fetchConversationWithUser(String otherUserId) async {
    currentOpenChatUserId = otherUserId;
    conversationLoading = true;
    conversationMessages.clear();
    notifyListeners();
    try {
      final response = await ApiManger.fetchConversationWithUser(otherUserId: otherUserId);
      if (response != null && response.items != null) {
        response.items!.sort((a, b) => DateTime.parse(a.sentAt!).compareTo(DateTime.parse(b.sentAt!)));
        conversationMessages = response.items!;
      } else {
        conversationMessages = [];
      }
      await markConversationAsRead(otherUserId);
    } catch (e) {
      debugPrint("Error fetching conversation with user: $e");
    } finally {
      conversationLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllConversations() async {
    allConversationsLoading = true;
    notifyListeners();
    try {
      final response = await ApiManger.fetchAllConversations();
      if (response != null && response.items != null) {
        allConversations = response.items!;
      } else {
        allConversations = [];
      }
    } catch (e) {
      debugPrint("Error fetching conversations: $e");
    } finally {
      allConversationsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPostDetails(num postId) async {
    postDetailsLoading = true;
    notifyListeners();
    try {
      postDetails = await ApiManger.fetchPostDetails(postId);
    } catch (e) {
      postDetailsError = "Failed to load post details.";
    } finally {
      postDetailsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCommentsForPost(int postId) async {
    commentsLoading = true;
    notifyListeners();
    try {
      final response = await ApiManger.fetchCommentsForPost(postId: postId);
      if (response != null && response.items != null) {
        postComments = response.items!;
      } else {
        postComments = [];
      }
    } catch (e) {
      commentsError = "Failed to load comments.";
    } finally {
      commentsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTimeline() async {
    timelineLoading = true;
    notifyListeners();
    try {
      final response = await ApiManger.fetchTimelineData();
      if (response != null && response.items != null) {
        timelineItems = response.items!;
      } else {
        timelineItems = [];
      }
    } catch (e) {
      timelineError = "Failed to load timeline.";
    } finally {
      timelineLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProfile(String userId) async {
    profileLoading = true;
    notifyListeners();
    try {
      userProfile = await ApiManger.fetchUserProfile(userId);
    } catch (e) {
      profileError = "Failed to load profile.";
    } finally {
      profileLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchBlogPosts() async {
    postsLoading = true;
    notifyListeners();
    try {
      final response = await ApiManger.fetchBlogPosts();
      if (response != null && response.items != null) {
        posts = response.items!;
      } else {
        posts = [];
      }
    } catch (e) {
      postsError = "Failed to load blog posts.";
    } finally {
      postsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPostsByAuthor(String authorId) async {
    authorPostsLoading = true;
    notifyListeners();
    try {
      final response = await ApiManger.fetchPostsByAuthor(authorId: authorId);
      if (response != null && response.items != null) {
        authorPosts = response.items!;
      } else {
        authorPosts = [];
      }
    } catch (e) {
      authorPostsError = "Failed to load author's posts.";
    } finally {
      authorPostsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNotifications({bool unreadOnly = false}) async {
    notificationsLoading = true;
    notifyListeners();
    try {
      final response = await ApiManger.fetchNotifications(unreadOnly: unreadOnly);
      if (response != null && response.items != null) {
        notifications = response.items!;
      } else {
        notifications = [];
      }
    } catch (e) {
      notificationsError = "Failed to load notifications.";
    } finally {
      notificationsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPendingConnections() async {
    pendingConnectionsLoading = true;
    notifyListeners();
    try {
      final response = await ApiManger.fetchPendingConnections();
      if (response != null && response.items != null) {
        pendingConnections = response.items!;
      } else {
        pendingConnections = [];
      }
    } catch (e) {
      pendingConnectionsError = "Failed to load pending connections.";
    } finally {
      pendingConnectionsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSentConnections() async {
    sentConnectionsLoading = true;
    notifyListeners();
    try {
      final response = await ApiManger.fetchSentConnections();
      if (response != null && response.items != null) {
        sentConnections = response.items!;
      } else {
        sentConnections = [];
      }
    } catch (e) {
      sentConnectionsError = "Failed to load sent connections.";
    } finally {
      sentConnectionsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchConnections() async {
    connectionsLoading = true;
    notifyListeners();
    try {
      final response = await ApiManger.fetchConnections();
      if (response != null && response.items != null) {
        connections = response.items!;
      } else {
        connections = [];
      }
    } catch (e) {
      connectionsError = "Failed to load connections.";
    } finally {
      connectionsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchConnectionSuggestions() async {
    suggestionConnectionsLoading = true;
    notifyListeners();
    try {
      final response = await ApiManger.fetchConnectionSuggestions();
      if (response != null && response.items != null) {
        suggestionConnections = response.items!;
      } else {
        suggestionConnections = [];
      }
    } catch (e) {
      suggestionConnectionsError = "Failed to load suggestions.";
    } finally {
      suggestionConnectionsLoading = false;
      notifyListeners();
    }
  }
}