import 'package:flutter/material.dart';
import 'package:mesran_app/themes.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: neutral20,
            width: 1,
          ),
        ),
      ),
      child: BottomAppBar(
        color: white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home_outlined,
                  color: primaryBase,
                ),
                Text(
                  'Beranda ',
                  style: titleTwoMedium.copyWith(color: primaryBase),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.assignment_outlined,
                  color: neutral40,
                ),
                Text(
                  'Acara',
                  style: titleTwoMedium.copyWith(color: neutral40),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  color: neutral40,
                ),
                Text(
                  'Pesan',
                  style: titleTwoMedium.copyWith(color: neutral40),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_outline,
                  color: neutral40,
                ),
                Text(
                  'Profil',
                  style: titleTwoMedium.copyWith(color: neutral40),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
