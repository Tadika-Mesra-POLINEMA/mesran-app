import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/notification/domain/entity/notification.dart';

abstract class AbstractNotificationRepository {
  Future<Either<Null, List<Notification>>> getNotifications();
}
