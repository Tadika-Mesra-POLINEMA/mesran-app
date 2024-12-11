import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/utils/themes.dart';

class NotifikasiDefaultPage extends StatelessWidget {
  const NotifikasiDefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
        leadingText: 'Notifikasi',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(width: double.infinity),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/orang.jpg',
                    width: 48,
                    height: 48,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Messi membatalkan acara “Ulang Tahun”nya. Sampai jumpa di acara lainnya!',
                          style: titleOneMedium.copyWith(color: neutralBase),
                        ),
                        Gap(6),
                        Text(
                          '02:12',
                          style: titleTwoMedium.copyWith(color: neutral40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/orang.jpg',
                    width: 48,
                    height: 48,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sherina akan menghadiri acara “Ulang Tahun” Anda! Lihat detailnya dan bersiaplah untuk menikmatinya!',
                          style: titleOneMedium.copyWith(color: neutralBase),
                        ),
                        Gap(6),
                        Text(
                          '02:12',
                          style: titleTwoMedium.copyWith(color: neutral40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/orang.jpg',
                    width: 48,
                    height: 48,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Messi membatalkan acara “Ulang Tahun”nya. Sampai jumpa di acara lainnya!',
                          style: titleOneMedium.copyWith(color: neutralBase),
                        ),
                        Gap(6),
                        Text(
                          '02:12',
                          style: titleTwoMedium.copyWith(color: neutral40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
