import 'dart:async';

class NotificationRepository {
  // Simulasi data notifikasi (untuk pengembangan awal)
  Future<List<String>> fetchNotifications() async {
    // Mengembalikan daftar kosong untuk simulasi halaman kosong
    return Future.delayed(const Duration(seconds: 1), () => []);
  }
}
