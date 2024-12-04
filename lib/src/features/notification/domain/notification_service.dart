import 'package:mesran_app/src/features/notification/data/notification_repository.dart';

class NotificationService {
  final NotificationRepository _repository;

  NotificationService(this._repository);

  // Mengambil notifikasi
  Future<List<String>> getNotifications() async {
    return await _repository.fetchNotifications();
  }
}
