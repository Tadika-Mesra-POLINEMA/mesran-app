import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class VerifyFaceResponse extends JsonParseable {
  final bool isMatch;
  final double confidence;
  final String? user;

  VerifyFaceResponse({
    required this.isMatch,
    required this.confidence,
    this.user, // Nullable
  });

  factory VerifyFaceResponse.fromJson(Map<String, dynamic> json) {
    return VerifyFaceResponse(
      isMatch: json['is_match'] as bool,
      confidence: (json['confidence'] as num).toDouble(),
      user: json['user'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'is_match': isMatch,
      'confidence': confidence,
      'user': user,
    };
  }
}
