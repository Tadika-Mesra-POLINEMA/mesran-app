import 'package:go_router/go_router.dart';
// import 'package:mesran_app/pages/profile/account_profile_page.dart';
import 'package:mesran_app/src/features/profiles/presentation/pages/create_profile_akun.dart';
import 'package:mesran_app/src/features/profiles/presentation/pages/create_profile_pribadi.dart';
// import 'package:mesran_app/src/features/profiles/presentation/pages/riwayat_page.dart';
import 'package:mesran_app/src/features/profiles/presentation/pages/account_profile_page.dart';
import 'package:mesran_app/src/features/profiles/presentation/pages/history_page.dart';
import 'package:mesran_app/src/features/profiles/presentation/pages/invitation_page.dart';

List<GoRoute> profileRoutes = [
  GoRoute(
      path: '/account/profile',
      builder: (context, state) => const AccountProfilePage()),
  GoRoute(
      path: '/account/update',
      builder: (context, state) => const CreateProfileAkun()),
  GoRoute(
      path: '/account/profile/update',
      builder: (context, state) => const CreateProfilePribadi()),
  GoRoute(
      path: '/account/history',
      builder: (context, state) => const HistoryPage()),
  GoRoute(
      path: '/account/:id/invitation',
      builder: (context, state) {
        final String eventId = state.pathParameters['id']!;
        print(eventId);
        return InvitationPage(eventId: eventId);
      }),
];
