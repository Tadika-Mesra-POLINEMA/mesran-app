import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/data/repository/event_repository_impl.dart';
import 'package:mesran_app/src/features/events/domain/entities/event.dart';

class GetEventByIdUseCase {
  final EventRepositoryImpl _eventRepository;

  GetEventByIdUseCase(this._eventRepository);

  Future<Either<Null, Event>> call(String eventId) async {
    return await _eventRepository.getEvent(eventId);
  }
}
