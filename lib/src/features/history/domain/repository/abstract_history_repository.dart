import 'package:mesran_app/src/features/history/domain/entity/history_event.dart';

abstract class AbstractHistoryRepository {
  Future<List<HistoryEvent>> getHistoryEvents();
}
