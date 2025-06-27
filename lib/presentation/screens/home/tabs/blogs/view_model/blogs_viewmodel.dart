import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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

  final String instanceId =
      DateTime.now().microsecondsSinceEpoch.toString().substring(5);

  BlogsViewModel() {
    print("✅✅✅ BlogsViewModel CREATED! ID: $instanceId ✅✅✅");
  }

  @override
  void notifyListeners() {
    print(
        "🔔🔔🔔 ViewModel ID: $instanceId is calling notifyListeners()! 🔔🔔🔔");
    super.notifyListeners();
  }

  // All other state variables...
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

  static const int _pageSize = 20;

  bool _checkHasNextPage(Pagination? pagination) {
    if (pagination == null ||
        pagination.page == null ||
        pagination.pages == null) {
      return false;
    }
    return pagination.page! < pagination.pages!;
  }



  void initializeSignalRConnection(String accessToken) {
    if (_hubConnection != null &&
        _hubConnection?.state != HubConnectionState.disconnected) {
      print(
          "🔌 SignalR connection for ViewModel ID: $instanceId already exists and is not disconnected. Skipping initialization.");
      return;
    }

    print("🔌 Initializing SignalR for ViewModel ID: $instanceId...");
    const hubUrl = "https://intervyouquestions.runasp.net/chathub";

    _hubConnection = HubConnectionBuilder()
        .withUrl(hubUrl,
            HttpConnectionOptions(accessTokenFactory: () async => accessToken))
        .withAutomaticReconnect()
        .build();

    _hubConnection?.onclose((error) => print(
        "❌ SignalR Connection for ID: $instanceId Closed. Error: $error"));

    _hubConnection?.onreconnecting((error) => print(
        "🔄 SignalR Connection for ID: $instanceId is Reconnecting... Error: $error"));

    _hubConnection?.onreconnected((connectionId) => print(
        "🎉 SignalR Connection for ID: $instanceId has Reconnected! New Connection ID: $connectionId"));

    _hubConnection?.on('ReceiveMessage', (arguments) {
      print("📬 ViewModel ID: $instanceId received a SignalR message!");
      if (arguments != null && arguments.isNotEmpty) {
        try {
          final newMessageData = arguments[0] as Map<String, dynamic>;
          final newMessage =
              ConversationOtherUserIdItem.fromJson(newMessageData);

          final messageSenderId = newMessage.senderId;
          if (messageSenderId == currentUserId)
            return;

          bool needsUIRefresh = false;


          int convoIndex = allConversations
              .indexWhere((c) => c.otherUserId == messageSenderId);
          if (convoIndex != -1) {
            final conversation = allConversations[convoIndex];
            conversation.lastMessageSnippet = newMessage.content;
            conversation.lastMessageAt = newMessage.sentAt;
            if (messageSenderId != currentOpenChatUserId) {
              conversation.unreadMessagesCount =
                  (conversation.unreadMessagesCount ?? 0) + 1;
            }
            allConversations.removeAt(convoIndex);
            allConversations.insert(0, conversation);
            needsUIRefresh = true;
          } else {
            fetchAllConversations();
          }


          if (messageSenderId == currentOpenChatUserId) {
            conversationMessages.add(newMessage);
            needsUIRefresh = true;
          }

          if (needsUIRefresh) {
            print(
                "🔄 ViewModel ID: $instanceId is notifying listeners due to a new message.");
            notifyListeners();
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error processing received message: $e');
          }
        }
      }
    });

    startSignalRConnection();
  }

  Future<void> startSignalRConnection() async {
    if (_hubConnection?.state == HubConnectionState.disconnected) {
      try {
        await _hubConnection?.start();
        print(
            "🎉🎉🎉 SignalR Connection for ID: $instanceId started successfully! 🎉🎉🎉");
      } catch (e) {
        print(
            "❌❌❌ FATAL: Error starting SignalR connection for ID: $instanceId. Error: $e ❌❌❌");
      }
    } else {
      print(
          "ℹ️ SignalR connection for ID: $instanceId was already running. State: ${_hubConnection?.state}");
    }
  }

  Future<void> stopSignalRConnection() async {
    print("🔌 Stopping SignalR connection for ID: $instanceId.");
    await _hubConnection?.stop();
  }

  @override
  void dispose() {
    stopSignalRConnection();
    super.dispose();
  }



  Future<void> sendMessage(String text, String receiverId) async {

    try {
      final optimisticMessage = ConversationOtherUserIdItem(
        content: text,
        senderId: currentUserId,
        sentAt: DateTime.now().toIso8601String(),
      );

      conversationMessages.add(optimisticMessage);

      int convoIndex =
          allConversations.indexWhere((c) => c.otherUserId == receiverId);
      if (convoIndex != -1) {
        final conversation = allConversations[convoIndex];
        conversation.lastMessageSnippet = text;
        conversation.lastMessageAt = optimisticMessage.sentAt;
        allConversations.removeAt(convoIndex);
        allConversations.insert(0, conversation);
      }

      print(
          "🔄 ViewModel ID: $instanceId is notifying listeners due to a sent message.");
      notifyListeners();

      final response =
          await ApiManger.sendMessage(receiverId: receiverId, content: text);

      if (response == null ||
          response.statusCode < 200 ||
          response.statusCode >= 300) {
        if (kDebugMode) {
          print(
              "Failed to send message. Reverting UI. Status: ${response?.statusCode}");
        }
        conversationMessages.remove(optimisticMessage);
        fetchAllConversations();
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error sending message via HTTP: $e");
      }
    }
  }

  Future<void> markConversationAsRead(String otherParticipantUserId) async {
    try {
      await ApiManger.markMessageAsRead(
          otherParticipantUserId: otherParticipantUserId);
      final conversation = allConversations.firstWhere(
          (c) => c.otherUserId == otherParticipantUserId,
          orElse: () => ConversationsItem());
      conversation.unreadMessagesCount = 0;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error marking conversation as read: $e");
      }
    }
  }

  Future<void> fetchConversationWithUser(String otherUserId) async {
    currentOpenChatUserId = otherUserId;
    conversationLoading = true;
    conversationError = null;
    conversationMessages.clear();
    notifyListeners();
    _conversationPage = 1;
    try {
      final response = await ApiManger.fetchConversationWithUser(
          otherUserId: otherUserId,
          page: _conversationPage,
          pageSize: _pageSize);
      if (response != null && response.items != null) {
        response.items!.sort((a, b) =>
            DateTime.parse(a.sentAt!).compareTo(DateTime.parse(b.sentAt!)));
        conversationMessages.addAll(response.items!);
        _conversationHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        _conversationHasNextPage = false;
      }
      await markConversationAsRead(otherUserId);
    } catch (e) {
      conversationError = "Failed to load conversation.";
    } finally {
      conversationLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllConversations() async {
    allConversationsLoading = true;
    allConversationsError = null;
    notifyListeners();
    _allConversationsPage = 1;
    try {
      final response = await ApiManger.fetchAllConversations(
          page: _allConversationsPage, pageSize: _pageSize);
      if (response != null && response.items != null) {
        allConversations.clear();
        allConversations.addAll(response.items!);
        _allConversationsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        allConversations.clear();
        _allConversationsHasNextPage = false;
      }
    } catch (e) {
      allConversationsError = "Failed to load conversations.";
    } finally {
      allConversationsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchBlogPosts() async {
    postsLoading = true;
    postsError = null;
    notifyListeners();
    _postsPage = 1;
    try {
      final response =
          await ApiManger.fetchBlogPosts(page: _postsPage, pageSize: _pageSize);
      if (response != null && response.items != null) {
        posts.clear();
        posts.addAll(response.items!);
        _postsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        posts.clear();
        _postsHasNextPage = false;
      }
    } catch (e) {
      postsError = "Failed to load blog posts.";
    } finally {
      postsLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreBlogPosts() async {
    if (postsLoadingMore || !_postsHasNextPage) return;
    postsLoadingMore = true;
    notifyListeners();
    _postsPage++;
    try {
      final response =
          await ApiManger.fetchBlogPosts(page: _postsPage, pageSize: _pageSize);
      if (response != null &&
          response.items != null &&
          response.items!.isNotEmpty) {
        posts.addAll(response.items!);
        _postsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        _postsHasNextPage = false;
      }
    } catch (e) {
      _postsPage--;
    } finally {
      postsLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> fetchPostDetails(num postId) async {
    postDetailsLoading = true;
    postDetailsError = null;
    notifyListeners();
    try {
      postDetails = await ApiManger.fetchPostDetails(postId);
      if (postDetails == null) {
        postDetailsError = "Could not load post details.";
      }
    } catch (e) {
      postDetailsError = "Failed to load post details.";
    } finally {
      postDetailsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPostsByAuthor(String authorId) async {
    authorPostsLoading = true;
    authorPostsError = null;
    notifyListeners();
    _authorPostsPage = 1;
    try {
      final response = await ApiManger.fetchPostsByAuthor(
          authorId: authorId, page: _authorPostsPage, pageSize: _pageSize);
      if (response != null && response.items != null) {
        authorPosts.clear();
        authorPosts.addAll(response.items!);
        _authorPostsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        authorPosts.clear();
        _authorPostsHasNextPage = false;
      }
    } catch (e) {
      authorPostsError = "Failed to load author's posts.";
    } finally {
      authorPostsLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMorePostsByAuthor(String authorId) async {
    if (authorPostsLoadingMore || !_authorPostsHasNextPage) return;
    authorPostsLoadingMore = true;
    notifyListeners();
    _authorPostsPage++;
    try {
      final response = await ApiManger.fetchPostsByAuthor(
          authorId: authorId, page: _authorPostsPage, pageSize: _pageSize);
      if (response != null &&
          response.items != null &&
          response.items!.isNotEmpty) {
        authorPosts.addAll(response.items!);
        _authorPostsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        _authorPostsHasNextPage = false;
      }
    } catch (e) {
      _authorPostsPage--;
    } finally {
      authorPostsLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> fetchCommentsForPost(int postId) async {
    commentsLoading = true;
    commentsError = null;
    notifyListeners();
    _commentsPage = 1;
    try {
      final response = await ApiManger.fetchCommentsForPost(
          postId: postId, page: _commentsPage, pageSize: _pageSize);
      if (response != null && response.items != null) {
        postComments.clear();
        postComments.addAll(response.items!);
        _commentsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        postComments.clear();
        _commentsHasNextPage = false;
      }
    } catch (e) {
      commentsError = "Failed to load comments.";
    } finally {
      commentsLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreCommentsForPost(int postId) async {
    if (commentsLoadingMore || !_commentsHasNextPage) return;
    commentsLoadingMore = true;
    notifyListeners();
    _commentsPage++;
    try {
      final response = await ApiManger.fetchCommentsForPost(
          postId: postId, page: _commentsPage, pageSize: _pageSize);
      if (response != null &&
          response.items != null &&
          response.items!.isNotEmpty) {
        postComments.addAll(response.items!);
        _commentsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        _commentsHasNextPage = false;
      }
    } catch (e) {
      _commentsPage--;
    } finally {
      commentsLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> fetchTimeline() async {
    timelineLoading = true;
    timelineError = null;
    notifyListeners();
    _timelinePage = 1;
    try {
      final response = await ApiManger.fetchTimelineData(
          page: _timelinePage, pageSize: _pageSize);
      if (response != null && response.items != null) {
        timelineItems.clear();
        timelineItems.addAll(response.items!);
        _timelineHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        timelineItems.clear();
        _timelineHasNextPage = false;
      }
    } catch (e) {
      timelineError = "Failed to load timeline.";
    } finally {
      timelineLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreTimelineItems() async {
    if (timelineLoadingMore || !_timelineHasNextPage) return;
    timelineLoadingMore = true;
    notifyListeners();
    _timelinePage++;
    try {
      final response = await ApiManger.fetchTimelineData(
          page: _timelinePage, pageSize: _pageSize);
      if (response != null &&
          response.items != null &&
          response.items!.isNotEmpty) {
        timelineItems.addAll(response.items!);
        _timelineHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        _timelineHasNextPage = false;
      }
    } catch (e) {
      _timelinePage--;
    } finally {
      timelineLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProfile(String userId) async {
    profileLoading = true;
    profileError = null;
    notifyListeners();
    try {
      userProfile = await ApiManger.fetchUserProfile(userId);
      if (userProfile == null) {
        profileError = "Could not load user profile.";
      }
    } catch (e) {
      profileError = "Failed to load profile.";
    } finally {
      profileLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchProfiles(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      _searchQuery = "";
      notifyListeners();
      return;
    }
    searchLoading = true;
    searchError = null;
    _searchQuery = query;
    _searchPage = 1;
    notifyListeners();
    try {
      final response = await ApiManger.fetchSearchProfiles(
          query: _searchQuery, page: _searchPage, pageSize: _pageSize);
      if (response != null && response.items != null) {
        searchResults.clear();
        searchResults.addAll(response.items!);
        _searchHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        searchResults.clear();
        _searchHasNextPage = false;
      }
    } catch (e) {
      searchError = "Search failed.";
    } finally {
      searchLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreSearchResults() async {
    if (searchLoadingMore || !_searchHasNextPage || _searchQuery.isEmpty)
      return;
    searchLoadingMore = true;
    notifyListeners();
    _searchPage++;
    try {
      final response = await ApiManger.fetchSearchProfiles(
          query: _searchQuery, page: _searchPage, pageSize: _pageSize);
      if (response != null &&
          response.items != null &&
          response.items!.isNotEmpty) {
        searchResults.addAll(response.items!);
        _searchHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        _searchHasNextPage = false;
      }
    } catch (e) {
      _searchPage--;
    } finally {
      searchLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> fetchNotifications({bool unreadOnly = false}) async {
    notificationsLoading = true;
    notificationsError = null;
    notifyListeners();
    _notificationsPage = 1;
    try {
      final response = await ApiManger.fetchNotifications(
          page: _notificationsPage,
          pageSize: _pageSize,
          unreadOnly: unreadOnly);
      if (response != null && response.items != null) {
        notifications.clear();
        notifications.addAll(response.items!);
        _notificationsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        notifications.clear();
        _notificationsHasNextPage = false;
      }
    } catch (e) {
      notificationsError = "Failed to load notifications.";
    } finally {
      notificationsLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreNotifications({bool unreadOnly = false}) async {
    if (notificationsLoadingMore || !_notificationsHasNextPage) return;
    notificationsLoadingMore = true;
    notifyListeners();
    _notificationsPage++;
    try {
      final response = await ApiManger.fetchNotifications(
          page: _notificationsPage,
          pageSize: _pageSize,
          unreadOnly: unreadOnly);
      if (response != null &&
          response.items != null &&
          response.items!.isNotEmpty) {
        notifications.addAll(response.items!);
        _notificationsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        _notificationsHasNextPage = false;
      }
    } catch (e) {
      _notificationsPage--;
    } finally {
      notificationsLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> fetchUnreadNotificationCount() async {
    unreadCountLoading = true;
    unreadCountError = null;
    notifyListeners();
    try {
      unreadNotificationCount = await ApiManger.fetchUnreadNotificationCount();
    } catch (e) {
      unreadCountError = "Failed to get unread count.";
    } finally {
      unreadCountLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPendingConnections() async {
    pendingConnectionsLoading = true;
    pendingConnectionsError = null;
    notifyListeners();
    _pendingConnectionsPage = 1;
    try {
      final response = await ApiManger.fetchPendingConnections(
          page: _pendingConnectionsPage, pageSize: _pageSize);
      if (response != null && response.items != null) {
        pendingConnections.clear();
        pendingConnections.addAll(response.items!);
        _pendingConnectionsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        pendingConnections.clear();
        _pendingConnectionsHasNextPage = false;
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
    sentConnectionsError = null;
    notifyListeners();
    _sentConnectionsPage = 1;
    try {
      final response = await ApiManger.fetchSentConnections(
          page: _sentConnectionsPage, pageSize: _pageSize);
      if (response != null && response.items != null) {
        sentConnections.clear();
        sentConnections.addAll(response.items!);
        _sentConnectionsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        sentConnections.clear();
        _sentConnectionsHasNextPage = false;
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
    connectionsError = null;
    notifyListeners();
    _connectionsPage = 1;
    try {
      final response = await ApiManger.fetchConnections(
          page: _connectionsPage, pageSize: _pageSize);
      if (response != null && response.items != null) {
        connections.clear();
        connections.addAll(response.items!);
        _connectionsHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        connections.clear();
        _connectionsHasNextPage = false;
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
    suggestionConnectionsError = null;
    notifyListeners();
    _suggestionConnectionsPage = 1;
    try {
      final response = await ApiManger.fetchConnectionSuggestions(
          page: _suggestionConnectionsPage, pageSize: _pageSize);
      if (response != null && response.items != null) {
        suggestionConnections.clear();
        suggestionConnections.addAll(response.items!);
        _suggestionConnectionsHasNextPage =
            _checkHasNextPage(response.pagination);
      } else {
        suggestionConnections.clear();
        _suggestionConnectionsHasNextPage = false;
      }
    } catch (e) {
      suggestionConnectionsError = "Failed to load suggestions.";
    } finally {
      suggestionConnectionsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchConnectionStatus(String targetUserId) async {
    connectionStatusLoading = true;
    connectionStatusError = null;
    notifyListeners();
    try {
      connectionStatus = await ApiManger.fetchConnectionStatus(targetUserId);
    } catch (e) {
      connectionStatusError = "Failed to load connection status.";
    } finally {
      connectionStatusLoading = false;
      notifyListeners();
    }
  }
}
