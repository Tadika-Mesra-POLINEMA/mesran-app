class RegisterRequest {
  final String email;
  final String phone;
  final String username;
  final String password;

  RegisterRequest({
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
    };
  }
}
