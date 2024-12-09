import 'package:flutter/material.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/events/presentation/widgets/edit_event_form.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class EditEventPage extends StatelessWidget {
  final String eventId;

  const EditEventPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingText: 'Edit Acara',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: EditEventForm(),
      ),
      bottomNavigationBar: BottomAppBar(
          color: white,
          child: Button(
              onPressed: () {},
              child: Text(
                'Perbarui',
                style: titleOneSemiBold.copyWith(color: white),
              ))),
      backgroundColor: white,
    );
  }
}
