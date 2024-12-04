import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/data/repository/event_repository_impl.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_event_request.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/created_event_response.dart';
import 'package:mesran_app/src/features/events/domain/failures/create_event_failure.dart';

class CreateEventUseCase {
  final EventRepositoryImpl _eventRepositoryImpl;

  CreateEventUseCase(this._eventRepositoryImpl);

  Future<Either<CreateEventFailure, CreatedEventResponse>> call(
      CreateEventRequest event) async {
    return await _eventRepositoryImpl.createEvent(event);
  }
}
