import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/events/domain/entities/activity.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_activity_request.dart';

class ActivityDataSource {
  final DioClient _dioClient;

  ActivityDataSource(this._dioClient);

  Future<Either<Null, Activity>> addActivity(
      String eventId, CreateActivityRequest activity) async {
    try {
      final response = await _dioClient.post('/api/events/$eventId/activities',
          data: activity.toJson());

      if (response.statusCode == 201) {
        return Right(Activity.fromJson(response.data['data']));
      } else {
        return Left(null);
      }
    } on DioException {
      return Left(null);
    } catch (error) {
      return Left(null);
    }
  }

  Future<Either<Null, List<Activity>>> getActivities(String eventId) async {
    try {
      final response = await _dioClient.get('/api/events/$eventId/activities');

      if (response.statusCode == 200) {
        return Right((response.data['data'] as List)
            .map((e) => Activity.fromJson(e))
            .toList());
      } else {
        return Left(null);
      }
    } on DioException {
      return Left(null);
    } catch (error) {
      return Left(null);
    }
  }

  Future<bool> removeActivity(String eventId, String activityId) async {
    try {
      final response = await _dioClient.client
          .delete('/api/events/$eventId/activities/$activityId');

      return response.statusCode == 200;
    } on DioException {
      return false;
    } catch (error) {
      return false;
    }
  }
}
