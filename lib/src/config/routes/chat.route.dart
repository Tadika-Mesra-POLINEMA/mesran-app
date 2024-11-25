import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/features/chats/ada_message_page.dart';
import 'package:mesran_app/src/features/chats/chat_detail_page.dart';
import 'package:mesran_app/src/features/chats/chat_detail_grup_page.dart';
import 'package:mesran_app/src/features/chats/message_page.dart';
import 'package:mesran_app/src/features/chats/profile_page.dart';
import 'package:mesran_app/src/features/chats/profile_group_page.dart';

List<GoRoute> chatRoutes = [
  GoRoute(
      path: '/chatroom/empty', builder: (context, state) => const ChatPage()),
  GoRoute(
      path: '/chatroom/avalaible',
      builder: (context, state) => const AdaChatPage()),
  GoRoute(
      path: '/detailMessage', builder: (context, state) => ChatDetailPage()),
  GoRoute(
      path: '/detailMessageGroup',
      builder: (context, state) => GroupChatDetailPage()),
  GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
  GoRoute(
      path: '/profileGroup', builder: (context, state) => ProfileGroupPage()),
  // GoRoute(
  //   path: '/chatroom',

  // )
];
