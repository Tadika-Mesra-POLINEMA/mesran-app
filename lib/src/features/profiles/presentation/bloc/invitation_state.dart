import 'package:mesran_app/src/features/events/domain/entities/event.dart';

class InvitationState {
  final Event? event;
  final List<Event> events;

  InvitationState({this.event, this.events = const []});
}

class InvitationLoading extends InvitationState {
  InvitationLoading() : super(event: null);
}

class InvitationLoaded extends InvitationState {
  final Event? loadedEvent;

  InvitationLoaded(this.loadedEvent) : super(event: loadedEvent);
}

class InvitationsLoading extends InvitationState {
  InvitationsLoading() : super(event: null);
}

class InvitationsLoaded extends InvitationState {
  final List<Event> loadedEvents;

  InvitationsLoaded(this.loadedEvents) : super(events: loadedEvents);
}

class InvitationError extends InvitationState {
  final String massage;

  InvitationError(this.massage) : super(event: null);
}

class InvitationsError extends InvitationState {
  final String massage;

  InvitationsError(this.massage) : super(event: null);
}
