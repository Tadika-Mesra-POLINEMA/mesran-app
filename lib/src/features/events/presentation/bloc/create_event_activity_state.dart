import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';

class CreateEventActivityState extends Equatable {
  final String name;
  final String description;
  final TimeRange timeRange;

  final List<String> savedNames;
  final List<String> savedDescriptions;
  final List<TimeRange> savedTimeRanges;

  final bool isNameValid;
  final bool isDescriptionValid;
  final bool isTimeRangeValid;
  final bool isLoading;

  final String? nameErrorMessage;
  final String? descriptionErrorMessage;
  final String? timeRangeErrorMessage;

  const CreateEventActivityState({
    this.name = '',
    this.description = '',
    this.timeRange = const TimeRange(
        startTime: TimeOfDay(hour: 0, minute: 0),
        endTime: TimeOfDay(hour: 0, minute: 0)),
    this.savedNames = const [],
    this.savedDescriptions = const [],
    this.savedTimeRanges = const [],
    this.isNameValid = false,
    this.isDescriptionValid = false,
    this.isTimeRangeValid = false,
    this.isLoading = false,
    this.nameErrorMessage,
    this.descriptionErrorMessage,
    this.timeRangeErrorMessage,
  });

  CreateEventActivityState copyWith({
    String? name,
    String? description,
    TimeRange? timeRange,
    List<String>? savedNames,
    List<String>? savedDescriptions,
    List<TimeRange>? savedTimeRanges,
    bool? isNameValid,
    bool? isDescriptionValid,
    bool? isTimeRangeValid,
    bool? isLoading,
    String? nameErrorMessage,
    String? descriptionErrorMessage,
    String? timeRangeErrorMessage,
  }) {
    return CreateEventActivityState(
      name: name ?? this.name,
      description: description ?? this.description,
      timeRange: timeRange ?? this.timeRange,
      savedNames: savedNames ?? this.savedNames,
      savedDescriptions: savedDescriptions ?? this.savedDescriptions,
      savedTimeRanges: savedTimeRanges ?? this.savedTimeRanges,
      isNameValid: isNameValid ?? this.isNameValid,
      isDescriptionValid: isDescriptionValid ?? this.isDescriptionValid,
      isTimeRangeValid: isTimeRangeValid ?? this.isTimeRangeValid,
      isLoading: isLoading ?? this.isLoading,
      nameErrorMessage: nameErrorMessage ?? this.nameErrorMessage,
      descriptionErrorMessage: descriptionErrorMessage ?? this.descriptionErrorMessage,
      timeRangeErrorMessage: timeRangeErrorMessage ?? this.timeRangeErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        timeRange,
        savedNames,
        savedDescriptions,
        savedTimeRanges,
        isNameValid,
        isDescriptionValid,
        isTimeRangeValid,
        isLoading,
        nameErrorMessage,
        descriptionErrorMessage,
        timeRangeErrorMessage,
      ];

  CreateEventActivityState resetCurrentActivity() {
    return copyWith(
      name: '',
      description: '',
      timeRange: null,
      isNameValid: false,
      isDescriptionValid: false,
      isTimeRangeValid: false,
      nameErrorMessage: null,
      descriptionErrorMessage: null,
      timeRangeErrorMessage: null,
    );
  }
}

class CreateEventActivitySuccess extends CreateEventActivityState {}