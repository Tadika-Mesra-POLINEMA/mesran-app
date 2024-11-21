class AuthFailure {
  final String message;
  final AuthStatusType status;
  final List<Object?>? errors = [];

  AuthFailure(this.status, {required this.message});

  factory AuthFailure.fromJson(Map<String, dynamic> json) {
    return AuthFailure(
      AuthStatusType.values.firstWhere((e) => e.toString() == json['status']),
      message: json['message'] ?? '',
    );
  }
}

enum AuthStatusType {
  success,
  error,
  fail,
}
