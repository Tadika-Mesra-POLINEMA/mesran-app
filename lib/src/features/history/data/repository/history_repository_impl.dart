import 'package:mesran_app/src/features/history/data/data_source/history_data_source.dart';
import 'package:mesran_app/src/features/history/domain/entity/history_event.dart';
import 'package:mesran_app/src/features/history/domain/repository/abstract_history_repository.dart';

class HistoryRepositoryImpl extends AbstractHistoryRepository {
  final HistoryDataSource _historyDataSource;

  HistoryRepositoryImpl(this._historyDataSource);

  @override
  Future<List<HistoryEvent>> getHistoryEvents() async {
    return await _historyDataSource.getHistoryEvents();
  }
}
