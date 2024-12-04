class Event {
  final String name;
  final String description;
  final DateTime start;
  final DateTime end;
  final String location;
  final String theme;
  final String dresscode;

  Event({
    required this.name,
    required this.description,
    required this.start,
    required this.end,
    required this.location,
    required this.theme,
    required this.dresscode,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      description: json['description'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      location: json['location'],
      theme: json['theme'],
      dresscode: json['dresscode'],
    );
  }
}
