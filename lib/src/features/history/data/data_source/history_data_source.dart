import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/history/domain/entity/history_event.dart';

class HistoryDataSource {
  final DioClient _dioClient;

  HistoryDataSource(this._dioClient);

  Future<List<HistoryEvent>> getHistoryEvents() async {
    try {
      final response = await _dioClient.get('/api/events/history');

      return (response.data['data'] as List)
          .map((e) => HistoryEvent.fromJson(e))
          .toList();
    } catch (error) {
      return [];
    }
  }
}
