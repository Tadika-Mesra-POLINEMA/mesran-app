import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/shared/presentation/widgets/bottom_navigation.dart';

class ComingSoonChatPage extends StatelessWidget {
  const ComingSoonChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Pesan',
                style: headingTwoSemiBold,
              ),
              InkWell(
                onTap: () => context.push('/notifications'),
                child: bell.copyWith(color: neutralBase),
              ),
            ],
          ),
        ),
        backgroundColor: white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/coming-soon.png',
                  width: 230, height: 230),
              const Gap(24),
              Text('Coming Soooooon! 😆',
                  style: headingThreeSemiBold.copyWith(color: neutralBase)),
            ],
          ),
        ),
      ),
      backgroundColor: white,
      bottomNavigationBar: const BottomNavigation(
        path: BottomNavigationPath.message,
      ),
    );
  }
}
