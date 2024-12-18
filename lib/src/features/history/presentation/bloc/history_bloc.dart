import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/history/domain/use_case/get_event_history_use_case.dart';
import 'package:mesran_app/src/features/history/presentation/bloc/history_event.dart';
import 'package:mesran_app/src/features/history/presentation/bloc/history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetEventHistoryUseCase _getEventHistoryUseCase;

  HistoryBloc(this._getEventHistoryUseCase) : super(HistoryInitial()) {
    on<HistoryLoad>(_onLoadHistory);
  }

  void _onLoadHistory(
    HistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());

    try {
      final eventHistories = await _getEventHistoryUseCase.call();

      if (eventHistories.isEmpty) {
        emit(HistoryLoaded(events: const []));
      } else {
        emit(HistoryLoaded(events: eventHistories));
      }
    } catch (error) {
      emit(HistoryError('Gagal memuat data riwayat.'));
    }
  }
}
