import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/events/domain/use_case/cancel_event_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/get_event_by_id_use_case.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_detail_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final GetEventByIdUseCase _getEventByIdUseCase;
  final CancelEventUseCase _cancelEventUseCase;

  EventDetailBloc(this._getEventByIdUseCase, this._cancelEventUseCase)
      : super(EventDetailState.loading()) {
    on<EventDetailLoad>(_onEventDetailLoad);
    on<EventDetailCancel>(_onEventDetailCancel);
  }

  void _onEventDetailLoad(
    EventDetailLoad event,
    Emitter<EventDetailState> emit,
  ) async {
    emit(EventDetailState.loading());

    try {
      final response = await _getEventByIdUseCase.call(event.id);

      response.fold((error) {
        emit(EventDetailState.failure());
      }, (success) {
        emit(EventDetailState.success(success));
      });
    } catch (e) {
      emit(EventDetailState.failure());
    }
  }

  void _onEventDetailCancel(
    EventDetailCancel event,
    Emitter<EventDetailState> emit,
  ) async {
    emit(EventDetailState.loading());

    try {
      final response = await _cancelEventUseCase.call(event.id);

      if (response) {
        emit(EventDetailState.success(state.event!));
      } else {
        emit(EventDetailState.failure());
      }
    } catch (e) {
      emit(EventDetailState.failure());
    }
  }
}
