class Participant {
  final String id;
  final String email;
  final String phone;
  final Profile profile;

  Participant({
    required this.id,
    required this.email,
    required this.phone,
    required this.profile,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profile: json['profile'] != null
          ? Profile.fromJson(json['profile'])
          : Profile(username: '', firstname: '', lastname: ''),
    );
  }
}

class Profile {
  final String username;
  final String firstname;
  final String lastname;

  Profile({
    required this.username,
    required this.firstname,
    required this.lastname,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}
