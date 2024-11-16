import 'package:go_router/go_router.dart';
import 'package:mesran_app/pages/message/personal_message_page.dart';

List<GoRoute> chatRoutes = [
  GoRoute(
    path: '/chatroom/empty', 
    builder: (context, state) => const ChatPage()
  ),
  // GoRoute(
  //   path: '/chatroom',

  // )
];
