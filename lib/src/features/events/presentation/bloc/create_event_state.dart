import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CreateEventState extends Equatable {
  final String name;
  final String description;
  final DateTime date;
  final TimeOfDay start;
  final String theme;
  final String dresscode;
  final String location;
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
        isNameValid,
        isDescriptionValid,
        isDateValid,
        isStartValid,
        isLocationValid,
        isThemeValid,
        isDresscodeValid,
      ];
}
