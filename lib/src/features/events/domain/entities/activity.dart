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
}
