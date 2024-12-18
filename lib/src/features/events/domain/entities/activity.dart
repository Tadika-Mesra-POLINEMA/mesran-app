import 'package:flutter/material.dart';

class Activity {
  final String id;
  final String name;
  final String description;
  final TimeOfDay start;
  final TimeOfDay end;

  Activity({
    required this.id,
    required this.name,
    required this.description,
    required this.start,
    required this.end,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] ?? '',
      name: json['title'] ?? '',
      description: json['description'] ?? '',
      start: TimeOfDay.fromDateTime(DateTime.parse(
          json['activity_start'] ?? DateTime.now().toIso8601String())),
      end: TimeOfDay.fromDateTime(DateTime.parse(
          json['activity_end'] ?? DateTime.now().toIso8601String())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'description': description,
      'activity_start': DateTime(0, 0, 0, start.hour, start.minute),
      'activity_end': DateTime(0, 0, 0, end.hour, end.minute),
    };
  }
}
