import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class InvitationCardHome extends StatelessWidget {
  final InvitationContentHome content;

  const InvitationCardHome({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: neutral20),
          borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(12),
      child: content,
    );
  }
}

class InvitationContentHome extends StatelessWidget {
  final String name;
  final DateTime date;
  final String desc;
  final Function onTap;

  const InvitationContentHome(
      {super.key,
      required this.name,
      required this.onTap,
      required this.date,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: titleOne.copyWith(color: neutralBase)),
        Gap(4),
        Text(DateFormat.yMMMMd('id').format(date),
            style: titleTwo.copyWith(color: neutral40)),
        Gap(4),
        Text(
          desc,
          style: titleTwo.copyWith(color: neutral40),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
        Button(
            onPressed: () => onTap(),
            type: ButtonType.secondary,
            child: Text('Lihat Acara',
                style: titleOneSemiBold.copyWith(color: neutralBase)))
      ],
    );
  }
}
