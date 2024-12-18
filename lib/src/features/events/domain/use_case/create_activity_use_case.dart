import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/data/repository/activity_repository_impl.dart';
import 'package:mesran_app/src/features/events/domain/entities/activity.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_activity_request.dart';

class CreateActivityUseCase {
  final ActivityRepositoryImpl _activityRepositoryImpl;

  CreateActivityUseCase(this._activityRepositoryImpl);

  Future<Either<Null, Activity>> call(
      String eventId, CreateActivityRequest activity) {
    return _activityRepositoryImpl.addActivity(eventId, activity);
  }
}
