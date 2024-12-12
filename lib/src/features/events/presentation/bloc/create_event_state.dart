import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';

class CreateEventState extends Equatable {
  final String name;
  final String description;
  final DateTime date;
  final TimeOfDay start;
  final String theme;
  final String dresscode;
  final String location;
  final List<String>? savedNames;
  final List<String>? savedDescriptions;
  final List<TimeRange>? savedTimeRanges;
  final String errorMessage;

  final bool isNameValid;
  final bool isDescriptionValid;
  final bool isDateValid;
  final bool isStartValid;
  final bool isLocationValid;
  final bool isThemeValid;
  final bool isDresscodeValid;

  bool get isFormValid =>
      isNameValid &&
      isDescriptionValid &&
      isDateValid &&
      isStartValid &&
      isLocationValid &&
      isThemeValid &&
      isDresscodeValid;

  CreateEventState({
    this.name = '',
    this.description = '',
    DateTime? date,
    this.start = const TimeOfDay(hour: 0, minute: 0),
    this.location = '',
    this.theme = '',
    this.dresscode = '',
    this.savedNames,
    this.savedDescriptions,
    this.savedTimeRanges,
    this.errorMessage = '',
    this.isNameValid = false,
    this.isDescriptionValid = false,
    this.isDateValid = false,
    this.isStartValid = false,
    this.isLocationValid = false,
    this.isThemeValid = false,
    this.isDresscodeValid = false,
  }) : date = date ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);

  CreateEventState copyWith({
    String? name,
    String? description,
    DateTime? date,
    TimeOfDay? start,
    String? location,
    String? theme,
    String? dresscode,
    List<String>? savedNames,
    List<String>? savedDescriptions,
    List<TimeRange>? savedTimeRanges,
    String? errorMessage,
    bool? isNameValid,
    bool? isDescriptionValid,
    bool? isDateValid,
    bool? isStartValid,
    bool? isLocationValid,
    bool? isThemeValid,
    bool? isDresscodeValid,
  }) {
    return CreateEventState(
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      start: start ?? this.start,
      location: location ?? this.location,
      theme: theme ?? this.theme,
      dresscode: dresscode ?? this.dresscode,
      savedNames: savedNames ?? this.savedNames,
      savedDescriptions: savedDescriptions ?? this.savedDescriptions,
      savedTimeRanges: savedTimeRanges ?? this.savedTimeRanges,
      errorMessage: errorMessage ?? this.errorMessage,
      isNameValid: isNameValid ?? this.isNameValid,
      isDescriptionValid: isDescriptionValid ?? this.isDescriptionValid,
      isDateValid: isDateValid ?? this.isDateValid,
      isStartValid: isStartValid ?? this.isStartValid,
      isLocationValid: isLocationValid ?? this.isLocationValid,
      isThemeValid: isThemeValid ?? this.isThemeValid,
      isDresscodeValid: isDresscodeValid ?? this.isDresscodeValid,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        date,
        start,
        location,
        theme,
        dresscode,
        savedNames,
        savedDescriptions,
        savedTimeRanges,
        isNameValid,
        isDescriptionValid,
        isDateValid,
        isStartValid,
        isLocationValid,
        isThemeValid,
        isDresscodeValid,
      ];
}

class CreateEventSuccess extends CreateEventState {
  CreateEventSuccess()
      : super(
          // Reset semua nilai ke default
          name: '',
          description: '',
          date: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          start: const TimeOfDay(hour: 0, minute: 0),
          location: '',
          theme: '',
          dresscode: '',
          savedNames: [],
          savedDescriptions: [],
          savedTimeRanges: [],
          errorMessage: '',
          isNameValid: false,
          isDescriptionValid: false,
          isDateValid: false,
          isStartValid: false,
          isLocationValid: false,
          isThemeValid: false,
          isDresscodeValid: false,
        );
}

class CreateEventFailed extends CreateEventState {
  final String message;

  CreateEventFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateEventFormNotValid extends CreateEventState {
  CreateEventFormNotValid(CreateEventState state)
      : super(
          name: state.name,
          description: state.description,
          date: state.date,
          start: state.start,
          location: state.location,
          theme: state.theme,
          dresscode: state.dresscode,
          errorMessage: 'Please fill all required fields correctly',
          isNameValid: state.isNameValid,
          isDescriptionValid: state.isDescriptionValid,
          isDateValid: state.isDateValid,
          isStartValid: state.isStartValid,
          isLocationValid: state.isLocationValid,
          isThemeValid: state.isThemeValid,
          isDresscodeValid: state.isDresscodeValid,
        );
}

class CreateEventLoading extends CreateEventState {
  CreateEventLoading(CreateEventState state)
      : super(
          name: state.name,
          description: state.description,
          date: state.date,
          start: state.start,
          location: state.location,
          theme: state.theme,
          dresscode: state.dresscode,
          savedNames: state.savedNames,
          savedDescriptions: state.savedDescriptions,
          savedTimeRanges: state.savedTimeRanges,
          errorMessage: state.errorMessage,
          isNameValid: state.isNameValid,
          isDescriptionValid: state.isDescriptionValid,
          isDateValid: state.isDateValid,
          isStartValid: state.isStartValid,
          isLocationValid: state.isLocationValid,
          isThemeValid: state.isThemeValid,
          isDresscodeValid: state.isDresscodeValid,
        );
}
