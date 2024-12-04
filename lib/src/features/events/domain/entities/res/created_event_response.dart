import 'package:mesran_app/src/features/events/domain/entities/event.dart';

class CreatedEventResponse {
  final Event event;

  CreatedEventResponse({required this.event});

  factory CreatedEventResponse.fromJson(Map<String, dynamic> json) {
    return CreatedEventResponse(
      event: Event.fromJson(json['event']),
    );
  }
}
