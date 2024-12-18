import 'package:mesran_app/src/features/history/data/repository/history_repository_impl.dart';
import 'package:mesran_app/src/features/history/domain/entity/history_event.dart';

class GetEventHistoryUseCase {
  final HistoryRepositoryImpl _historyRepositoryImpl;

  GetEventHistoryUseCase(this._historyRepositoryImpl);

  Future<List<HistoryEvent>> call() async {
    return await _historyRepositoryImpl.getHistoryEvents();
  }
}
