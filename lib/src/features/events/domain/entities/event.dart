import 'activity.dart';
import 'participant.dart';

class Event {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final DateTime start;
  final String location;
  final String theme;
  final String dresscode;
  final List<Activity> activities;
  final List<Participant> participants;

  //==> Additional Attributes <==//
  final int memberCount;
  final bool isDone;
  final bool isCanceled;
  final bool isOwner;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.start,
    required this.location,
    required this.theme,
    required this.dresscode,
    required this.activities,
    required this.participants,
    required this.memberCount,
    required this.isDone,
    required this.isCanceled,
    required this.isOwner,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.parse(json['target_date'] ?? DateTime.now().toIso8601String()),
      start: DateTime.parse(json['event_start'] ?? DateTime.now().toIso8601String()),
      location: json['location'] ?? '',
      theme: json['theme'] ?? '',
      dresscode: json['dress'] ?? '',
      activities: (json['activities'] as List<dynamic>?)
          ?.map((activity) => Activity.fromJson(activity))
          .toList() ?? [],
      participants: (json['participants'] as List<dynamic>?)
          ?.map((participant) => Participant.fromJson(participant))
          .toList() ?? [],
      memberCount: json['member_count'] ?? 0,
      isDone: json['is_done'] ?? false,
      isCanceled: json['is_canceled'] ?? false,
      isOwner: json['is_owner'] ?? false,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
