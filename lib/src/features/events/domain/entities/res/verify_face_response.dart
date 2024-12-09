import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class VerifyFaceResponse extends JsonParseable {
  final String? userId;
  final String? email;
  final String? phone;
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? username;

  VerifyFaceResponse({
    this.userId,
    this.email,
    this.phone,
    this.role,
    this.firstName,
    this.lastName,
    this.username,
  });

  factory VerifyFaceResponse.fromJson(Map<String, dynamic> json) {
    return VerifyFaceResponse(
      userId: json['id'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      firstName: json['profile']?['firstname'] as String?,
      lastName: json['profile']?['lastname'] as String?,
      username: json['profile']?['username'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': userId,
        'email': email,
        'phone': phone,
        'role': role,
        'profile': {
          'username': username,
          'firstname': firstName,
          'lastname': lastName,
        },
      },
    };
  }
}
