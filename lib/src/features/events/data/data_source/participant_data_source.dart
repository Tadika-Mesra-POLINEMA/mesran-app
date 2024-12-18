import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/events/domain/entities/attendance.dart';

class ParticipantDataSource {
  final DioClient _dioClient;

  ParticipantDataSource(this._dioClient);

  Future<Either<Null, Attendance>> getParticipants(String eventId) async {
    try {
      final response =
          await _dioClient.get('/api/events/$eventId/participants/attendance');

      if (response.statusCode == 200) {
        return Right(Attendance.fromJson(response.data['data']));
      } else {
        return Left(null);
      }
    } on DioException {
      return Left(null);
    } catch (error) {
      return Left(null);
    }
  }

  Future<bool> acceptAttendance(String eventId, String userId) async {
    try {
      final response = await _dioClient.client
          .put('/api/events/$eventId/participants/$userId/attend');

      return response.statusCode == 200;
    } on DioException {
      return false;
    } catch (error) {
      return false;
    }
  }
}
