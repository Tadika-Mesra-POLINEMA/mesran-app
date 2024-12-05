class CreateEventRequest {
  final String name;
  final String description;
  final String location;
  final DateTime date;
  final DateTime start;
  final String theme;
  final String dress;

  CreateEventRequest({
    required this.name,
    required this.description,
    required this.location,
    required this.date,
    required this.start,
    required this.theme,
    required this.dress,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'target_date': formatEventDate(date),
      'event_start': formatEventStart(start),
      'theme': theme,
      'dress': dress,
      'activities': [],
    };
  }

  String formatEventDate(DateTime date) {
    return date.toIso8601String();
  }

  String formatEventStart(DateTime eventStart) {
    return '${eventStart.toIso8601String().substring(0, 19)}.000Z';
  }
}
