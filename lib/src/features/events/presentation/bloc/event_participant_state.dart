import 'package:equatable/equatable.dart';
import 'package:mesran_app/src/features/events/domain/entities/attendance.dart';

class EventParticipantState extends Equatable {
  const EventParticipantState();

  @override
  List<Object> get props => [];
}

class EventParticipantInitial extends EventParticipantState {}

class EventParticipantLoading extends EventParticipantState {}

class EventParticipantLoaded extends EventParticipantState {}

class EventParticipantError extends EventParticipantState {
  final String message;

  const EventParticipantError(this.message);

  @override
  List<Object> get props => [message];
}

class EventParticipantEmpty extends EventParticipantState {}

class EventParticipantSuccess extends EventParticipantState {
  final Attendance attendance;

  const EventParticipantSuccess(this.attendance);

  @override
  List<Object> get props => [attendance];
}

class AcceptAttendanceSuccess extends EventParticipantState {
  final Attendance attendance;
  final String message;

  const AcceptAttendanceSuccess(this.message, this.attendance);

  @override
  List<Object> get props => [message, attendance];
}
