import 'package:flutter/material.dart';
import 'package:mesran_app/src/features/notification/presentation/notification_view_model.dart';
import 'package:mesran_app/src/features/notification/domain/notification_service.dart';
import 'package:mesran_app/src/features/notification/data/notification_repository.dart';
import 'package:mesran_app/src/features/notification/presentation/notifikasi_empty_page.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  late final NotificationViewModel _viewModel;
  bool _isLoading = true;
  bool _hasNotifications = false;

  @override
  void initState() {
    super.initState();
    final repository = NotificationRepository();
    final service = NotificationService(repository);
    _viewModel = NotificationViewModel(service);

    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final hasNotifications = await _viewModel.hasNotifications();
    setState(() {
      _isLoading = false;
      _hasNotifications = hasNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return _hasNotifications
        ? const Center(
            child: Text("Daftar Notifikasi")) // Tambahkan UI untuk notifikasi
        : const NotifikasiEmptyPage();
  }
}
