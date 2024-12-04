import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mesran_app/src/features/events/domain/entities/activity.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';

class CreateEventActivityState extends Equatable {
  final List<Activity> activities;
  final String name;
  final String description;
  final TimeRange timeRange;
  final bool isNameValid;
  final bool isDescriptionValid;
  final bool isTimeRangeValid;
  final bool isLoading;
  final String? nameErrorMessage;
  final String? descriptionErrorMessage;
  final String? timeRangeErrorMessage;

  CreateEventActivityState({
    this.activities = const <Activity>[],
    this.name = '',
    this.description = '',
    TimeRange? timeRange,
    this.isNameValid = false,
    this.isDescriptionValid = false,
    this.isTimeRangeValid = false,
    this.isLoading = false,
    this.nameErrorMessage,
    this.descriptionErrorMessage,
    this.timeRangeErrorMessage,
  }) : timeRange = timeRange ??
            TimeRange(
              startTime: TimeOfDay(hour: 0, minute: 0),
              endTime: TimeOfDay(hour: 0, minute: 0),
            );

  @override
  List<Object?> get props => [
        activities,
        name,
        description,
        timeRange,
        isNameValid,
        isDescriptionValid,
        isTimeRangeValid,
        isLoading,
        nameErrorMessage,
        descriptionErrorMessage,
        timeRangeErrorMessage,
      ];

  CreateEventActivityState copyWith({
    List<Activity>? activities,
    String? name,
    String? description,
    TimeRange? timeRange,
    bool? isNameValid,
    bool? isDescriptionValid,
    bool? isTimeRangeValid,
    bool? isLoading,
    String? nameErrorMessage,
    String? descriptionErrorMessage,
    String? timeRangeErrorMessage,
  }) {
    return CreateEventActivityState(
      activities: activities ?? this.activities,
      name: name ?? this.name,
      description: description ?? this.description,
      timeRange: timeRange ?? this.timeRange,
      isNameValid: isNameValid ?? this.isNameValid,
      isDescriptionValid: isDescriptionValid ?? this.isDescriptionValid,
      isTimeRangeValid: isTimeRangeValid ?? this.isTimeRangeValid,
      isLoading: isLoading ?? this.isLoading,
      nameErrorMessage: nameErrorMessage ?? this.nameErrorMessage,
      descriptionErrorMessage:
          descriptionErrorMessage ?? this.descriptionErrorMessage,
      timeRangeErrorMessage:
          timeRangeErrorMessage ?? this.timeRangeErrorMessage,
    );
  }
}
