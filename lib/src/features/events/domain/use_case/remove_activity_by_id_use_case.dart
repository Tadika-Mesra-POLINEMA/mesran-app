import 'package:mesran_app/src/features/events/data/repository/activity_repository_impl.dart';

class RemoveActivityByIdUseCase {
  final ActivityRepositoryImpl _activityRepositoryImpl;

  RemoveActivityByIdUseCase(this._activityRepositoryImpl);

  Future<bool> call(String eventId, String activityId) async {
    return await _activityRepositoryImpl.removeById(eventId, activityId);
  }
}
