import 'package:equatable/equatable.dart';
import 'package:mesran_app/src/features/history/domain/entity/history_event.dart';

class HistoryState extends Equatable {
  final List<HistoryEvent> events;

  const HistoryState({this.events = const []});

  @override
  List<Object> get props => [events];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  const HistoryLoaded({required super.events});

  @override
  List<Object> get props => [events];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object> get props => [message];
}
