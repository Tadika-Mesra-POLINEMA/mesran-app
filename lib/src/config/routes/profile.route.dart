import 'package:go_router/go_router.dart';
import 'package:mesran_app/pages/profile/account_profile_page.dart';
import 'package:mesran_app/pages/profile/create_profile_akun.dart';
import 'package:mesran_app/pages/profile/create_profile_pribadi.dart';
import 'package:mesran_app/pages/riwayat/riwayat_page.dart';

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
      builder: (context, state) => const RiwayatPage()),
];
