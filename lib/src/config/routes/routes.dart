import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/routes/auth.route.dart';
import 'package:mesran_app/src/config/routes/chat.route.dart';
import 'package:mesran_app/src/config/routes/event.route.dart';
import 'package:mesran_app/src/config/routes/history.route.dart';
import 'package:mesran_app/src/config/routes/main.route.dart';
import 'package:mesran_app/src/config/routes/notification.route.dart';
import 'package:mesran_app/src/config/routes/profile.route.dart';

class Routes {
  final List<GoRoute> _routes = [];

  Routes() {
    _routes.addAll(mainRoutes);
    _routes.addAll(authRoutes);
    _routes.addAll(eventRoutes);
    _routes.addAll(historyRoutes);
    _routes.addAll(notificationRoutes);
    _routes.addAll(chatRoutes);
    _routes.addAll(profileRoutes);
  }

  List<GoRoute> getRoutes() {
    return _routes;
  }
}
