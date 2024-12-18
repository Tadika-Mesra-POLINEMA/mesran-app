import 'package:mesran_app/src/features/home/domain/entity/user.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class Notification extends JsonParseable {
  final String eventId;
  final User sender;
  final User recipient;
  final String? content;
  final String? message;
  final NotificationType type;
  final DateTime sentAt;
  final DateTime createdAt;

  Notification({
    required this.eventId,
    required this.sender,
    required this.recipient,
    this.content,
    this.message,
    required this.type,
    required this.sentAt,
    required this.createdAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'sender': sender.toJson(),
      'recipient': recipient.toJson(),
      'content': content,
      'message': message,
      'type': type.toString().split('.').last,
      'sentAt': sentAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Notification.fromJson(Map<String, dynamic> json) {
    NotificationType type;

    try {
      type = NotificationType.values.firstWhere(
        (e) =>
            e.toString().split('.').last ==
            json['type'].toString().toLowerCase(),
      );
    } catch (e) {
      type = NotificationType.message;
    }

    return Notification(
      eventId: json['event']['id'],
      sender: User.fromJson(json['sender']),
      recipient: User.fromJson(json['recipient']),
      content: json['content'] ?? '',
      message: json['message'] ?? '',
      type: type,
      sentAt: DateTime.parse(json['sent_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

enum NotificationType { message, reminder, alert, confirmation }
