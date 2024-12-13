import 'package:flutter/material.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';

class EventParticipantPage extends StatefulWidget {
  const EventParticipantPage({super.key});

  @override
  State<EventParticipantPage> createState() => _EventParticipantPageState();
}

class _EventParticipantPageState extends State<EventParticipantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingText: 'Tamu',
      ),
      body: Text('data'),
    );
  }
}
