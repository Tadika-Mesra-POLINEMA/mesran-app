import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class AuthResponse implements JsonParseable {
  final String verificationKey;
  final String otp;

  AuthResponse({
    required this.verificationKey,
    required this.otp,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      verificationKey: json['verificationKey'] ?? '',
      otp: json['otp'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'verificationKey': verificationKey,
      'otp': otp,
    };
  }
}
