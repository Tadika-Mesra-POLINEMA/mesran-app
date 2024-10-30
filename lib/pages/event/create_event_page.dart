import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/event/create_event_form.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/utils/themes.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: UndoButton(
            onPressed: () => context.pop(),
            label: 'Buat Acara',
          ),
        ),
        leadingWidth: double.infinity,
        backgroundColor: white,
        automaticallyImplyLeading: false,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CreateEventForm(),
      ),
      backgroundColor: white,
    );
  }
}
