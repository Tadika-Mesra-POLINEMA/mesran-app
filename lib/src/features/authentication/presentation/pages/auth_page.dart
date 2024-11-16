import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:mesran_app/src/features/authentication/presentation/widgets/auth_email_form.dart';
import 'package:mesran_app/src/features/authentication/presentation/widgets/auth_phone_form.dart';
import 'package:mesran_app/src/features/authentication/presentation/widgets/auth_type.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthType currentType = AuthType.email;

  void _setAuthType(AuthType type) {
    setState(() {
      currentType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
      ),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(32),
            Text(
              'Daftarkan akun Anda!',
              style: headingTwoSemiBold.copyWith(color: neutralBase),
            ),
            const Gap(8),
            Text(
              'Isi informasi yang diperlukan, dan Anda akan siap untuk memulai dalam hitungan menit!',
              style: titleTwo.copyWith(color: neutral40),
            ),
            const Gap(32),
            AuthTypeSection(
              type: currentType,
              toggleChangeLoginType: _setAuthType,
            ),
            const Gap(32),
            BlocProvider(
              create: (_) => getIt<AuthBloc>(),
              child: currentType == AuthType.email
                  ? const AuthEmailForm()
                  : const AuthPhoneForm(),
            ),
          ],
        ),
      ),
    );
  }
}
