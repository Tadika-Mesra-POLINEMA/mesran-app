import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/domain/entities/attendance.dart';

abstract class AbstractParticipantRepository {
  Future<Either<Null, Attendance>> fetchParticipants(String eventId);
  Future<bool> acceptParticipantAttendance(String eventId, String userId);
}
