import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/home/domain/entity/event.dart';

class HomeDataSource {
  final DioClient _dioClient;

  HomeDataSource(this._dioClient);

  Future<Either<Null, List<EventHome>>> fetchEvents() async {
    try {
      final response = await _dioClient.get('/api/events/me');

      if (response.statusCode == 200) {
        return Right((response.data['data']['events'] as List)
            .map((e) => EventHome.fromJson(e))
            .toList());
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
