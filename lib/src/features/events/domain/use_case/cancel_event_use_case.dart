import 'package:mesran_app/src/features/events/data/repository/event_repository_impl.dart';

class CancelEventUseCase {
  final EventRepositoryImpl _eventRepository;

  CancelEventUseCase(this._eventRepository);

  Future<bool> call(String eventId) async {
    return await _eventRepository.cancelEvent(eventId);
  }
}
