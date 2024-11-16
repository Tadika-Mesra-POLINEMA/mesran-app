import 'package:go_router/go_router.dart';
import 'package:mesran_app/pages/notifikasi_default_page.dart';
import 'package:mesran_app/pages/notifikasi_empty_page.dart';

List<GoRoute> notificationRoutes = [
  GoRoute(
      path: '/notifications/empty',
      builder: (context, state) => const NotifikasiEmptyPage()),
  GoRoute(
    path: '/notifications',
    builder: (context, state) => const NotifikasiDefaultPage(),
  ),
];
