import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/profiles/presentation/widgets/invitation_card.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingText: 'Undanganku',
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          InvitationCard(
            onTap: () {
              context.push('/account/invitation');
            },
            content: InvitationContent(
                name: 'happy birthday', date: DateTime.now(), desc: 'rabi lek'),
          ),
        ]),
      ),
      backgroundColor: white,
    );
  }
}
