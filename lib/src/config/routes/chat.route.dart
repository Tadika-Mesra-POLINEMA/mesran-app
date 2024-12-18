import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/features/chats/presentation/pages/coming_soon_chat_page.dart';

List<GoRoute> chatRoutes = [
  GoRoute(
      path: '/chats',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const ComingSoonChatPage())),
];
