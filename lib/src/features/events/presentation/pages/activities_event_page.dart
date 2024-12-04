import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:mesran_app/utils/themes.dart';

class ActivitiesEventPage extends StatelessWidget {
  const ActivitiesEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotFoundEventActivities();
  }
}

class NotFoundEventActivities extends StatelessWidget {
  const NotFoundEventActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingText: 'Aktivitas',
      ),
      backgroundColor: white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/finding.png'),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  Text(
                    'Tidak ada aktivitas tambahan',
                    style: headingThreeSemiBold.copyWith(color: neutralBase),
                    textAlign: TextAlign.center,
                  ),
                  Gap(8),
                  Text(
                    'Anda belum memiliki aktivitas tambahan disini. Segera buat dan buat acara Anda makin luar biasa!',
                    style: titleTwo.copyWith(color: neutral40),
                    textAlign: TextAlign.center,
                  ),
                  Gap(24),
                  SizedBox(
                    width: 200,
                    child: Button(
                        onPressed: () =>
                            context.push('/events/activities/create'),
                        child: Text(
                          'Buat Aktivitas',
                          style: titleOneSemiBold.copyWith(color: white),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
