import 'package:flutter/material.dart';

class Activity {
  final String name;
  final String description;
  final TimeOfDay start;
  final TimeOfDay end;

  Activity({
    required this.name,
    required this.description,
    required this.start,
    required this.end,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name: json['title'] ?? '',
      description: json['description'] ?? '',
      start: TimeOfDay.fromDateTime(DateTime.parse(json['activity_start'] ?? DateTime.now().toIso8601String())),
      end: TimeOfDay.fromDateTime(DateTime.parse(json['activity_end'] ?? DateTime.now().toIso8601String())),
    );
  }
}
