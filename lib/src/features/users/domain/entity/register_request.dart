class RegisterRequest {
  final String email;
  final String phone;
  final String name;
  final String password;

  RegisterRequest({
    required this.email,
    required this.phone,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'name': name,
      'password': password,
    };
  }
}
