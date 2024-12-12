import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/events/domain/entities/pref/create_activity_pref.dart';
import 'package:mesran_app/src/features/events/domain/entities/pref/create_event_pref.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_event_request.dart';
import 'package:mesran_app/src/features/events/domain/use_case/create_event_use_case.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final SharedPreferences _sharedPreferences;
  final CreateEventUseCase _createEventUseCase;

  CreateEventBloc(this._sharedPreferences, this._createEventUseCase)
      : super(CreateEventState()) {
    on<LoadEvent>(_loadEvent);
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<DateChanged>(_onDateChanged);
    on<StartTimeChanged>(_onStartTimeChanged);
    on<LocationChanged>(_onLocationChanged);
    on<ThemeChanged>(_onChangeTheme);
    on<DressCodeChanged>(_onChangeDresscode);
    on<SubmitEvent>(_onSubmitEvent);
  }

  void _loadEvent(LoadEvent event, Emitter<CreateEventState> emit) {
    final name = _sharedPreferences.getString(CreateEventPref.name) ?? '';
    final description =
        _sharedPreferences.getString(CreateEventPref.description) ?? '';
    final dateString = _sharedPreferences.getString(CreateEventPref.date);
    final startTimeString = _sharedPreferences.getString(CreateEventPref.start);
    final location =
        _sharedPreferences.getString(CreateEventPref.location) ?? '';
    final theme = _sharedPreferences.getString(CreateEventPref.theme) ?? '';
    final dresscode =
        _sharedPreferences.getString(CreateEventPref.dresscode) ?? '';

    //==> Saved Activities <==//
    final savedNames =
        _sharedPreferences.getStringList(CreateActivityPref.names) ?? [];
    final savedDescriptions =
        _sharedPreferences.getStringList(CreateActivityPref.descriptions) ?? [];
    final savedStartTimes =
        _sharedPreferences.getStringList(CreateActivityPref.starts) ?? [];
    final savedEndTimes =
        _sharedPreferences.getStringList(CreateActivityPref.ends) ?? [];

    final today = DateTime.now();

    DateTime parsedDate;
    try {
      parsedDate = dateString != null
          ? DateTime.parse(dateString).toLocal()
          : DateTime(today.year, today.month, today.day);
    } catch (e) {
      parsedDate = DateTime(today.year, today.month, today.day);
    }

    TimeOfDay parsedStartTime;

    try {
      if (startTimeString != null) {
        final parts = startTimeString.split(':');
        if (parts.length == 2) {
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);
          parsedStartTime = TimeOfDay(hour: hour, minute: minute);
        } else {
          throw FormatException('Invalid time format');
        }
      } else {
        parsedStartTime = TimeOfDay(hour: today.hour, minute: 0);
      }
    } catch (e) {
      parsedStartTime = TimeOfDay(hour: today.hour, minute: 0);
    }

    final List<TimeRange> activityTimeRanges =
        List.generate(savedStartTimes.length, (index) {
      final startTime = savedStartTimes[index];
      final endTime = savedEndTimes[index];

      final startParts = startTime.split(':');
      final endParts = endTime.split(':');

      final startHour = int.parse(startParts[0]);
      final startMinute = int.parse(startParts[1]);
      final endHour = int.parse(endParts[0]);
      final endMinute = int.parse(endParts[1]);

      return TimeRange(
        startTime: TimeOfDay(hour: startHour, minute: startMinute),
        endTime: TimeOfDay(hour: endHour, minute: endMinute),
      );
    });

    emit(
      state.copyWith(
        name: name,
        description: description,
        date: parsedDate,
        start: parsedStartTime,
        location: location,
        theme: theme,
        dresscode: dresscode,
        savedNames: savedNames,
        savedDescriptions: savedDescriptions,
        savedTimeRanges: activityTimeRanges,
        isNameValid: _validateName(name),
        isDescriptionValid: _validateDescription(description),
        isDateValid: _validateDate(parsedDate),
        isStartValid: _validateStartTime(parsedStartTime),
        isLocationValid: _validateLocation(location),
        isThemeValid: _validateTheme(theme),
        isDresscodeValid: _validateDresscode(dresscode),
      ),
    );
  }

  void _onNameChanged(NameChanged event, Emitter<CreateEventState> emit) {
    final name = event.name.trim();
    final isNameValid = _validateName(name);

    _sharedPreferences.setString(CreateEventPref.name, event.name);

    emit(state.copyWith(
      name: event.name,
      isNameValid: isNameValid,
      errorMessage: '',
    ));
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<CreateEventState> emit) {
    final description = event.description.trim();
    final isDescriptionValid = _validateDescription(description);

    _sharedPreferences.setString(
        CreateEventPref.description, event.description);

    emit(state.copyWith(
      description: event.description,
      isDescriptionValid: isDescriptionValid,
      errorMessage: '',
    ));
  }

  void _onDateChanged(DateChanged event, Emitter<CreateEventState> emit) {
    final isDateValid = _validateDate(event.date);

    _sharedPreferences.setString(CreateEventPref.date, event.date.toString());

    emit(state.copyWith(
      date: event.date,
      isDateValid: isDateValid,
      errorMessage: '',
    ));
  }

  void _onStartTimeChanged(
      StartTimeChanged event, Emitter<CreateEventState> emit) {
    final normalizeTime = TimeOfDay(hour: event.startTime.hour, minute: 0);
    final isStartValid = _validateStartTime(normalizeTime);

    final timeString =
        '${normalizeTime.hour.toString().padLeft(2, '0')}:${normalizeTime.minute.toString().padLeft(2, '0')}';
    _sharedPreferences.setString(CreateEventPref.start, timeString);

    emit(state.copyWith(
      start: event.startTime,
      isStartValid: isStartValid,
      errorMessage: '',
    ));
  }

  void _onLocationChanged(
      LocationChanged event, Emitter<CreateEventState> emit) {
    final location = event.location;
    final isLocationValid = _validateLocation(location);

    _sharedPreferences.setString(CreateEventPref.location, event.location);

    emit(state.copyWith(
      location: event.location,
      isLocationValid: isLocationValid,
      errorMessage: '',
    ));
  }

  void _onChangeTheme(ThemeChanged event, Emitter<CreateEventState> emit) {
    debugPrint(event.theme);
    if (_validateTheme(event.theme)) {
      emit(state.copyWith(theme: event.theme, isThemeValid: true));
    }
  }

  void _onChangeDresscode(
      DressCodeChanged event, Emitter<CreateEventState> emit) {
    debugPrint(event.dresscode);
    if (_validateDresscode(event.dresscode)) {
      emit(state.copyWith(dresscode: event.dresscode, isDresscodeValid: true));
    }
  }

  Future<void> _onSubmitEvent(
      SubmitEvent event, Emitter<CreateEventState> emit) async {
    emit(CreateEventLoading(state));

    if (state.isFormValid) {
      try {
        final startTime = DateTime(state.date.year, state.date.month,
            state.date.day, state.start.hour, state.start.minute, 0);

        List<Activity> activitiesJson = [];

        for (int i = 0; i < state.savedNames!.length; i++) {
          final startActivity = state.savedTimeRanges![i].startTime;
          final endActivity = state.savedTimeRanges![i].endTime;

          activitiesJson.add(Activity(
            name: state.savedNames![i],
            description: state.savedDescriptions![i],
            start: DateTime(state.date.year, state.date.month, state.date.day,
                startActivity.hour, startActivity.minute),
            end: DateTime(state.date.year, state.date.month, state.date.day,
                endActivity.hour, endActivity.minute),
          ));
        }

        // Submit data ke server
        final response = await _createEventUseCase.call(CreateEventRequest(
            name: state.name,
            description: state.description,
            date: state.date,
            start: startTime,
            location: state.location,
            theme: state.theme,
            dress: state.dresscode,
            activities: activitiesJson));

        return response.fold((error) {
          emit(CreateEventFailed(error.message));
        }, (success) {
          emit(CreateEventSuccess());
        });
      } catch (e) {
        emit(state.copyWith(errorMessage: e.toString()));
      }
    } else {
      emit(CreateEventFormNotValid(state));
    }
  }

  /// Validation
  bool _validateName(String name) =>
      name.trim().isNotEmpty && name.trim().length >= 3;
  bool _validateDescription(String description) =>
      description.trim().isNotEmpty && description.trim().length >= 10;
  bool _validateLocation(String address) =>
      address.trim().isNotEmpty && address.trim().length >= 3;
  bool _validateDate(DateTime date) {
    final today = DateTime.now();
    final dateToValidate = DateTime(today.year, today.month, today.day);

    return date.isAtSameMomentAs(dateToValidate) ||
        date.isAfter(dateToValidate);
  }

  bool _validateStartTime(TimeOfDay startTime) {
    final timeToValidate = TimeOfDay(hour: 0, minute: 0);

    return startTime.hour > timeToValidate.hour ||
        (startTime.hour == timeToValidate.hour &&
            startTime.minute >= timeToValidate.minute);
  }

  bool _validateTheme(String theme) => theme.isNotEmpty;
  bool _validateDresscode(String dresscode) =>
      dresscode.isNotEmpty && dresscode == 'Formal' ||
      dresscode == 'Kasual' ||
      dresscode == 'Olahraga' ||
      dresscode == 'Tradisional' ||
      dresscode == 'Horror' ||
      dresscode == 'Anime';
}
