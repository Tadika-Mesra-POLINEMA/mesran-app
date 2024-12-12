import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mesran_app/src/features/events/domain/entities/pref/create_activity_pref.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventActivityBloc
    extends Bloc<CreateEventActivityEvent, CreateEventActivityState> {
  final SharedPreferences _prefs;

  CreateEventActivityBloc(this._prefs)
      : super(const CreateEventActivityState()) {
    on<CreateActivity>(_addActivity);
    on<ActivityNameChanged>(_activityNameChanged);
    on<ActivityDescriptionChanged>(_activityDescriptionChanged);
    on<ActivityTimeChanged>(_activityTimeChanged);
    on<LoadActivities>(_loadActivities);
    on<RemoveActivity>(_removeActivity);
  }

  void _loadActivities(
    LoadActivities event,
    Emitter<CreateEventActivityState> emit,
  ) async {
    try {
      final names = _prefs.getStringList(CreateActivityPref.names) ?? [];
      final descriptions = _prefs.getStringList(CreateActivityPref.descriptions) ?? [];
      final starts = _prefs.getStringList(CreateActivityPref.starts) ?? [];
      final ends = _prefs.getStringList(CreateActivityPref.ends) ?? [];

      final savedTimeRanges = List.generate(starts.length, (index) {
        return TimeRange(
          startTime: _parseTimeOfDay(starts[index]),
          endTime: _parseTimeOfDay(ends[index]),
        );
      });

      emit(state.copyWith(
        savedNames: names,
        savedDescriptions: descriptions,
        savedTimeRanges: savedTimeRanges,
      ));
    } catch (e) {
      debugPrint('Error loading activities: $e');
    }
  }

  void _addActivity(
    CreateActivity event,
    Emitter<CreateEventActivityState> emit,
  ) async {
    final name = event.name.trim();
    final description = event.description.trim();
    final timeRange = event.timeRange;

    final isNameValid = _validateName(name);
    final isDescriptionValid = _validateDescription(description);
    final isTimeRangeValid = _validateTimeRange(timeRange);

    if (isNameValid && isDescriptionValid && isTimeRangeValid) {
      try {
        final updatedNames = [...state.savedNames, name];
        final updatedDescriptions = [...state.savedDescriptions, description];
        final updatedTimeRanges = [...state.savedTimeRanges, timeRange];

        await _prefs.setStringList(CreateActivityPref.names, updatedNames);
        await _prefs.setStringList(CreateActivityPref.descriptions, updatedDescriptions);
        await _prefs.setStringList(CreateActivityPref.starts, updatedTimeRanges
              .map((  tr) => _formatTimeOfDay(tr.startTime))
              .toList());
        await _prefs.setStringList(CreateActivityPref.ends, updatedTimeRanges
              .map((tr) => _formatTimeOfDay(tr.endTime))
              .toList());

        emit(state
            .copyWith(
              savedNames: updatedNames,
              savedDescriptions: updatedDescriptions,
              savedTimeRanges: updatedTimeRanges,
            )
            .resetCurrentActivity());
        emit(CreateEventActivitySuccess());
      } catch (e) {
        debugPrint('Error saving activity: $e');
        emit(state.copyWith(
          timeRangeErrorMessage: 'Gagal menyimpan aktivitas',
        ));
      }
    } else {
      emit(state.copyWith(
        name: name,
        description: description,
        timeRange: timeRange,
        isNameValid: isNameValid,
        isDescriptionValid: isDescriptionValid,
        isTimeRangeValid: isTimeRangeValid,
        nameErrorMessage: isNameValid
            ? ''
            : 'Nama aktivitas harus diisi dan minimal 3 karakter',
        descriptionErrorMessage: isDescriptionValid
            ? ''
            : 'Deskripsi aktivitas harus diisi dan minimal 10 karakter',
        timeRangeErrorMessage:
            isTimeRangeValid ? '' : 'Waktu aktivitas tidak valid',
      ));
    }
  }

  void _removeActivity(
    RemoveActivity event,
    Emitter<CreateEventActivityState> emit,
  ) async {
    try {
      final updatedNames = List<String>.from(state.savedNames)
        ..removeAt(event.index);
      final updatedDescriptions = List<String>.from(state.savedDescriptions)
        ..removeAt(event.index);
      final updatedTimeRanges = List<TimeRange>.from(state.savedTimeRanges)
        ..removeAt(event.index);

      await _prefs.setStringList(CreateActivityPref.names, updatedNames);
      await _prefs.setStringList(CreateActivityPref.descriptions, updatedDescriptions);
      await _prefs.setStringList(CreateActivityPref.starts, updatedTimeRanges
            .map((tr) => _formatTimeOfDay(tr.startTime))  
            .toList()); 
      await _prefs.setStringList(CreateActivityPref.ends, updatedTimeRanges
            .map((tr) => _formatTimeOfDay(tr.endTime)).toList());

      emit(state.copyWith(
        savedNames: updatedNames,
        savedDescriptions: updatedDescriptions,
        savedTimeRanges: updatedTimeRanges,
      ));
    } catch (e) {
      debugPrint('Error removing activity: $e');
    }
  }

  void _activityNameChanged(
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

  void _activityDescriptionChanged(
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

  void _activityTimeChanged(
    ActivityTimeChanged event,
    Emitter<CreateEventActivityState> emit,
  ) {
    final timeRange =
        TimeRange(startTime: event.activityStart, endTime: event.activityEnd);

    final isTimeRangeValid = _validateTimeRange(timeRange);

    emit(state.copyWith(
      timeRange: timeRange,
      isTimeRangeValid: isTimeRangeValid,
      timeRangeErrorMessage: isTimeRangeValid
          ? ''
          : 'Waktu mulai harus lebih awal daripada waktu selesai.',
    ));
  }

  bool _validateName(String name) => name.isNotEmpty && name.length >= 3;
  bool _validateDescription(String description) => description.isNotEmpty && description.length >= 10;

  bool _validateTimeRange(TimeRange? timeRange) {
    if (timeRange == null) {
      return false;
    }
    final startMinutes = timeRange.startTime.hour * 60 + timeRange.startTime.minute;
    final endMinutes = timeRange.endTime.hour * 60 + timeRange.endTime.minute;
    return startMinutes < endMinutes;
  }

  String _formatTimeOfDay(TimeOfDay time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
