import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';

class CreateEventActivityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadActivities extends CreateEventActivityEvent {}

class CreateActivity extends CreateEventActivityEvent {
  final String name;
  final String description;
  final TimeRange timeRange;

  CreateActivity({
    required this.name,
    required this.description,
    required this.timeRange,
  });
}

class RemoveActivity extends CreateEventActivityEvent {
  final String name;

  RemoveActivity({required this.name});
}

class ActivityNameChanged extends CreateEventActivityEvent {
  final String name;

  ActivityNameChanged({required this.name});
}

class ActivityDescriptionChanged extends CreateEventActivityEvent {
  final String description;

  ActivityDescriptionChanged({required this.description});
}

class ActivityTimeChanged extends CreateEventActivityEvent {
  final TimeOfDay activityStart;
  final TimeOfDay activityEnd;

  ActivityTimeChanged({required this.activityStart, required this.activityEnd});
}
