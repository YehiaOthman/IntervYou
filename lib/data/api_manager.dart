import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intervyou_app/data/blogs_models/profile/Profile_dm.dart';
import 'package:intervyou_app/data/models/DailyQuiz.dart';
import 'blogs_models/chat/Conversation.dart';
import 'blogs_models/chat/ConversationOtherUserId.dart';
import 'blogs_models/connections/ConnectionStatus.dart';
import 'blogs_models/connections/Connections.dart';
import 'blogs_models/connections/PendingConnections.dart';
import 'blogs_models/connections/SentConnections.dart';
import 'blogs_models/connections/SuggestionConnection.dart';
import 'blogs_models/image/get_image.dart';
import 'blogs_models/notifications/Notifications.dart';
import 'blogs_models/notifications/UnReadCountNotifications.dart';
import 'blogs_models/post/AuthorPosts.dart';
import 'blogs_models/post/PostComments.dart';
import 'blogs_models/post/PostDetailsDm.dart';
import 'blogs_models/post/Posts.dart';
import 'blogs_models/profile/SearchProfile.dart';
import 'blogs_models/timeline/TimeLine.dart';
import 'models/LearnRespone.dart';
import 'models/LearningPoints.dart';
import 'models/SubmitQuizResponse.dart';
import 'package:http_parser/http_parser.dart';

class ApiManger {
  static const String baseUrl = 'intervyouquestions.runasp.net';
  static const String loginEndPoint = '/api/Auth/login';
  static const String registerEndPoint = '/api/Auth/register/mobile';
  static const String confirmEmailOtpEndPoint = '/api/Auth/confirm-email-otp';
  static const String resendEmailConfirmationOtpEndPoint = '/api/Auth/resend-confirmation-otp';
  static const String forgotPasswordOtpEndPoint = '/api/Auth/forgot-password';
  static const String verifyForgotPasswordOtpEndPoint = '/api/Auth/verify-otp';
  static const String resetPasswordEndPoint = '/api/Auth/reset-password';
  static const String externalLoginEndPoint = '/api/auth/external/login/{provider}';
  static const String learnEndPoint = '/api/Roadmap';
  static const String learningPointsEndPoint = '/learningpoints/{subTopicId}';
  static const String subTopicEndPoint = '/api/Roadmap/subtopics/{subTopicId}/quiz';
  static const String submitQuizEndPoint = '/api/Roadmap/quiz/submit';


  static Future<http.Response> loginUser(String email, String password) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final response = await post(
      Uri.https(baseUrl, loginEndPoint),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      String accessToken = json['accessToken'];
      String refreshToken = json['refreshToken'];

      final storage = FlutterSecureStorage();
      await storage.write(key: 'access_token', value: accessToken);
      await storage.write(key: 'refresh_token', value: refreshToken);
    }

    return response;
  }

  static void decodeJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) throw Exception('Invalid token');

      final payload = jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      print("Decoded payload: $payload");

      String userName = payload['given_name'];
      String userId = payload['sub'];

      print('User Name: $userName');
      print('User ID: $userId');
      final storage = FlutterSecureStorage();
      storage.write(key: 'user_name', value: userName);
      storage.write(key: 'user_id', value: userId);
    } catch (e) {
      print("Error decoding token: $e");
    }
  }

  static Future<void> registerUser(String fullName, String email, String password, String confirmPassword) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "fullName": fullName,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
    };

    try {
      final response = await post(
        Uri.https(baseUrl, registerEndPoint),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('Registration successful');
      } else {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic> && decoded.containsKey('errors')) {
          final errors = List<String>.from(decoded['errors']);
          final emailTakenError = errors.firstWhere(
                (e) => e.toLowerCase().contains('already taken'),
            orElse: () => '',
          );

          if (emailTakenError.isNotEmpty) {
            throw emailTakenError;
          }
        }

        throw 'Unknown registration error';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<http.Response> confirmEmail(String email, String otp) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {'email': email, 'otp': otp};
    final response = await post(
      Uri.https(baseUrl, confirmEmailOtpEndPoint),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<http.Response> resendEmailConfirmationOtp(String email) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {
      'email': email,
    };
    final response = await post(
      Uri.https(baseUrl, resendEmailConfirmationOtpEndPoint),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<http.Response> forgotPassword(String email) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {
      'email': email,
    };
    final response = await post(
      Uri.https(baseUrl, forgotPasswordOtpEndPoint),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<http.Response> verifyForgotPasswordOtp(String email, String otp) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {'email': email, 'otp': otp};
    final response = await post(
      Uri.https(baseUrl, verifyForgotPasswordOtpEndPoint),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<http.Response> resetPassword(String email, String password,
      String confirmPassword) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {
      'email': email,
      'newPassword': password,
      'confirmPassword': confirmPassword
    };
    final response = await post(
      Uri.https(baseUrl, resetPasswordEndPoint),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<String?> getGoogleIdToken() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    return googleAuth.idToken;
  }

  static Future<http.Response> externalLogin(String provider,
      String token) async {
    final String url = "$baseUrl/api/auth/external/login/$provider";

    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Map<String, String> body = {"providerToken": token};

    final response = await post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<http.Response> updatePreferences(String preferredRole, String experienceLevel, String dailyStudyHours) async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    if (token == null) {
      throw Exception("User is not authenticated");
    }

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> body = {
      'preferredRole': preferredRole,
      'experienceLevel': experienceLevel,
      'dailyStudyHours': dailyStudyHours,
    };

    final response = await put(
      Uri.https(baseUrl, '/api/Auth/update-preferences'),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<http.Response> getUserPreferences() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    if (token == null) {
      throw Exception("User is not authenticated");
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await get(
      Uri.https(baseUrl, '/api/Auth/preferences'),
      headers: headers,
    );

    return response;
  }

  static Future<LearnResponse?> getLearnData() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token == null) return null;

    final response = await http.get(
      Uri.parse("https://intervyouquestions.runasp.net/api/Roadmap"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return LearnResponse.fromJson(jsonData);
    } else {
      print("Failed to load learn data: ${response.statusCode}");
      return null;
    }
  }

  static Future<List<LearningPoints>?> getLearningPoints(int subTopicId) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token == null) return null;

    final response = await http.get(
      Uri.parse(
          "https://intervyouquestions.runasp.net/api/Roadmap/learningpoints/$subTopicId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((e) => LearningPoints.fromJson(e)).toList();
    } else {
      print("Failed to load learning points: ${response.statusCode}");
      return null;
    }
  }

  static Future<http.Response> updateLearningPointProgress(num learningPointId,
      num status) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');

    if (token == null) {
      throw Exception('Access token not found');
    }

    final response = await http.post(
      Uri.parse(
          "https://intervyouquestions.runasp.net/api/Roadmap/learningpoints/$learningPointId/progress"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"status": status}),
    );

    return response;
  }

  static Future<List<DailyQuizzes>?> getQuiz(int subTopicId) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token == null) return null;

    final response = await http.get(
      Uri.parse(
          "https://intervyouquestions.runasp.net/api/Roadmap/subtopics/$subTopicId/quiz"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((e) => DailyQuizzes.fromJson(e)).toList();
    } else {
      print("Failed to load quiz: ${response.statusCode}");
      return null;
    }
  }

  static Future<submitQuizResponse?> submitQuizAnswers(int subTopicId, Map<String, int> answers) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token == null) return null;

    final body = {
      "subTopicId": subTopicId,
      "answers": answers,
    };

    final response = await http.post(
      Uri.parse(
          "https://intervyouquestions.runasp.net/api/Roadmap/quiz/submit"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return submitQuizResponse.fromJson(jsonData);
    } else {
      print("Failed to submit quiz: ${response.statusCode}");
      return null;
    }
  }





  //----------------------------------------------------------------------------------------------------------
  //                                     *  يارب عدي الترب ده علي خير *
  //----------------------------------------------------------------------------------------------------------

  // Blogs-Get-Apis

  static Future<TimeLine?> fetchTimelineData({int? page, int? pageSize}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');

      if (token == null) {
        print("Access token not found");
        return null;
      }

      final queryParams = {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'pageSize': pageSize.toString(),
      };

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/timeline',
        queryParams,
      );

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return TimeLine.fromJson(jsonData);
      } else {
        print("Failed to load timeline: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception while fetching timeline: $e");
      return null;
    }
  }

  static Future<ProfileDataModel?> fetchUserProfile(String userId) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token == null) return null;

    final url = "https://intervyouquestions.runasp.net/api/Profile/$userId";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ProfileDataModel.fromJson(jsonData);
    } else {
      print("Failed to fetch profile: ${response.statusCode}");
      return null;
    }
  }

  static Future<SearchProfile?> fetchSearchProfiles({String? query, int? page, int? pageSize}) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token == null) return null;

    // Build query parameters
    final Map<String, String> queryParams = {};
    if (query != null) queryParams['query'] = query;
    if (page != null) queryParams['page'] = page.toString();
    if (pageSize != null) queryParams['pageSize'] = pageSize.toString();

    final uri = Uri.https(
      'intervyouquestions.runasp.net',
      '/api/Profile/search',
      queryParams,
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return SearchProfile.fromJson(jsonData);
    } else {
      print("Failed to load profiles: ${response.statusCode}");
      return null;
    }
  }

  static Future<Notifications?> fetchNotifications({int? page, int? pageSize, bool? unreadOnly}) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token == null) return null;

    final Map<String, String> queryParams = {};
    if (page != null) queryParams['page'] = page.toString();
    if (pageSize != null) queryParams['pageSize'] = pageSize.toString();
    if (unreadOnly != null) queryParams['unreadOnly'] = unreadOnly.toString();

    final uri = Uri.https(
      'intervyouquestions.runasp.net',
      '/api/Notifications',
      queryParams,
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Notifications.fromJson(jsonData);
    } else {
      print('Failed to fetch notifications: ${response.statusCode}');
      return null;
    }
  }

  static Future<UnReadCountNotifications?> fetchUnreadNotificationCount() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token == null) return null;

    final uri = Uri.parse(
        'https://intervyouquestions.runasp.net/api/Notifications/unread-count');

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UnReadCountNotifications.fromJson(jsonData);
    } else {
      print('Failed to fetch unread count: ${response.statusCode}');
      return null;
    }
  }

  static Future<PendingConnections?> fetchPendingConnections({int? page, int? pageSize}) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token == null) return null;

    final uri = Uri.https(
      'intervyouquestions.runasp.net',
      '/api/Connections/pending',
      {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'pageSize': pageSize.toString(),
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return PendingConnections.fromJson(jsonData);
    } else {
      print('Failed to load pending connections: ${response.statusCode}');
      return null;
    }
  }

  static Future<SentConnections?> fetchSentConnections({int? page, int? pageSize}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Connections/sent',
        {
          if (page != null) 'page': page.toString(),
          if (pageSize != null) 'pageSize': pageSize.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return SentConnections.fromJson(jsonData);
      } else {
        print('Failed to load sent connections: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching sent connections: $e');
      return null;
    }
  }

  static Future<Connections?> fetchConnections({int? page, int? pageSize}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Connections',
        {
          if (page != null) 'page': page.toString(),
          if (pageSize != null) 'pageSize': pageSize.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Connections.fromJson(jsonData);
      } else {
        print('Failed to load connections: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching connections: $e');
      return null;
    }
  }

  static Future<SuggestionConnection?> fetchConnectionSuggestions({int? page, int? pageSize, int? minMutual}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Connections/suggestions',
        {
          if (page != null) 'page': page.toString(),
          if (pageSize != null) 'pageSize': pageSize.toString(),
          if (minMutual != null) 'minMutual': minMutual.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return SuggestionConnection.fromJson(jsonData);
      } else {
        print('Failed to load suggestions: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching connection suggestions: $e');
      return null;
    }
  }

  static Future<ConnectionStatus?> fetchConnectionStatus(String targetUserId) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Connections/status/$targetUserId',
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ConnectionStatus.fromJson(jsonData);
      } else {
        print('Failed to load connection status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching connection status: $e');
      return null;
    }
  }

  static Future<ConversationOtherUserId?> fetchConversationWithUser({required String otherUserId, int? page, int? pageSize}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/chat/conversation/$otherUserId',
        {
          if (page != null) 'page': page.toString(),
          if (pageSize != null) 'pageSize': pageSize.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ConversationOtherUserId.fromJson(jsonData);
      } else {
        print('Failed to load conversation: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching conversation: $e');
      return null;
    }
  }

  static Future<Conversation?> fetchAllConversations({int? page, int? pageSize}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/chat/conversations',
        {
          if (page != null) 'page': page.toString(),
          if (pageSize != null) 'pageSize': pageSize.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Conversation.fromJson(jsonData);
      } else {
        print('Failed to load conversations: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching conversations: $e');
      return null;
    }
  }

  static Future<Posts?> fetchBlogPosts({int? page, int? pageSize}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/posts',
        {
          if (page != null) 'page': page.toString(),
          if (pageSize != null) 'pageSize': pageSize.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Posts.fromJson(jsonData);
      } else {
        print('Failed to load blog posts: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching blog posts: $e');
      return null;
    }
  }

  static Future<PostDetailsDm?> fetchPostDetails(num postId) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/posts/$postId',
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PostDetailsDm.fromJson(jsonData);
      } else {
        print('Failed to load post details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching post details: $e');
      return null;
    }
  }

  static Future<AuthorPosts?> fetchPostsByAuthor({required String authorId, int? page, int? pageSize}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/posts/author/$authorId',
        {
          if (page != null) 'page': page.toString(),
          if (pageSize != null) 'pageSize': pageSize.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return AuthorPosts.fromJson(jsonData);
      } else {
        print('Failed to load author posts: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching author posts: $e');
      return null;
    }
  }

  static Future<PostComments?> fetchCommentsForPost({required int postId, int? page, int? pageSize}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/posts/$postId/comments',
        {
          if (page != null) 'page': page.toString(),
          if (pageSize != null) 'pageSize': pageSize.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PostComments.fromJson(jsonData);
      } else {
        print('Failed to load post comments: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching post comments: $e');
      return null;
    }
  }

  static Future<GetImage?> fetchProfilePicture() async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Profile/picture',
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return GetImage.fromJson(jsonData);
      } else {
        print('Failed to load profile picture: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching profile picture: $e');
      return null;
    }
  }


// Blogs-Get-Apis



// Blogs-(post - put - delete) -Apis       * ياااااااااااااااااررررررررررب *

  static Future<http.Response?> createPost({required String title, required String content}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/posts',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'content': content,
        }),
      );
      return response;
    } catch (e) {
      print('Error creating post: $e');
      return null;
    }
  }

  static Future<http.Response?> updatePost({required num postId, required String title, required String content}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/posts/$postId',
      );

      final response = await http.put(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'content': content,
        }),
      );

      return response;
    } catch (e) {
      print('Error updating post: $e');
      return null;
    }
  }

  static Future<http.Response?> deletePost(num postId) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/posts/$postId',
      );

      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      print('Error deleting post: $e');
      return null;
    }
  }

  static Future<http.Response?> createCommentOnPost({required num postId, required String content}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/posts/$postId/comments',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'content': content,
          'parentCommentId': null,
        }),
      );

      return response;
    } catch (e) {
      print('Error posting comment: $e');
      return null;
    }
  }

  static Future<http.Response?> deleteComment(String commentId) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/comments/$commentId',
      );

      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      print('Error deleting comment: $e');
      return null;
    }
  }

  static Future<http.Response?> voteOnPost({required num postId, required num type}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/posts/$postId/vote',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'type': type,
        }),
      );

      return response;
    } catch (e) {
      print('Error voting on post: $e');
      return null;
    }
  }

  static Future<http.Response?> voteOnComment({required num commentId, required num type}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/blog/comments/$commentId/vote',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'type': type,
        }),
      );

      return response;
    } catch (e) {
      print('Error voting on comment: $e');
      return null;
    }
  }

  static Future<http.Response?> sendMessage({required String receiverId, required String content}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/chat/messages',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'receiverId': receiverId,
          'content': content,
        }),
      );

      return response;
    } catch (e) {
      print('Error sending message: $e');
      return null;
    }
  }

  static Future<http.Response?> markMessageAsRead({required String otherParticipantUserId}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/chat/conversation/$otherParticipantUserId/read',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      print('Error marking conversation as read: $e');
      return null;
    }
  }

  static Future<http.Response?> sendConnectionRequest({required String targetUserId}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Connections/request/$targetUserId',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      print('Error sending connection request: $e');
      return null;
    }
  }

  static Future<http.Response?> acceptConnectionRequest({required num connectionId}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Connections/requests/$connectionId/accept',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      print('Error accepting connection request: $e');
      return null;
    }
  }

  static Future<http.Response?> declineConnectionRequest({required num connectionId}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Connections/requests/$connectionId/decline',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      print('Error declining connection request: $e');
      return null;
    }
  }

  static Future<http.Response?> removeConnection({required String targetUserIdToRemove}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Connections/$targetUserIdToRemove',
      );

      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      print('Error removing connection: $e');
      return null;
    }
  }

  static Future<http.Response?> markNotificationAsRead({required num notificationId}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Notifications/$notificationId/read',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      print('Error marking notification as read: $e');
      return null;
    }
  }

  static Future<http.Response?> markAllNotificationsAsRead() async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Notifications/read-all',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      print('Error marking all notifications as read: $e');
      return null;
    }
  }

  static Future<http.Response?> uploadProfilePicture(String imagePath) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) {
        print("Upload Error: Auth token is null.");
        return null;
      }

      final uri = Uri.https('intervyouquestions.runasp.net', '/api/Profile/picture');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(
        await http.MultipartFile.fromPath(
          'pictureFile',
          imagePath,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      return response;

    } catch (e) {
      print('Error uploading profile picture: $e');
      return null;
    }
  }

  static Future<http.Response?> ProfileSummary({required String summary}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final uri = Uri.https(
        'intervyouquestions.runasp.net',
        '/api/Profile/summary',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'summary': summary,
        }),
      );

      return response;
    } catch (e) {
      print('Error updating summary: $e');
      return null;
    }
  }

  // 2 missing endPoints ( pp - blogsImage )

// Blogs-(post - put - delete) -Apis       * ياااااااااااااااااررررررررررب *






}
