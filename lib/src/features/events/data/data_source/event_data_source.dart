import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/events/domain/entities/event.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_event_request.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/created_event_response.dart';
import 'package:mesran_app/src/features/events/domain/failures/create_event_failure.dart';

class EventDataSource {
  final DioClient _dioClient;

  EventDataSource(this._dioClient);

  Future<Either<CreateEventFailure, CreatedEventResponse>> createEvent(
      CreateEventRequest request) async {
    try {
      print(request.toJson());

      final response = await _dioClient.post(
        '/api/events',
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        final createdEventResponse =
            CreatedEventResponse.fromJson(response.data['data']);
        return Right(createdEventResponse);
      } else {
        return Left(
            CreateEventFailure(response.statusMessage ?? 'Unknown error'));
      }
    } on DioException {
      return Left(CreateEventFailure('Network error'));
    } catch (error) {
      return Left(CreateEventFailure('Unknown error'));
    }
  }

  Future<Either<Null, Event>> getEvent(String eventId) async {
    try {
      final response = await _dioClient.get('/api/events/$eventId');

      if (response.statusCode == 200) {
        final event = Event.fromJson(response.data['data']['event']);
        return Right(event);
      } else {
        return Left(null);
      }
    } on DioException {
      return Left(null);
    } catch (error) {
      return Left(null);
    }
  }
}
