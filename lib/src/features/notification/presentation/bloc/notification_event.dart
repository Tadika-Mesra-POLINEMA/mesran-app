class NotificationEvent {
  const NotificationEvent();
}

class NotificationLoadEvent extends NotificationEvent {
  const NotificationLoadEvent();
}

class DeclineGuest extends NotificationEvent {
  final String eventId;
  final String userId;

  const DeclineGuest(this.eventId, this.userId);
}

class AcceptGuest extends NotificationEvent {
  final String eventId;
  final String userId;

  const AcceptGuest(this.eventId, this.userId);
}
