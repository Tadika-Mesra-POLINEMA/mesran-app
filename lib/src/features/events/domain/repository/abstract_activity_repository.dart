import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/domain/entities/activity.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_activity_request.dart';

abstract class AbstractActivityRepository {
  Future<Either<Null, Activity>> addActivity(
      String eventId, CreateActivityRequest activity);
  Future<Either<Null, List<Activity>>> getActivitiesById(String eventId);
  Future<bool> removeById(String eventId, String activityId);
}
