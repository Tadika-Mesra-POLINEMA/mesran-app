import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        color: neutral20,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        strokeWidth: 1,
        dashPattern: const [12, 12],
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/advertising.png',
                        scale: 2,
                      ),
                      Text(
                        'Buat acara Anda disini!',
                        style: headingThreeSemiBold,
                      ),
                      Text(
                        'Rencanakan acara Anda dengan mudah disini. Isi form dan kelola semuanya dalam satu tempat!',
                        style: titleTwoRegular.copyWith(color: neutral40),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () => context.push('/events/create'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryBase),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: Text(
                        'Buat Acara',
                        style: titleOneSemiBold.copyWith(color: white),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
