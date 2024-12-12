import 'package:equatable/equatable.dart';

class EventDresscodeState extends Equatable {
  final String theme;
  final String dresscode;

  const EventDresscodeState({
    this.theme = '',
    this.dresscode = '',
  });

  @override
  List<Object> get props => [
        theme,
        dresscode,
      ];

  EventDresscodeState copyWith({
    String? theme,
    String? dresscode,
  }) {
    return EventDresscodeState(
      theme: theme ?? this.theme,
      dresscode: dresscode ?? this.dresscode,
    );
  }
}
