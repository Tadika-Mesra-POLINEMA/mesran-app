import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/features/notification/presentation/pages/notification_page.dart';

List<GoRoute> notificationRoutes = [
  GoRoute(
    path: '/notifications',
    builder: (context, state) => NotificationPage(),
  ),
];
