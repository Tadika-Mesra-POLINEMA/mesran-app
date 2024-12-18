import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/features/events/presentation/pages/activities_detail_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/activities_event_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/add_activity_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/create_activity_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/create_event_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/create_event_success_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/edit_event_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/event_detail_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/event_dresscode_page.dart';
import 'package:mesran_app/src/features/events/presentation/pages/event_participant_page.dart';
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
      builder: (context, state) => EventDresscodePage()),
  GoRoute(
      path: '/events/:eventId/created',
      builder: (context, state) {
        final eventId = state.pathParameters['eventId'];
        return CreateEventSuccessPage(eventId: eventId!);
      }),
  GoRoute(
      path: '/events/:eventId',
      builder: (context, state) {
        final eventId = state.pathParameters['eventId'];
        return EventDetailPage(eventId: eventId!);
      }),
  GoRoute(
      path: '/events/:eventId/edit',
      builder: (context, state) {
        final eventId = state.pathParameters['eventId'];
        return EditEventPage(
          eventId: eventId!,
        );
      }),
  GoRoute(
      path: '/events/:eventId/activities',
      builder: (context, state) {
        final EventExtra extra = state.extra as EventExtra;
        final eventId = state.pathParameters['eventId'];
        return ActivitiesDetailPage(
          eventId: eventId!,
          isOwner: extra.isOwner,
        );
      }),
  GoRoute(
      path: '/events/:eventId/activities/add',
      builder: (context, state) {
        final eventId = state.pathParameters['eventId'];
        return AddActivityPage(
          eventId: eventId!,
        );
      }),
  GoRoute(
      path: '/events/:eventId/participants',
      builder: (context, state) {
        final EventExtra extra = state.extra as EventExtra;
        final String? eventId = state.pathParameters['eventId'];
        return EventParticipantPage(
          eventId: eventId!,
          isEventStart: extra.isEventStart,
          isOwner: extra.isOwner,
        );
      }),
  GoRoute(
      path: '/events/:eventId/participants/validate',
      builder: (context, state) {
        final eventId = state.pathParameters['eventId'];
        return VerifyFacePage();
      }),
];

class EventExtra {
  final bool isEventStart;
  final bool isOwner;

  EventExtra({required this.isEventStart, required this.isOwner});
}
