import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';

class AddActivityState extends Equatable {
  final String title;
  final String description;
  final TimeRange timeRange;

  const AddActivityState({
    required this.title,
    required this.description,
    required this.timeRange,
  });

  @override
  List<Object?> get props => [title, description, timeRange];
}

class AddActivityInitial extends AddActivityState {
  AddActivityInitial()
      : super(
            title: '',
            description: '',
            timeRange: TimeRange(
                startTime: TimeOfDay(hour: 0, minute: 0),
                endTime: TimeOfDay(hour: 0, minute: 0)));
}

class TitleChangedState extends AddActivityState {
  final String changedTitle;

  const TitleChangedState(
      {required this.changedTitle,
      required super.description,
      required super.timeRange})
      : super(title: changedTitle);

  @override
  List<Object?> get props => [changedTitle];
}

class DescriptionChangedState extends AddActivityState {
  final String changedDescription;

  const DescriptionChangedState(
      {required this.changedDescription,
      required super.title,
      required super.timeRange})
      : super(description: changedDescription);

  @override
  List<Object?> get props => [changedDescription];
}

class TimeRangeChangedState extends AddActivityState {
  final TimeRange changedTimeRange;

  const TimeRangeChangedState(
      {required this.changedTimeRange,
      required super.title,
      required super.description})
      : super(timeRange: changedTimeRange);

  @override
  List<Object?> get props => [changedTimeRange];
}

class AddActivityLoading extends AddActivityState {
  const AddActivityLoading(
      {required super.title,
      required super.description,
      required super.timeRange});
}

class AddActivitySuccess extends AddActivityState {
  const AddActivitySuccess(
      {required super.title,
      required super.description,
      required super.timeRange});
}

class AddActivityFailure extends AddActivityState {
  final String message;

  const AddActivityFailure(
      {required this.message,
      required super.title,
      required super.description,
      required super.timeRange});
}
