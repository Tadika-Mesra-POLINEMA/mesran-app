import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/utils/themes.dart';

class NotFoundEventActivities extends StatelessWidget {
  const NotFoundEventActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
                const SizedBox(height: 8),
                Text(
                  'Anda belum memiliki aktivitas tambahan disini. Segera buat dan buat acara Anda makin luar biasa!',
                  style: titleTwo.copyWith(color: neutral40),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () => context.push('/events/create'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryBase),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: Text(
                        'Buat Aktivitas',
                        style: titleOne.copyWith(color: white),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
