class CreateEventRequest {
  final String name;
  final String description;
  final String location;
  final DateTime date;
  final DateTime start;
  final DateTime end;
  final String theme;
  final String dress;

  CreateEventRequest({
    required this.name,
    required this.description,
    required this.location,
    required this.date,
    required this.start,
    required this.end,
    required this.theme,
    required this.dress,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'date': date.toIso8601String(),
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'theme': theme,
      'dress': dress,
    };
  }
}
