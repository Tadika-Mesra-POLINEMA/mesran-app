import 'package:equatable/equatable.dart';

/// Event dresscode event
class EventDresscodeEvent extends Equatable {
  const EventDresscodeEvent();

  @override
  List<Object> get props => [];
}

/// Load event dresscode event
class LoadEventDresscode extends EventDresscodeEvent {
  const LoadEventDresscode();
}

/// Change theme event
class ChangeTheme extends EventDresscodeEvent {
  final String theme;

  const ChangeTheme({required this.theme});

  @override
  List<Object> get props => [theme];
}

/// Change dresscode event
class ChangeDresscode extends EventDresscodeEvent {
  final String dresscode;

  const ChangeDresscode({required this.dresscode});

  @override
  List<Object> get props => [dresscode];
}
