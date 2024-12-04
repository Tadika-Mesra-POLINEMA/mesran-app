import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_event_request.dart';
import 'package:mesran_app/src/features/events/domain/use_case/create_event_use_case.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final SharedPreferences _sharedPreferences;
  final CreateEventUseCase _createEventUseCase;

  CreateEventBloc(this._sharedPreferences, this._createEventUseCase)
      : super(CreateEventState()) {
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<DateChanged>(_onDateChanged);
    on<StartTimeChanged>(_onStartTimeChanged);
    on<LocationChanged>(_onLocationChanged);
    on<ThemeChanged>(_onChangeTheme);
    on<DressCodeChanged>(_onChangeDresscode);
    on<SubmitEvent>(_onSubmitEvent);

    Future.microtask(() {
      loadPreferences();
    });
  }

  void loadPreferences() {
    // Ambil data dari SharedPreferences
    final name = _sharedPreferences.getString('create_event_name') ?? '';
    final description =
        _sharedPreferences.getString('create_event_description') ?? '';
    final dateString = _sharedPreferences.getString('create_event_date');
    final startTimeString = _sharedPreferences.getString('create_event_start');
    final location =
        _sharedPreferences.getString('create_event_location') ?? '';
    final theme = _sharedPreferences.getString('create_event_theme') ?? '';
    final dresscode =
        _sharedPreferences.getString('create_event_dresscode') ?? '';

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
      parsedStartTime = startTimeString != null
          ? TimeOfDay.fromDateTime(DateTime.parse(startTimeString).toLocal())
          : TimeOfDay(hour: today.hour, minute: 0);
    } catch (e) {
      parsedStartTime = TimeOfDay(hour: today.hour, minute: 0);
    }

    add(NameChanged(name));
    add(DescriptionChanged(description));
    add(DateChanged(parsedDate));
    add(StartTimeChanged(parsedStartTime));
    add(LocationChanged(location));
    add(ThemeChanged(theme));
    add(DressCodeChanged(dresscode));
  }

  void _onNameChanged(NameChanged event, Emitter<CreateEventState> emit) {
    final name = event.name.trim();
    final isNameValid = _validateName(name);

    _sharedPreferences.setString('create_event_name', event.name);

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

    _sharedPreferences.setString('create_event_description', event.description);

    emit(state.copyWith(
      description: event.description,
      isDescriptionValid: isDescriptionValid,
      errorMessage: '',
    ));
  }

  void _onDateChanged(DateChanged event, Emitter<CreateEventState> emit) {
    final isDateValid = _validateDate(event.date);

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
    if (state.isFormValid) {
      try {
        // Submit data ke server
        final response = await _createEventUseCase(CreateEventRequest(
          name: state.name,
          description: state.description,
          date: state.date,
          start: DateTime(
            state.date.year,
            state.date.month,
            state.date.day,
            state.start.hour,
            state.start.minute,
          ),
          end: DateTime(
            state.date.year,
            state.date.month,
            state.date.day,
            state.start.hour,
            state.start.minute,
          ),
          location: state.location,
          theme: state.theme,
          dress: state.dresscode,
        ));

        emit(state.copyWith(errorMessage: ''));
      } catch (e) {
        emit(state.copyWith(errorMessage: e.toString()));
      }
    } else {
      emit(state.copyWith(
        errorMessage: 'Please fill all required fields correctly',
      ));
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
