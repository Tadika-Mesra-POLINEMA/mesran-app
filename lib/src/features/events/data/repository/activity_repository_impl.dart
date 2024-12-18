import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/data/data_source/activity_data_source.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_activity_request.dart';
import 'package:mesran_app/src/features/events/domain/repository/abstract_activity_repository.dart';
import 'package:mesran_app/src/features/events/domain/entities/activity.dart';

class ActivityRepositoryImpl extends AbstractActivityRepository {
  final ActivityDataSource _activityDataSource;

  ActivityRepositoryImpl(this._activityDataSource);

  @override
  Future<Either<Null, Activity>> addActivity(
      String eventId, CreateActivityRequest activity) async {
    return await _activityDataSource.addActivity(eventId, activity);
  }

  @override
  Future<Either<Null, List<Activity>>> getActivitiesById(String eventId) async {
    return await _activityDataSource.getActivities(eventId);
  }

  @override
  Future<bool> removeById(String eventId, String activityId) async {
    return await _activityDataSource.removeActivity(eventId, activityId);
  }
}
