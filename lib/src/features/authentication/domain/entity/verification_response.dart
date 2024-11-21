import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class VerificationResponse extends JsonParseable {
  final String accessToken;
  final String refreshToken;

  VerificationResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) {
    return VerificationResponse(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
