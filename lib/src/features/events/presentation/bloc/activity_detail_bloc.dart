import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/events/domain/use_case/get_activities_by_event_id_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/remove_activity_by_id_use_case.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/activity_detail_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/activity_detail_state.dart';

class ActivityDetailBloc
    extends Bloc<ActivityDetailEvent, ActivityDetailState> {
  final GetActivitiesByEventIdUseCase _getActivitiesByEventIdUseCase;
  final RemoveActivityByIdUseCase _removeActivityByIdUseCase;

  ActivityDetailBloc(
      this._getActivitiesByEventIdUseCase, this._removeActivityByIdUseCase)
      : super(ActivityDetailInitial()) {
    on<FetchActivityDetail>(_onFetchActivities);
    on<RemoveActivity>(_onRemoveActivity);
  }

  Future<void> _onFetchActivities(
    FetchActivityDetail event,
    Emitter<ActivityDetailState> emit,
  ) async {
    emit(ActivityDetailLoading(activities: const []));

    try {
      final response = await _getActivitiesByEventIdUseCase.call(event.eventId);

      response.fold((_) => ActivityDetailLoaded(activities: const []),
          (activities) => emit(ActivityDetailLoaded(activities: activities)));
    } catch (error) {
      emit(ActivityDetailError('Gagal memuat aktivitas'));
    }
  }

  Future<void> _onRemoveActivity(
    RemoveActivity event,
    Emitter<ActivityDetailState> emit,
  ) async {
    emit(ActivityDetailLoading(activities: state.activities));

    try {
      final response = await _removeActivityByIdUseCase.call(
          event.eventId, event.activityId);

      if (response) {
        final activities = state.activities
            .where((activity) => activity.id != event.activityId)
            .toList();

        emit(ActivityDetailLoaded(activities: activities));
      } else {
        emit(ActivityDetailError('Gagal menghapus aktivitas'));
      }
    } catch (error) {
      emit(ActivityDetailError('Gagal memuat aktivitas'));
    }
  }
}
