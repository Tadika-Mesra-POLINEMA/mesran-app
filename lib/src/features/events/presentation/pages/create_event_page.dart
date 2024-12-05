import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_event.dart';
import 'package:mesran_app/src/features/events/presentation/widgets/create_event_form.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateEventBloc>(),
      child: Scaffold(
        appBar: CustomAppBar(
          leadingText: 'Buat Acara',
        ),
        body: SingleChildScrollView(
          child: IntrinsicHeight(
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: CreateEventForm(),
            ),
          ),
        ),
        backgroundColor: white,
        bottomNavigationBar: BottomCreateEventPage(),
      ),
    );
  }
}

class BottomCreateEventPage extends StatelessWidget {
  const BottomCreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: white,
      child: Column(
        children: [
          Button(
              onPressed: () {
                context.read<CreateEventBloc>().add(SubmitEvent());
              },
              type: ButtonType.primary,
              child: Text(
                'Buat',
                style: titleOneSemiBold.copyWith(color: white),
              ))
        ],
      ),
    );
  }
}
