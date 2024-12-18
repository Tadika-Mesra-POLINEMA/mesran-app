import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/data/repository/activity_repository_impl.dart';
import 'package:mesran_app/src/features/events/domain/entities/activity.dart';

class GetActivitiesByEventIdUseCase {
  final ActivityRepositoryImpl _activityRepositoryImpl;

  GetActivitiesByEventIdUseCase(this._activityRepositoryImpl);

  Future<Either<Null, List<Activity>>> call(String eventId) async {
    return await _activityRepositoryImpl.getActivitiesById(eventId);
  }
}
