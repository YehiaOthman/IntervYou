import 'package:flutter/foundation.dart';
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


  // Blog Posts State
  bool postsLoading = false;
  bool postsLoadingMore = false;
  String? postsError;
  List<PostsItem> posts = [];
  int _postsPage = 1;
  bool _postsHasNextPage = true;

  // Post Details State
  bool postDetailsLoading = false;
  String? postDetailsError;
  PostDetailsDm? postDetails;

  // Author Posts State
  bool authorPostsLoading = false;
  bool authorPostsLoadingMore = false;
  String? authorPostsError;
  List<PostsItem> authorPosts = [];
  int _authorPostsPage = 1;
  bool _authorPostsHasNextPage = true;

  // Post Comments State
  bool commentsLoading = false;
  bool commentsLoadingMore = false;
  String? commentsError;
  List<Comments> postComments = [];
  int _commentsPage = 1;
  bool _commentsHasNextPage = true;

  // Timeline State
  bool timelineLoading = false;
  bool timelineLoadingMore = false;
  String? timelineError;
  List<TimeLineItem> timelineItems = [];
  int _timelinePage = 1;
  bool _timelineHasNextPage = true;

  // Profile State
  bool profileLoading = false;
  String? profileError;
  ProfileDataModel? userProfile;

  // Search State
  bool searchLoading = false;
  bool searchLoadingMore = false;
  String? searchError;
  List<UserInfoItem> searchResults = [];
  String _searchQuery = "";
  int _searchPage = 1;
  bool _searchHasNextPage = true;

  // Notifications State
  bool notificationsLoading = false;
  bool notificationsLoadingMore = false;
  String? notificationsError;
  List<NotificationsItem> notifications = [];
  int _notificationsPage = 1;
  bool _notificationsHasNextPage = true;

  // Unread Notifications Count State
  bool unreadCountLoading = false;
  String? unreadCountError;
  UnReadCountNotifications? unreadNotificationCount;

  // Connections State
  bool connectionsLoading = false;
  bool connectionsLoadingMore = false;
  String? connectionsError;
  List<UserInfoItem> connections = [];
  int _connectionsPage = 1;
  bool _connectionsHasNextPage = true;

  // Pending Connections State
  bool pendingConnectionsLoading = false;
  bool pendingConnectionsLoadingMore = false;
  String? pendingConnectionsError;
  List<ConnectionsItem> pendingConnections = [];
  int _pendingConnectionsPage = 1;
  bool _pendingConnectionsHasNextPage = true;

  // Sent Connections State
  bool sentConnectionsLoading = false;
  bool sentConnectionsLoadingMore = false;
  String? sentConnectionsError;
  List<ConnectionsItem> sentConnections = [];
  int _sentConnectionsPage = 1;
  bool _sentConnectionsHasNextPage = true;

  // Suggestion Connections State
  bool suggestionConnectionsLoading = false;
  bool suggestionConnectionsLoadingMore = false;
  String? suggestionConnectionsError;
  List<UserInfoItem> suggestionConnections = [];
  int _suggestionConnectionsPage = 1;
  bool _suggestionConnectionsHasNextPage = true;

  // Connection Status State
  bool connectionStatusLoading = false;
  String? connectionStatusError;
  ConnectionStatus? connectionStatus;

  // Conversation with User State
  bool conversationLoading = false;
  bool conversationLoadingMore = false;
  String? conversationError;
  List<ConversationOtherUserIdItem> conversationMessages = [];
  int _conversationPage = 1;
  bool _conversationHasNextPage = true;

  // All Conversations State
  bool allConversationsLoading = false;
  bool allConversationsLoadingMore = false;
  String? allConversationsError;
  List<ConversationsItem> allConversations = [];
  int _allConversationsPage = 1;
  bool _allConversationsHasNextPage = true;

  static const int _pageSize = 20;

  bool _checkHasNextPage(Pagination? pagination) {
    if (pagination == null || pagination.page == null || pagination.pages == null) {
      return false;
    }
    return pagination.page! < pagination.pages!;
  }

  // --- Blog Methods ---

  Future<void> fetchBlogPosts() async {
    postsLoading = true;
    postsError = null;
    notifyListeners();

    _postsPage = 1;

    try {
      final response = await ApiManger.fetchBlogPosts(page: _postsPage, pageSize: _pageSize);
      if (response?.items != null) {
        posts.clear();
        posts.addAll(response!.items!);
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
      final response = await ApiManger.fetchBlogPosts(page: _postsPage, pageSize: _pageSize);
      if (response?.items != null && response!.items!.isNotEmpty) {
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
      final response = await ApiManger.fetchPostsByAuthor(authorId: authorId, page: _authorPostsPage, pageSize: _pageSize);
      if (response?.items != null) {
        authorPosts.clear();
        authorPosts.addAll(response!.items!);
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
      final response = await ApiManger.fetchPostsByAuthor(authorId: authorId, page: _authorPostsPage, pageSize: _pageSize);
      if (response?.items != null && response!.items!.isNotEmpty) {
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
      final response = await ApiManger.fetchCommentsForPost(postId: postId, page: _commentsPage, pageSize: _pageSize);
      if (response?.items != null) {
        postComments.clear();
        postComments.addAll(response!.items!);
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
      final response = await ApiManger.fetchCommentsForPost(postId: postId, page: _commentsPage, pageSize: _pageSize);
      if (response?.items != null && response!.items!.isNotEmpty) {
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

  // --- Timeline, Profile, Search Methods ---

  Future<void> fetchTimeline() async {
    timelineLoading = true;
    timelineError = null;
    notifyListeners();

    _timelinePage = 1;

    try {
      final response = await ApiManger.fetchTimelineData(page: _timelinePage, pageSize: _pageSize);
      if (response?.items != null) {
        timelineItems.clear();
        timelineItems.addAll(response!.items!);
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
      final response = await ApiManger.fetchTimelineData(page: _timelinePage, pageSize: _pageSize);
      if (response?.items != null && response!.items!.isNotEmpty) {
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
      final response = await ApiManger.fetchSearchProfiles(query: _searchQuery, page: _searchPage, pageSize: _pageSize);
      if (response?.items != null) {
        searchResults.clear();
        searchResults.addAll(response!.items!);
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
    if (searchLoadingMore || !_searchHasNextPage || _searchQuery.isEmpty) return;

    searchLoadingMore = true;
    notifyListeners();
    _searchPage++;

    try {
      final response = await ApiManger.fetchSearchProfiles(query: _searchQuery, page: _searchPage, pageSize: _pageSize);
      if (response?.items != null && response!.items!.isNotEmpty) {
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

  // --- Notification Methods ---

  Future<void> fetchNotifications({bool unreadOnly = false}) async {
    notificationsLoading = true;
    notificationsError = null;
    notifyListeners();

    _notificationsPage = 1;

    try {
      final response = await ApiManger.fetchNotifications(page: _notificationsPage, pageSize: _pageSize, unreadOnly: unreadOnly);
      if (response?.items != null) {
        notifications.clear();
        notifications.addAll(response!.items!);
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
      final response = await ApiManger.fetchNotifications(page: _notificationsPage, pageSize: _pageSize, unreadOnly: unreadOnly);
      if (response?.items != null && response!.items!.isNotEmpty) {
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

  // --- Connection Methods ---

  Future<void> fetchPendingConnections() async {
    pendingConnectionsLoading = true;
    pendingConnectionsError = null;
    notifyListeners();

    _pendingConnectionsPage = 1;

    try {
      final response = await ApiManger.fetchPendingConnections(page: _pendingConnectionsPage, pageSize: _pageSize);
      if (response?.items != null) {
        pendingConnections.clear();
        pendingConnections.addAll(response!.items!);
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
      final response = await ApiManger.fetchSentConnections(page: _sentConnectionsPage, pageSize: _pageSize);
      if (response?.items != null) {
        sentConnections.clear();
        sentConnections.addAll(response!.items!);
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
      final response = await ApiManger.fetchConnections(page: _connectionsPage, pageSize: _pageSize);
      if (response?.items != null) {
        connections.clear();
        connections.addAll(response!.items!);
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
      final response = await ApiManger.fetchConnectionSuggestions(page: _suggestionConnectionsPage, pageSize: _pageSize);
      if (response?.items != null) {
        suggestionConnections.clear();
        suggestionConnections.addAll(response!.items!);
        _suggestionConnectionsHasNextPage = _checkHasNextPage(response.pagination);
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

  // --- Chat Methods ---

  Future<void> fetchConversationWithUser(String otherUserId) async {
    conversationLoading = true;
    conversationError = null;
    notifyListeners();

    _conversationPage = 1;

    try {
      final response = await ApiManger.fetchConversationWithUser(otherUserId: otherUserId, page: _conversationPage, pageSize: _pageSize);
      if (response?.items != null) {
        conversationMessages.clear();
        conversationMessages.addAll(response!.items!);
        _conversationHasNextPage = _checkHasNextPage(response.pagination);
      } else {
        conversationMessages.clear();
        _conversationHasNextPage = false;
      }
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
      final response = await ApiManger.fetchAllConversations(page: _allConversationsPage, pageSize: _pageSize);
      if (response?.items != null) {
        allConversations.clear();
        allConversations.addAll(response!.items!);
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
}