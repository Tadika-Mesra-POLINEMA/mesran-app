import 'package:go_router/go_router.dart';
import 'package:mesran_app/models/user.dart';
import 'package:mesran_app/pages/auth/login_page.dart';
import 'package:mesran_app/pages/auth/authentication_success_page.dart';
import 'package:mesran_app/pages/auth/register_page.dart';
import 'package:mesran_app/pages/auth/verify_otp_page.dart';
import 'package:mesran_app/pages/event/create_activities_page.dart';
import 'package:mesran_app/pages/event/create_event_page.dart';
import 'package:mesran_app/pages/event/event_activities_page.dart';
import 'package:mesran_app/pages/home_page.dart';
import 'package:mesran_app/pages/message/chat_detail_grup_page.dart';
import 'package:mesran_app/pages/message/profile_group_page.dart';
import 'package:mesran_app/pages/message/profile_page.dart';
import 'package:mesran_app/pages/notifikasi_default_page.dart';
import 'package:mesran_app/pages/notifikasi_empty_page.dart';
import 'package:mesran_app/pages/onboarding_page.dart';
import 'package:mesran_app/pages/riwayat/detail_undangan_page.dart';
import 'package:mesran_app/pages/riwayat/edit_acara_page.dart';
import 'package:mesran_app/pages/riwayat/face_recognition_page.dart';
import 'package:mesran_app/pages/riwayat/riwayat_page.dart';
import 'package:mesran_app/pages/splash_screen.dart';
import 'package:mesran_app/pages/message/personal_message_page.dart';
import 'package:mesran_app/pages/message/chat_detail_page.dart';
import 'package:mesran_app/pages/message/ada_chat_page.dart';

final List<GoRoute> routes = [
  GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
  GoRoute(
    path: '/first-time',
    builder: (context, state) => const OnboardingPage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  ),

  // Authentication Routes
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(path: '/register', builder: (context, state) => const RegisterPage()),
  GoRoute(
      path: '/verify-otp', builder: (context, state) => const VerifyOtpPage()),
  GoRoute(
      path: '/auth-success',
      builder: (context, state) {
        final AuthenticationSuccess authSuccess =
            state.extra! as AuthenticationSuccess;
        return AuthenticationSuccessPage(title: authSuccess.title);
      }),

  // Events
  GoRoute(
      path: '/events/create',
      builder: (context, state) => const CreateEventPage()),
  GoRoute(
      path: '/events/activities',
      builder: (context, state) => const EventActivitiesPage(
            itemCount: 3,
          )),
  GoRoute(
      path: '/events/activities/create',
      builder: (context, state) => const CreateActivitiesPage()),

  // Notifikasi Kosong
  GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotifikasiEmptyPage()),

  // Notifikasi Terisi
  GoRoute(
      path: '/notificationsDefault',
      builder: (context, state) => const NotifikasiDefaultPage()),

  // Chat Pages
  GoRoute(path: '/message', builder: (context, state) => const ChatPage()),
  GoRoute(
      path: '/adamessage', builder: (context, state) => const AdaChatPage()),

  // Detail Message Pribadi
  GoRoute(
      path: '/detailMessage', builder: (context, state) => ChatDetailPage()),

  // Detail Message Group
  GoRoute(
      path: '/detailMessageGroup',
      builder: (context, state) => GroupChatDetailPage()),

  // Profile Page
  GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
  // Profile Group Page
  GoRoute(
      path: '/profileGroup',
      builder: (context, state) => const ProfileGroupPage()),

  // Riwayat Page
  GoRoute(path: '/riwayat', builder: (context, state) => const RiwayatPage()),

  // Detail Undangan Page
  GoRoute(
      path: '/detailUndangan',
      builder: (context, state) => const DetailUndanganPage()),

  // Face Recognation
  GoRoute(
      path: '/faceRecognation',
      builder: (context, state) => const FaceRecognitionPage()),

  // Edit Acara
  GoRoute(
      path: '/editAcara', builder: (context, state) => const EditAcaraPage()),
];
