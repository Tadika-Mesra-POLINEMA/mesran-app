import 'package:go_router/go_router.dart';
import 'package:mesran_app/pages/event/create_activities_page.dart';
import 'package:mesran_app/pages/event/create_event_page.dart';
import 'package:mesran_app/pages/event/event_activities_page.dart';
import 'package:mesran_app/pages/event/pakaian_tema_page.dart';
import 'package:mesran_app/pages/event/popup_berhasil_page.dart';

List<GoRoute> eventRoutes = [
  GoRoute(
    path: '/events/create',
    builder: (context, state) => const CreateEventPage()),
  GoRoute(
    path: '/events/activities',
    builder: (context, state) => const EventActivitiesPage(itemCount: 3),
  ),
  GoRoute(
    path: '/events/activities/create',
    builder: (context, state) => const CreateActivitiesPage()),
  GoRoute(
    path: '/events/dress',
    builder: (context, state) => PakaianTemaPage()
  ),
  GoRoute(
    path: '/events/create/success',
    builder: (context, state) => SuccessPage()
  ),
];
