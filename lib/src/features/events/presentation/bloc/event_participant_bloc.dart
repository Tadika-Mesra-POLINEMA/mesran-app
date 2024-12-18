import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/events/domain/use_case/accept_attendance_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/get_participants_use_case.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_participant_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_participant_state.dart';

class EventParticipantBloc
    extends Bloc<EventParticipantEvent, EventParticipantState> {
  final GetParticipantsUseCase _getParticipantsUseCase;
  final AcceptAttendanceUseCase _acceptAttendanceUseCase;

  EventParticipantBloc(
      this._getParticipantsUseCase, this._acceptAttendanceUseCase)
      : super(EventParticipantInitial()) {
    on<FetchEventParticipant>(_onLoadParticipant);
    on<AcceptParticipant>(_acceptParticipantAttendance);
  }

  void _onLoadParticipant(
    FetchEventParticipant event,
    Emitter<EventParticipantState> emit,
  ) async {
    emit(EventParticipantLoading());

    try {
      final participants = await _getParticipantsUseCase.call(event.eventId);

      participants.fold((_) => emit(EventParticipantEmpty()),
          (attendance) => emit(EventParticipantSuccess(attendance)));
    } catch (error) {
      emit(EventParticipantError('Failed to load participants'));
    }
  }

  void _acceptParticipantAttendance(
    AcceptParticipant event,
    Emitter<EventParticipantState> emit,
  ) async {
    emit(EventParticipantLoading());

    try {
      final isSuccessAttend =
          await _acceptAttendanceUseCase.call(event.eventId, event.userId);

      if (isSuccessAttend) {
        final participants = await _getParticipantsUseCase.call(event.eventId);

        participants.fold(
            (_) => emit(EventParticipantEmpty()),
            (attendance) => emit(AcceptAttendanceSuccess(
                'Berhasil memperbarui daftar hadir tamu', attendance)));
      } else {
        emit(EventParticipantError('Gagal memperbarui daftar hadir tamu'));
      }
    } catch (error) {
      emit(EventParticipantError('Gagal memperbarui daftar hadir tamu'));
    }
  }
}
