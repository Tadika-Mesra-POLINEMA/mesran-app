import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/texts/light.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';

class BoardingPage extends StatelessWidget {
  const BoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/mesran-logo.png',
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Mesran',
                    style: displayTwo.copyWith(color: white),
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Welcome to Mesran!',
                    style: headingOneMedium.copyWith(color: white),
                  ),
                  Text(
                    'Selamat datang di Mesran! Kami senang Anda',
                    style: titleOneLight.copyWith(color: white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'bergabung dengan kami.',
                    style: titleOneLight.copyWith(color: white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 16),
                    ),
                    child: Text(
                      'Get Started',
                      style: titleOne.copyWith(color: neutralBase),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: primaryBase,
    );
  }
}
