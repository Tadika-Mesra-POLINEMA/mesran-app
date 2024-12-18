import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/data/data_source/participant_data_source.dart';
import 'package:mesran_app/src/features/events/domain/entities/attendance.dart';
import 'package:mesran_app/src/features/events/domain/repository/abstract_participant_repository.dart';

class ParticipantRepositoryImpl extends AbstractParticipantRepository {
  final ParticipantDataSource _participantDataSource;

  ParticipantRepositoryImpl(this._participantDataSource);

  @override
  Future<Either<Null, Attendance>> fetchParticipants(String eventId) async {
    return await _participantDataSource.getParticipants(eventId);
  }

  @override
  Future<bool> acceptParticipantAttendance(
      String eventId, String userId) async {
    return await _participantDataSource.acceptAttendance(eventId, userId);
  }
}
