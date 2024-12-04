import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/data/data_source/event_data_source.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_event_request.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/created_event_response.dart';
import 'package:mesran_app/src/features/events/domain/failures/create_event_failure.dart';
import 'package:mesran_app/src/features/events/domain/repository/abstract_event_repository.dart';

class EventRepositoryImpl extends AbstractEventRepository {
  final EventDataSource _eventDataSource;

  EventRepositoryImpl(this._eventDataSource);

  @override
  Future<Either<CreateEventFailure, CreatedEventResponse>> createEvent(
      CreateEventRequest request) async {
    try {
      final response = await _eventDataSource.createEvent(request);

      return response.fold(
        (error) => Left(error),
        (successResponse) => Right(successResponse),
      );
    } catch (error) {
      return Left(CreateEventFailure('Unknown error'));
    }
  }
}
