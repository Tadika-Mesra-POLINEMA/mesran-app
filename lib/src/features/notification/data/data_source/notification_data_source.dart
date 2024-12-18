import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/notification/domain/entity/notification.dart';

class NotificationDataSource {
  final DioClient _dioClient;

  NotificationDataSource(this._dioClient);

  Future<Either<Null, List<Notification>>> getNotifications() async {
    try {
      final response = await _dioClient.get('/api/notifications');

      if (response.statusCode == 200) {
        final notification = response.data['data'] as List;

        if (notification.isEmpty) {
          return Right([]);
        } else {
          return Right(
            notification.map((e) => Notification.fromJson(e)).toList(),
          );
        }
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (error) {
      return Left(null);
    }
  }
}
