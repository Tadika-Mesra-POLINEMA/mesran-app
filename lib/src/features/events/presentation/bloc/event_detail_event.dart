class EventDetailEvent {
  const EventDetailEvent();
}

class EventDetailLoad extends EventDetailEvent {
  final String id;

  EventDetailLoad(this.id);
}

class EventDetailCancel extends EventDetailEvent {
  final String id;

  EventDetailCancel(this.id);
}
