class EventDetailEvent {
  const EventDetailEvent();
}

class EventDetailLoad extends EventDetailEvent {
  final String id;

  EventDetailLoad(this.id);
}
