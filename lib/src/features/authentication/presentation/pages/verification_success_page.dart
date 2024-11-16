import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:mesran_app/utils/themes.dart';

class VerificationSuccessPage extends StatelessWidget {
  const VerificationSuccessPage({super.key});

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
                    'Berhasil masuk ke akun Anda!',
                    style: headingThreeSemiBold.copyWith(color: neutralBase),
                    textAlign: TextAlign.center,
                  ),
                  Gap(8),
                  Text(
                    'Anda berhasil masuk ke akun. Nikmati semua fitur yang tersedia!',
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
