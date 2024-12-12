class CreateEventRequest {
  final String name;
  final String description;
  final String location;
  final DateTime date;
  final DateTime start;
  final String theme;
  final String dress;
  final List<Activity> activities;

  CreateEventRequest({
    required this.name,
    required this.description,
    required this.location,
    required this.date,
    required this.start,
    required this.theme,
    required this.dress,
    required this.activities,
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
      'activities': activities.map((activity) => activity.toJson()).toList(),
    };
  }

  String formatEventDate(DateTime date) {
    return '${date.toIso8601String().substring(0, 19)}.000Z';
  }

  String formatEventStart(DateTime eventStart) {
    return '${eventStart.toIso8601String().substring(0, 19)}.000Z';
  }
}

class Activity {
  final String name;
  final String description;
  final DateTime start;
  final DateTime end;

  Activity({
    required this.name,
    required this.description,
    required this.start,
    required this.end,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': name,
      'description': description,
      'activity_start': formatEventStart(start),
      'activity_end': formatEventStart(end),
    };
  }

  String formatEventStart(DateTime eventStart) {
    return '${eventStart.toIso8601String().substring(0, 19)}.000Z';
  }
}
