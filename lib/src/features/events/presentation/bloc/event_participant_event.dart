abstract class EventParticipantEvent {}

class FetchEventParticipant extends EventParticipantEvent {
  final String eventId;

  FetchEventParticipant(this.eventId);
}

class AcceptParticipant extends EventParticipantEvent {
  final String eventId;
  final String userId;

  AcceptParticipant(this.eventId, this.userId);
}
