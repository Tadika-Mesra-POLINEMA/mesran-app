class PrivateRequest {
  final String? email;
  final String? oldPassword;
  final String? newPassword;
  final String? confirmPassword;

  PrivateRequest({
    this.email,
    this.oldPassword,
    this.newPassword,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password_before': oldPassword,
      'password': newPassword,
      // 'confirm_password': confirmPassword,
    };
  }
}
