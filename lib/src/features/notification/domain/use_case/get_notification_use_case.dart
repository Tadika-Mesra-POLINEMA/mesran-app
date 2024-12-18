import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/notification/data/repository/notification_repository_impl.dart';
import 'package:mesran_app/src/features/notification/domain/entity/notification.dart';

class GetNotificationUseCase {
  final NotificationRepositoryImpl _notificationRepositoryImpl;

  GetNotificationUseCase(this._notificationRepositoryImpl);

  Future<Either<Null, List<Notification>>> call() async {
    return await _notificationRepositoryImpl.getNotifications();
  }
}
