import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class RegisterResponse extends JsonParseable {
  final String email;

  RegisterResponse({
    required this.email,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      email: json['email'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
