// import 'package:flutter/material.dart';
// import 'package:intervyou_app/data/api_manager.dart';
// import 'package:intervyou_app/data/models/login_response.dart';
//
// class LoginViewModel extends ChangeNotifier {
//   LoginResponse? loginResponse;
//   bool isLoading = false;
//   String? errorMessage;
//
//   void login(String email, String password) async {
//     try {
//       isLoading = true;
//       errorMessage = null;
//       notifyListeners();
//
//       var response = await ApiManger.loginUser(email, password);
//       isLoading = false;
//
//       if (response != null) {
//         loginResponse = response;
//         notifyListeners();
//       } else {
//         errorMessage = "Something went wrong";
//         notifyListeners();
//       }
//     } catch (e) {
//       isLoading = false;
//       errorMessage = e.toString();
//       notifyListeners();
//     }
//   }
// }
