class User {
  final String id;
  final String username;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['profile']['username'],
      firstName: json['profile']['firstname'],
      lastName: json['profile']['lastname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile': {
        'username': username,
        'firstname': firstName,
        'lastname': lastName,
      },
    };
  }
}
