import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_event_request.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/created_event_response.dart';
import 'package:mesran_app/src/features/events/domain/failures/create_event_failure.dart';

class EventDataSource {
  final DioClient _dioClient;

  EventDataSource(this._dioClient);

  Future<Either<CreateEventFailure, CreatedEventResponse>> createEvent(
      CreateEventRequest request) async {
    try {
      final response = await _dioClient.client.post(
        '/api/events/create',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final createdEventResponse =
            CreatedEventResponse.fromJson(response.data);
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
}
