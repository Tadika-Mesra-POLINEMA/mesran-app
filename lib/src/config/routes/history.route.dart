import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/features/history/presentation/pages/history_page.dart';

List<GoRoute> historyRoutes = [
  GoRoute(
    path: '/history',
    builder: (context, state) => HistoryPage(),
  )
];
