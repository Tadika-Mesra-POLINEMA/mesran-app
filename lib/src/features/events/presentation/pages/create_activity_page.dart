import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_state.dart';
import 'package:mesran_app/src/features/events/presentation/widgets/create_activity_form.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class CreateActivityPage extends StatefulWidget {
  const CreateActivityPage({super.key});

  @override
  State<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateEventActivityBloc>(),
      child: Scaffold(
        appBar: CustomAppBar(
          leadingText: 'Aktivitas',
        ),
        backgroundColor: white,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: CreateActivityForm(),
        ),
        bottomNavigationBar:
            BlocBuilder<CreateEventActivityBloc, CreateEventActivityState>(
          buildWhen: (previous, current) =>
              previous.name != current.name ||
              previous.description != current.description ||
              previous.timeRange != current.timeRange,
          builder: (context, state) {
            return BottomAppBar(
              color: white,
              child: Button(
                onPressed: () {
                  final bloc = context.read<CreateEventActivityBloc>();
                  bloc.add(CreateActivity(
                    name: state.name,
                    description: state.description,
                    timeRange: state.timeRange,
                  ));
                  context.go('/events/activities');
                },
                child: Text(
                  'Simpan',
                  style: titleOneSemiBold.copyWith(color: white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
