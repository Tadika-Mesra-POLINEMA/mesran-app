class User {
  final String firstName;
  final String lastName;
  final String phone;

  User({required this.firstName, required this.lastName, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['profile']['firstname'],
        lastName: json['profile']['lastname'],
        phone: json['phone']);
  }
}
