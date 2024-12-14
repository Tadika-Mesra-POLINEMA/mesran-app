import 'package:mesran_app/src/features/events/domain/entities/event.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/user.dart';

class InvitationState {
  final Event? event;
  final List<Event> events;

  InvitationState({this.event, this.events = const []});
}

class InvitationLoading extends InvitationState {
  InvitationLoading() : super(event: null);
}

class InvitationLoaded extends InvitationState {
  final Event? event;

  InvitationLoaded(this.event) : super(event: null);
}

class InvitationsLoading extends InvitationState {
  InvitationsLoading() : super(event: null);
}

class InvitationsLoaded extends InvitationState {
  final List<Event> events;

  InvitationsLoaded(this.events) : super(event: null);
}

class InvitationError extends InvitationState {
  final String massage;

  InvitationError(this.massage) : super(event: null);
}
class InvitationsError extends InvitationState {
  final String massage;

  InvitationsError(this.massage) : super(event: null);
}
