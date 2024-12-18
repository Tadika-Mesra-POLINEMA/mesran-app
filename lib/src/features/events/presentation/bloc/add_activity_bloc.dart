import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_activity_request.dart';
import 'package:mesran_app/src/features/events/domain/use_case/create_activity_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/get_event_by_id_use_case.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/add_activity_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/add_activity_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';

class AddActivityBloc extends Bloc<AddActivityEvent, AddActivityState> {
  final GetEventByIdUseCase _getEventByIdUseCase;
  final CreateActivityUseCase _createActivityUseCase;

  AddActivityBloc(this._getEventByIdUseCase, this._createActivityUseCase)
      : super(AddActivityInitial()) {
    on<TitleChanged>(_onTitleChange);
    on<DescriptionChanged>(_onDescriptionChange);
    on<TimeRangeChanged>(_onTimeRangeChange);
    on<AddActivity>(_onAddActivity);
  }

  void _onTitleChange(
    TitleChanged event,
    Emitter<AddActivityState> emit,
  ) {
    final isValid = _validateTitleChanged(event.changedTitle);

    if (isValid) {
      emit(TitleChangedState(
          changedTitle: event.changedTitle,
          description: state.description,
          timeRange: state.timeRange));
    }
  }

  void _onDescriptionChange(
    DescriptionChanged event,
    Emitter<AddActivityState> emit,
  ) {
    final isValid = _validateDescriptionChanged(event.changedDescription);

    if (isValid) {
      emit(DescriptionChangedState(
          changedDescription: event.changedDescription,
          title: state.title,
          timeRange: state.timeRange));
    }
  }

  void _onTimeRangeChange(
    TimeRangeChanged event,
    Emitter<AddActivityState> emit,
  ) {
    final isValid = _validateTimeRangeChanged(event.timeRange);

    if (isValid) {
      emit(TimeRangeChangedState(
          changedTimeRange: event.timeRange,
          title: state.title,
          description: state.description));
    }
  }

  void _onAddActivity(
    AddActivity event,
    Emitter<AddActivityState> emit,
  ) async {
    if (!emit.isDone) {
      emit(AddActivityLoading(
        title: state.title,
        description: state.description,
        timeRange: state.timeRange,
      ));

      try {
        final eventResponse = await _getEventByIdUseCase.call(event.eventId);

        if (eventResponse.isLeft()) {
          if (!emit.isDone) {
            emit(AddActivityFailure(
                message: 'Gagal menambahkan aktivitas',
                title: state.title,
                description: state.description,
                timeRange: state.timeRange));
          }
          return;
        }

        final fetchedEvent = eventResponse.getOrElse(() => throw Exception());

        final eventId = fetchedEvent.id;
        final activityStart =
            getDateTime(fetchedEvent.date, state.timeRange.startTime);
        final activityEnd =
            getDateTime(fetchedEvent.date, state.timeRange.endTime);

        final response = await _createActivityUseCase.call(
            eventId,
            CreateActivityRequest(
                title: state.title,
                description: state.description,
                activityStart: activityStart,
                activityEnd: activityEnd));

        if (response.isLeft()) {
          if (!emit.isDone) {
            emit(AddActivityFailure(
                message: 'Gagal menambahkan aktivitas',
                title: state.title,
                description: state.description,
                timeRange: state.timeRange));
          }
          return;
        }

        if (!emit.isDone) {
          emit(AddActivitySuccess(
              title: '',
              description: '',
              timeRange: TimeRange(
                startTime: TimeOfDay(hour: 0, minute: 0),
                endTime: TimeOfDay(hour: 0, minute: 0),
              )));
        }
      } catch (error) {
        if (!emit.isDone) {
          emit(AddActivityFailure(
              message: 'Gagal menambahkan aktivitas',
              title: state.title,
              description: state.description,
              timeRange: state.timeRange));
        }
      }
    }
  }

  bool _validateTitleChanged(String title) {
    return title.isNotEmpty && title.length > 3;
  }

  bool _validateDescriptionChanged(String description) {
    return description.isNotEmpty && description.length > 10;
  }

  bool _validateTimeRangeChanged(TimeRange timeRange) {
    final startMinutes =
        timeRange.startTime.hour * 60 + timeRange.startTime.minute;
    final endMinutes = timeRange.endTime.hour * 60 + timeRange.endTime.minute;
    return startMinutes < endMinutes;
  }

  DateTime getDateTime(DateTime date, TimeOfDay time) {
    final now = DateTime.now();

    if (date.day < now.day) {
      return DateTime(now.year, now.month, now.day, time.hour, time.minute);
    }

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
