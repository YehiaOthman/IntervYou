import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intervyou_app/data/models/DailyQuiz.dart';
import 'models/LearnRespone.dart';
import 'models/LearningPoints.dart';
import 'models/SubmitQuizResponse.dart';


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

      final payload = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      print("Decoded payload: $payload");

      String userName = payload['given_name'];
      String userId = payload['sub'];

      print('User Name: $userName');
      print('User ID: $userId');
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
    final Map<String, String> headers = {
      'Content-Type': 'application/json'
    };
    final Map<String, String> body = {
      'email': email,
      'otp': otp
    };
    final response = await post(
      Uri.https(baseUrl, confirmEmailOtpEndPoint),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<http.Response> resendEmailConfirmationOtp(String email) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json'
    };
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
    final Map<String, String> headers = {
      'Content-Type': 'application/json'
    };
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
    final Map<String, String> headers = {
      'Content-Type': 'application/json'
    };
    final Map<String, String> body = {
      'email': email,
      'otp': otp
    };
    final response = await post(
      Uri.https(baseUrl, verifyForgotPasswordOtpEndPoint),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<http.Response> resetPassword(String email, String password, String confirmPassword) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json'
    };
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

    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;
    return googleAuth.idToken;
  }

  static Future<http.Response> externalLogin(String provider, String token) async {
    final String url = "$baseUrl/api/auth/external/login/$provider";

    final Map<String, String> headers = {
      'Content-Type': 'application/json'
    };

    final Map<String, String> body = {
      "providerToken": token
    };

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
      Uri.parse("https://intervyouquestions.runasp.net/api/Roadmap/learningpoints/$subTopicId"),
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


  static Future<http.Response> updateLearningPointProgress(num learningPointId, num status) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');

    if (token == null) {
      throw Exception('Access token not found');
    }

    final response = await http.post(
      Uri.parse("https://intervyouquestions.runasp.net/api/Roadmap/learningpoints/$learningPointId/progress"),
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
      Uri.parse("https://intervyouquestions.runasp.net/api/Roadmap/subtopics/$subTopicId/quiz"),
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
      Uri.parse("https://intervyouquestions.runasp.net/api/Roadmap/quiz/submit"),
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














}
