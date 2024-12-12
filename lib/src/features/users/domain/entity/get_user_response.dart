class GetUserResponse {
  final String id;
  final String email;
  final String phone;
  final String firstname;
  final String lastname;

  GetUserResponse({
    required this.id,
    required this.email,
    required this.phone,
    required this.firstname,
    required this.lastname,
  });

  factory GetUserResponse.fromJson(Map<String, dynamic> json) {
    return GetUserResponse(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      firstname: json['profile']['firstname'],
      lastname: json['profile']['lastname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}
