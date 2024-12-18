import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';

class NotifikasiEmptyPage extends StatelessWidget {
  const NotifikasiEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingText: 'Notifikasi',
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(20),
                Image.asset(
                  'assets/images/no-email.png',
                  scale: 2,
                ),
                const Gap(20),
                Text(
                  'Tidak ada notifikasi',
                  style: headingThreeSemiBold,
                ),
                const Gap(6),
                Text(
                  'Saat ini, tidak ada notifikasi baru. Semua informasi penting akan muncul di sini ketika tersedia.',
                  style: titleTwo.copyWith(color: neutral40),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
      backgroundColor: white,
    );
  }
}
