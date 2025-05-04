class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;


  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expiresAt: DateTime.parse(json['expiresAt']),
    );
  }
}