import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class CreateEventSuccessPage extends StatelessWidget {
  final String eventId;

  const CreateEventSuccessPage({super.key, required this.eventId});

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
              Image.asset(
                'assets/images/graduation.png',
                width: 230,
              ),
              Gap(24),
              Column(
                children: [
                  Text(
                    'Anda sudah membuat acara terbaru!',
                    style: headingThreeSemiBold.copyWith(color: neutralBase),
                    textAlign: TextAlign.center,
                  ),
                  Gap(8),
                  Text(
                    'Acara terbaru Anda sudah berhasil dibuat!\nBagikan dan nikmati acaranya.',
                    style: titleTwo.copyWith(color: neutral40),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Button(
                      onPressed: () => context.push('/events/$eventId'),
                      child: Text('Lihat Acara Saya',
                          style: titleOneSemiBold.copyWith(color: white))),
                  Gap(8),
                  Button(
                      onPressed: () => context.go('/home'),
                      type: ButtonType.secondary,
                      child: Text('Kembali ke Beranda',
                          style:
                              titleOneSemiBold.copyWith(color: neutralBase))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
