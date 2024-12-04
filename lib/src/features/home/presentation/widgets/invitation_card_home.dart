import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class InvitationCardHome extends StatelessWidget {
  final InvitationContentHome content;
  final Function onTap;

  const InvitationCardHome(
      {super.key, required this.onTap, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: neutral20),
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(12),
        child: content,
      ),
    );
  }
}

class InvitationContentHome extends StatelessWidget {
  final String name;
  final DateTime date;
  final String desc;

  const InvitationContentHome(
      {super.key, required this.name, required this.date, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Happy birthday', style: titleOne.copyWith(color: neutralBase)),
        Gap(4),
        Text('11 Agusturs cak', style: titleTwo.copyWith(color: neutral40)),
        Gap(4),
        Text('ulang tahu l kihhhhhhh',
            style: titleTwo.copyWith(color: neutral40)),
        Gap(16),
        Button(
            onPressed: () {},
            type: ButtonType.secondary,
            child: Text('Lihat Acara',
                style: titleOneSemiBold.copyWith(color: neutralBase)))
      ],
    );
  }
}
