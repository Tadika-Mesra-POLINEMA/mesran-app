class CreateActivityRequest {
  final String title;
  final String description;
  final DateTime activityStart;
  final DateTime activityEnd;

  CreateActivityRequest({
    required this.title,
    required this.description,
    required this.activityStart,
    required this.activityEnd,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'activity_start': formatEventStart(activityStart),
      'activity_end': formatEventStart(activityEnd),
    };
  }

  String formatEventStart(DateTime eventStart) {
    return '${eventStart.toIso8601String().substring(0, 19)}.000Z';
  }
}
