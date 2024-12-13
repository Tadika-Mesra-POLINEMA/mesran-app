import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/domain/entities/event.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_event_request.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/created_event_response.dart';
import 'package:mesran_app/src/features/events/domain/failures/create_event_failure.dart';

abstract class AbstractEventRepository {
  Future<Either<CreateEventFailure, CreatedEventResponse>> createEvent(
      CreateEventRequest request);

  Future<Either<Null, Event>> getEvent(String eventId);

  Future<bool> cancelEvent(String eventId);
}
