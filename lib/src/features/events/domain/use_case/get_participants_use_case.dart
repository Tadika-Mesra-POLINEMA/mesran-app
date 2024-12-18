import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/data/repository/participant_repository_impl.dart';
import 'package:mesran_app/src/features/events/domain/entities/attendance.dart';

class GetParticipantsUseCase {
  final ParticipantRepositoryImpl _participantRepositoryImpl;

  GetParticipantsUseCase(this._participantRepositoryImpl);

  Future<Either<Null, Attendance>> call(String eventId) async {
    return await _participantRepositoryImpl.fetchParticipants(eventId);
  }
}
