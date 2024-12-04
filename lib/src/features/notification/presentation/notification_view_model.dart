import 'package:mesran_app/src/features/notification/domain/notification_service.dart';

class NotificationViewModel {
  final NotificationService _service;

  NotificationViewModel(this._service);

  Future<bool> hasNotifications() async {
    final notifications = await _service.getNotifications();
    return notifications.isNotEmpty;
  }
}
