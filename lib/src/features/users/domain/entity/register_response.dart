import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class RegisterResponse extends JsonParseable {
  final String email;
  final String accessToken;
  final String refreshToken;

  RegisterResponse({
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
