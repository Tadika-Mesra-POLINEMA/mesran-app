import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/common/button.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/utils/buttons.dart';
import 'package:mesran_app/utils/themes.dart';

class FaceRecognitionPage extends StatelessWidget {
  const FaceRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UndoButton(
                  onPressed: () => context.pop(),
                ),
                Text(
                  'Cek Wajah',
                  style: headingTwoSemiBold.copyWith(color: neutralBase),
                ),
                const SizedBox(
                  width: 24,
                  height: 24,
                )
              ],
            )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 312,
                width: 312,
                decoration: BoxDecoration(
                  color: neutral10,
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
              const Gap(24),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ambil gambar wajah Anda!',
                    style: headingThreeSemiBold.copyWith(color: neutralBase),
                  ),
                  const Gap(8),
                  Text(
                    'Kami akan mengambil wajah Anda sekarang agar nanti bisa digunakan untuk masuk ke acara saat hadir!',
                    style: titleTwoRegular.copyWith(color: neutral40),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Spacer(flex: 12),
              // const Gap(124),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: warning10,
                      border: Border.all(color: warning30),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Posisikan wajah Anda dengan benar',
                      style: titleOneMedium.copyWith(color: neutralBase),
                    ),
                  ),
                ],
              ),
              const Gap(32),
              Button(
                onPressed: () {},
                style: buttonPrimaryBase,
                child: Text('Absen',
                    style: titleOneSemiBold.copyWith(color: white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
