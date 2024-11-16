class AuthRequest {
  final String? email;
  final String? phone;
  final String password;

  AuthRequest({
    this.email,
    this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}
