import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/event/create_event_form.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/utils/themes.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: UndoButton(
            onPressed: () => context.pop(),
            label: 'Notifikasi',
          ),
        ),
        leadingWidth: double.infinity,
        backgroundColor: white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SvgPicture.asset(
                //   '/assets/images/no-email.svg',
                //   width: 230,
                //   height: 230,
                // ),
                Text(
                  'Tidak ada notifikasi',
                  style: headingThreeSemiBold,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Saat ini, tidak ada notifikasi baru. Semua informasi penting akan muncul di sini ketika tersedia.',
                  style: titleTwo.copyWith(color: neutral40),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
      ),
      backgroundColor: white,
    );
  }
}
