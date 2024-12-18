import 'package:mesran_app/src/features/events/data/repository/participant_repository_impl.dart';

class AcceptAttendanceUseCase {
  final ParticipantRepositoryImpl _participantRepositoryImpl;

  AcceptAttendanceUseCase(this._participantRepositoryImpl);

  Future<bool> call(String eventId, String userId) {
    return _participantRepositoryImpl.acceptParticipantAttendance(
        eventId, userId);
  }
}
