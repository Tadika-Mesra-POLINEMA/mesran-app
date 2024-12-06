import 'package:mesran_app/src/features/home/domain/entity/user.dart';

class EventHome {
  final String id;
  final String name;
  final DateTime date;
  final String description;

  EventHome({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
  });

  factory EventHome.fromJson(Map<String, dynamic> json) {
    return EventHome(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['target_date']),
      description: json['description'],
    );
  }
}

class EventHomeDetail {
  final String name;
  final String date;
  final String description;
  final DateTime targetDate;
  final DateTime eventStart;
  final String location;
  final String theme;
  final String dresscode;
  final int memberCount;
  final bool isDone;
  final bool isCanceled;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  EventHomeDetail({
    required this.name,
    required this.date,
    required this.description,
    required this.targetDate,
    required this.eventStart,
    required this.location,
    required this.theme,
    required this.dresscode,
    required this.memberCount,
    required this.isDone,
    required this.isCanceled,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
}
