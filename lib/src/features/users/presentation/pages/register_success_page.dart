import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 34),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset('assets/images/login-success.png'),
              Gap(24),
              Column(
                children: [
                  Text(
                    'Anda berhasil mendaftar!',
                    style: headingThreeSemiBold.copyWith(color: neutralBase),
                    textAlign: TextAlign.center,
                  ),
                  Gap(8),
                  Text(
                    'Pendaftaran Anda berhasil! Sekarang, Anda siap untuk mulai menggunakan semua fitur yang tersedia.',
                    style: titleTwo.copyWith(color: neutral40),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Spacer(),
              Button(
                  onPressed: () => context.go('/home'),
                  child: Text('Lanjut ke Beranda',
                      style: titleOneSemiBold.copyWith(color: white)))
            ],
          ),
        ),
      ),
    );
  }
}
