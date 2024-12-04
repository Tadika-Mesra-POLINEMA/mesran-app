import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mesran_app/src/features/events/domain/entities/activity.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';

class CreateEventActivityBloc
    extends Bloc<CreateEventActivityEvent, CreateEventActivityState> {
  final Isar _isar;

  CreateEventActivityBloc(this._isar) : super(CreateEventActivityState()) {
    on<CreateActivity>(_addActivity);
    on<ActivityNameChanged>(_activityNameChanged);
    on<ActivityDescriptionChanged>(_activityDescriptionChanged);
    on<ActivityTimeChanged>(_activityTimeChanged);

    Future.microtask(() {
      _loadActivities();
    });
  }

  Future<void> _loadActivities() async {
    final activities = await _isar.activities.where().findAll();
    debugPrint(activities.toString());
    emit(state.copyWith(activities: activities));
  }

  _addActivity(
    CreateActivity event,
    Emitter<CreateEventActivityState> emit,
  ) async {
    debugPrint('Adding activity');
    final name = event.name.trim();
    final description = event.description.trim();
    final activityStart = event.timeRange.startTime;
    final activityEnd = event.timeRange.endTime;

    final isNameValid = _validateName(name);
    final isDescriptionValid = _validateDescription(description);
    final isTimeRangeValid =
        _validateActivityTimeValid(activityStart, activityEnd);

    final now = DateTime.now();

    final Activity newActivity = Activity()
      ..name = name
      ..description = description
      ..activityStart = DateTime(now.year, now.month, now.day,
          activityStart.hour, activityStart.minute)
      ..activityEnd = DateTime(
          now.year, now.month, now.day, activityEnd.hour, activityEnd.minute)
      ..durationSeconds = DateTime(now.year, now.month, now.day,
              activityEnd.hour, activityEnd.minute)
          .difference(DateTime(now.year, now.month, now.day, activityStart.hour,
              activityStart.minute))
          .inSeconds;

    if (isNameValid && isDescriptionValid && isTimeRangeValid) {
      debugPrint(newActivity.toString());
      await _isar.writeTxn(() async {
        await _isar.activities.put(newActivity);
      });

      final updatedActivities = await _isar.activities.where().findAll();

      emit(state.copyWith(
        activities: updatedActivities,
        name: '',
        description: '',
        timeRange: TimeRange(
            startTime: TimeOfDay.fromDateTime(DateTime.now()),
            endTime: TimeOfDay.fromDateTime(DateTime.now())),
        isNameValid: false,
        isDescriptionValid: false,
      ));
    } else {
      emit(state.copyWith(
        isNameValid: isNameValid,
        isDescriptionValid: isDescriptionValid,
        isTimeRangeValid: isTimeRangeValid,
      ));
    }
  }

  _removeActivity(int id) async {
    await _isar.writeTxn(() async {
      await _isar.activities.delete(id);
    });
    // Reload activities after removal
    final updatedActivities = await _isar.activities.where().findAll();
    emit(state.copyWith(activities: updatedActivities));
  }

  _updateActivity(Activity updatedActivity) async {
    await _isar.writeTxn(() async {
      await _isar.activities.put(updatedActivity);
    });
    // Reload activities after update
    final updatedActivities = await _isar.activities.where().findAll();
    emit(state.copyWith(activities: updatedActivities));
  }

  _activityNameChanged(
    ActivityNameChanged event,
    Emitter<CreateEventActivityState> emit,
  ) {
    final name = event.name.trim();
    final isNameValid = _validateName(name);

    emit(state.copyWith(
      name: name,
      isNameValid: isNameValid,
      nameErrorMessage: isNameValid
          ? ''
          : 'Nama aktivitas harus diisi dan minimal 3 karakter',
    ));
  }

  _activityDescriptionChanged(
    ActivityDescriptionChanged event,
    Emitter<CreateEventActivityState> emit,
  ) {
    final description = event.description.trim();
    final isDescriptionValid = _validateDescription(description);

    emit(state.copyWith(
      description: description,
      isDescriptionValid: isDescriptionValid,
      descriptionErrorMessage: isDescriptionValid
          ? ''
          : 'Deskripsi aktivitas harus diisi dan minimal 10 karakter',
    ));
  }

  _activityTimeChanged(
    ActivityTimeChanged event,
    Emitter<CreateEventActivityState> emit,
  ) {
    final activityStart = event.activityStart;
    final activityEnd = event.activityEnd;

    final isActivityTimeValid =
        _validateActivityTimeValid(activityStart, activityEnd);

    emit(state.copyWith(
      timeRange: TimeRange(startTime: activityStart, endTime: activityEnd),
      isTimeRangeValid: isActivityTimeValid,
      timeRangeErrorMessage:
          isActivityTimeValid ? '' : 'Waktu aktivitas tidak valid',
    ));
  }

  _validateName(String name) => name.isNotEmpty && name.length >= 3;
  _validateDescription(String description) =>
      description.isNotEmpty && description.length >= 10;
  _validateActivityTimeValid(TimeOfDay activityStart, TimeOfDay activityEnd) {
    return activityEnd.hour >= activityStart.hour &&
        activityEnd.minute >= activityStart.minute;
  }
}
