import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/home/presentation/widgets/hero.dart';
import 'package:mesran_app/src/shared/presentation/widgets/bottom_navigation.dart';

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
        child: const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
