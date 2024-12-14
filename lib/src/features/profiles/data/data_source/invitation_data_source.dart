import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/events/domain/entities/event.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/user.dart';

class InvitationDataSource {
  final DioClient _dioClient;

  InvitationDataSource(this._dioClient);

  Future<Either<Null, Event>> fetchEvent(String id) async {
    try {
      final response = await _dioClient.get('/api/events/$id');

      if (response.statusCode == 200) {
        return Right(Event.fromJson(response.data['data']));
      } else {
        return Left(null);
      }
    } catch (error) {
      return Left(null);
    }
  }

  Future<Either<Null, List<Event>>> fetchEvents() async {
    try {
      final response = await _dioClient.get('/api/events/me');

      if (response.statusCode == 200) {
        return Right((response.data['data']['events'] as List)
        .map((e) => Event.fromJson(e))
        .toList());
      } else {
        return Left(null);
      }
    } catch (error) {
      return Left(null);
    }
  }
}
