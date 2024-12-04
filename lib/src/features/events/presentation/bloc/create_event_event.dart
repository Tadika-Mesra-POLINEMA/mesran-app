import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object?> get props => [];
}

class NameChanged extends CreateEventEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class DescriptionChanged extends CreateEventEvent {
  final String description;

  const DescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class DateChanged extends CreateEventEvent {
  final DateTime date;

  const DateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class StartTimeChanged extends CreateEventEvent {
  final TimeOfDay startTime;

  const StartTimeChanged(this.startTime);

  @override
  List<Object?> get props => [startTime];
}

class DressCodeChanged extends CreateEventEvent {
  final String dresscode;

  const DressCodeChanged(this.dresscode);

  @override
  List<Object?> get props => [dresscode];
}

class ThemeChanged extends CreateEventEvent {
  final String theme;

  const ThemeChanged(this.theme);

  @override
  List<Object?> get props => [theme];
}

class LocationChanged extends CreateEventEvent {
  final String location;

  const LocationChanged(this.location);

  @override
  List<Object?> get props => [location];
}

class SubmitEvent extends CreateEventEvent {}
