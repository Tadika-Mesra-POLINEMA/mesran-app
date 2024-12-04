import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';

class InvitationCard extends StatelessWidget {
  final InvitationContent content;
  final Function onTap;

  const InvitationCard({super.key, required this.onTap, required this.content});

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

class InvitationContent extends StatelessWidget {
  final String name;
  final DateTime date;
  final String desc;

  const InvitationContent(
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
            style: titleTwo.copyWith(color: neutral40))
      ],
    );
  }
}
