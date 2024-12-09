import 'package:go_router/go_router.dart';
import 'package:mesran_app/pages/event/popup_berhasil_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/activities_event_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/create_activity_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/create_event_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/edit_event_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/event_detail_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/event_dresscode_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/verify_face_page.dart';

List<GoRoute> eventRoutes = [
  GoRoute(
    path: '/events/create',
    builder: (context, state) => const CreateEventPage()),
  GoRoute(
    path: '/events/activities',
    builder: (context, state) => const ActivitiesEventPage(),
  ),
  GoRoute(
    path: '/events/activities/create',
    builder: (context, state) => const CreateActivityPage()),
  GoRoute(
    path: '/events/dresscode/create',
    builder: (context, state) => EventDresscodePage()
  ),
  GoRoute(
    path: '/events/create/success',
    builder: (context, state) => SuccessPage()
  ),
  GoRoute(
    path: '/events/:eventId',
    builder: (context, state) {
      final eventId = state.pathParameters['eventId'];
      return EventDetailPage(eventId: eventId!);
    }
  ),
  GoRoute(
    path: '/events/:eventId/edit',
    builder: (context, state) {
      final eventId = state.pathParameters['eventId'];
      return EditEventPage(eventId: eventId!,);
    }
  ),
  GoRoute(
    path: '/events/:eventId/participants/validate',
    builder: (context, state) {
      final eventId = state.pathParameters['eventId'];
      return VerifyFacePage();
    }
  )
];
