import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/home/presentation/widgets/hero.dart';
import 'package:mesran_app/src/features/home/presentation/widgets/invitation_card_home.dart';
import 'package:mesran_app/src/shared/presentation/widgets/bottom_navigation.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          title: AppBarHomePage()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Acara akan datang',
                  style: headingThreeMedium.copyWith(color: neutralBase),
                ),
                Gap(12),
                InvitationCardHome(
                  onTap: () {
                    context.push('/account/invitation');
                  },
                  content: InvitationContentHome(
                      name: 'happy birthday',
                      date: DateTime.now(),
                      desc: 'rabi lek'),
                ),
              ]),
              Gap(16),
              Center(child: HeroSection()),
            ],
          ),
        ),
      ),
      backgroundColor: white,
      bottomNavigationBar: BottomNavigation(
        path: BottomNavigationPath.home,
      ),
    );
  }
}

class AppBarHomePage extends StatelessWidget {
  const AppBarHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Halo, Selamat Datang!',
              style: headingTwoSemiBold,
            ),
            InkWell(
                onTap: () => context.push('/notifications'),
                child: bell.copyWith(color: neutralBase))
          ]),
    );
  }
}
