import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/notification/data/data_source/notification_data_source.dart';
import 'package:mesran_app/src/features/notification/domain/entity/notification.dart';
import 'package:mesran_app/src/features/notification/domain/repository/abstract_notification_repository.dart';

class NotificationRepositoryImpl extends AbstractNotificationRepository {
  final NotificationDataSource _notificationDataSource;

  NotificationRepositoryImpl(this._notificationDataSource);

  @override
  Future<Either<Null, List<Notification>>> getNotifications() async {
    return await _notificationDataSource.getNotifications();
  }
}
