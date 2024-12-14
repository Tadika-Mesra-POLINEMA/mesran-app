import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/domain/entities/event.dart';

abstract class AbstractInvitationRepository {
  Future<Either<Null, List<Event>>> getEvents();
  Future<Either<Null, Event>> getEvent(String id);
}
