import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiManger {
  static const String baseUrl = 'intervyouquestions.runasp.net';
  static const String loginEndPoint = '/api/Auth/login';
  static const String registerEndPoint = '/api/Auth/register/mobile';
  static const String confirmEmailOtpEndPoint = '/api/Auth/confirm-email-otp';
  static const String resendEmailConfirmationOtpEndPoint = '/api/Auth/resend-confirmation-otp';
  static const String forgotPasswordOtpEndPoint = '/api/Auth/forgot-password';
  static const String verifyForgotPasswordOtpEndPoint = '/api/Auth/verify-otp';
  static const String resetPasswordEndPoint = '/api/Auth/reset-password';

  static Future<http.Response> loginUser(String email, String password) async {
     final Map<String, String> headers = {
       'Content-Type': 'application/json'
     };
     final Map<String, String> body = {
       'email': email,
       'password': password
     };
      final response = await post(
        Uri.https(baseUrl, loginEndPoint),
        headers: headers,
        body: jsonEncode(body),
      );
      return response;
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
  static Future<http.Response> confirmEmail(String email,String otp) async {
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
  static Future<http.Response> verifyForgotPasswordOtp(String email,String otp) async {
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
  static Future<http.Response> resetPassword(String email,String password,String confirmPassword) async {
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

}
