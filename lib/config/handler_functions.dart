import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/routes_manger.dart';
import '../data/api_manager.dart';

class HandlerFunctions {
  static void handleLogin(context, String email, String password) async {
    final response = await ApiManger.loginUser(email, password);
    final message = response.body.trim();

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      String accessToken = json['accessToken'];

      ApiManger.decodeJwt(accessToken);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );

      await handleCheckPreferences(context);
    } else if (response.statusCode == 401) {
      if (message.contains("Email not confirmed")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email not confirmed')),
        );
        Navigator.pushNamed(
          context,
          RoutesManger.emailConfirmationOtp,
          arguments: email,
        );
      } else if (message.contains("Invalid credentials")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid login credentials')),
        );
      }
    }
  }

  static void handleRegister(context, String fullName, String email, String password, String confirmPassword) async {
    try {
      await ApiManger.registerUser(fullName, email, password, confirmPassword);
      Navigator.pushNamed(context, RoutesManger.emailConfirmationOtp,
          arguments: email);
    } catch (e) {
      print('Registration error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  static bool checkEmailAndPasswordValidation(context, String password, String confirmPassword, String email) {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return false;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid email address')));
      return false;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password and confirm password must match')));
      return false;
    }
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password must be at least 8 characters long')));
      return false;
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Password must contain at least one capital letter')),
      );
      return false;
    }
    if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Password must contain at least one special character')),
      );
      return false;
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password must contain at least one number')));
      return false;
    }

    return true;
  }

  static bool confirmPasswordValidation(context, String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return false;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password and confirm password must match')));
      return false;
    }
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password must be at least 8 characters long')));
      return false;
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Password must contain at least one capital letter')),
      );
      return false;
    }
    if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Password must contain at least one special character')),
      );
      return false;
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password must contain at least one number')));
      return false;
    }

    return true;
  }

  static bool checkLoginValidation(context, String password, String email) {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return false;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid email address')));
      return false;
    }
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password must be at least 8 characters long')));
      return false;
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Password must contain at least one capital letter')),
      );
      return false;
    }
    if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Password must contain at least one special character')),
      );
      return false;
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password must contain at least one number')));
      return false;
    }

    return true;
  }

  static void handleEmailConfirmation(context, String email, String otp) async {
    final response = await ApiManger.confirmEmail(email, otp);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email confirmed successfully')),
      );
      Navigator.pushNamed(context, RoutesManger.login);
    } else {
      final message = responseBody['message'] ?? 'Something went wrong';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  static void handleResendEmailConfirmationOtp(context, String email) async {
    final response = await ApiManger.resendEmailConfirmationOtp(email);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Email confirmation otp resent successfully')),
      );
    }
    if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Credentials')),
      );
    }
  }

  static void handleForgotPassword(context, String email) async {
    final response = await ApiManger.forgotPassword(email);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'If an account exists for this email and is confirmed, a password reset OTP has been sent.')),
      );
      Navigator.pushNamed(context, RoutesManger.forgotPasswordOtp,
          arguments: email);
    }
    if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Credentials')),
      );
    }
  }

  static void handleVerifyForgotPasswordOtp(context, String email, String otp) async {
    final response = await ApiManger.verifyForgotPasswordOtp(email, otp);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email confirmed successfully')),
      );
      Navigator.pushNamed(context, RoutesManger.resetPassword,
          arguments: email);
    } else if (response.statusCode == 400) {
      final message = responseBody['message'] ?? 'Something went wrong';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  static void handleResetPassword(context, String email, String password, String confirmPassword) async {
    try {
      await ApiManger.resetPassword(email, password, confirmPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successful')),
      );
      Navigator.pushNamed(context, RoutesManger.login);
    } catch (e) {
      print('Registration error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  static Future<void> handleExternalLogin(context) async {
    try {
      final idToken =
          await ApiManger.getGoogleIdToken();
      if (idToken == null) {
        print('User cancelled sign-in');
        return;
      }
      final response = await ApiManger.externalLogin('google', idToken);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
        Navigator.pushNamed(context, RoutesManger.home);
        final data = jsonDecode(response.body);
        print('Login successful: $data');
      } else {
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      print('Error during external login: $e');
    }
  }

  static void handleUpdatePreferences(context, String preferredRole, String experienceLevel, String dailyStudyHours) async {
    final response = await ApiManger.updatePreferences(
        preferredRole, experienceLevel, dailyStudyHours);
    final message = response.body.trim();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferences updated successfully')),
      );
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update preferences: $message')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating preferences')),
      );
    }
  }

  static Future<void> handleCheckPreferences(BuildContext context) async {
    final response = await ApiManger.getUserPreferences();

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final hasPreferences = json['preferredRole'] != null &&
          json['experienceLevel'] != null &&
          json['dailyStudyHours'] != null;

      if (hasPreferences) {
        Navigator.pushReplacementNamed(context, RoutesManger.home);
      } else {
        Navigator.pushNamed(context, RoutesManger.preferences);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch user preferences')),
      );
    }
  }

  static String formatSmartDate(String isoTime) {
    final now = DateTime.now();
    final dateTime = DateTime.parse(isoTime).toLocal();

    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      // Same day
      return DateFormat.jm().format(dateTime); // "9:21 PM"
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat.EEEE().format(dateTime); // "Monday"
    } else {
      return DateFormat.MMMd().format(dateTime); // "Jun 2"
    }
  }


}
