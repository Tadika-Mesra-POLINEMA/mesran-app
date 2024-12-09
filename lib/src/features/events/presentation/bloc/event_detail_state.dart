import 'package:mesran_app/src/features/events/domain/entities/event.dart';

class EventDetailState {
  final bool isLoading;
  final bool isFailure;
  final bool isSuccess;
  final Event? event;

  EventDetailState({
    this.isLoading = false,
    this.isFailure = false,
    this.isSuccess = false,
    required this.event,
  });

  factory EventDetailState.loading() {
    return EventDetailState(isLoading: true, event: null);
  }

  factory EventDetailState.failure() {
    return EventDetailState(isFailure: true, isLoading: false, event: null);
  }

  factory EventDetailState.success(Event event) {
    return EventDetailState(isSuccess: true, isLoading: false, event: event);
  }
}
