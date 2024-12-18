import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/error.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/add_activity_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/add_activity_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/add_activity_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';

class AddActivityPage extends StatefulWidget {
  final String eventId;

  const AddActivityPage({super.key, required this.eventId});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddActivityBloc>(),
      child: _AddActivityView(eventId: widget.eventId),
    );
  }
}

class _AddActivityView extends StatelessWidget {
  final String eventId;

  const _AddActivityView({required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(leadingText: 'Aktivitas'),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _InputActivityName(),
            Gap(16),
            _InputActivityDescription(),
            Gap(16),
            _InputActivityTime(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: white,
        child: BlocListener<AddActivityBloc, AddActivityState>(
          listener: (context, state) {
            if (state is AddActivitySuccess) {
              context.go('/events/$eventId/activities');
            }

            if (state is AddActivityFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: error20,
                ),
              );
            }
          },
          child: Button(
            onPressed: () {
              context
                  .read<AddActivityBloc>()
                  .add(AddActivity(eventId: eventId));
            },
            child: Text(
              'Simpan',
              style: titleOneSemiBold.copyWith(color: white),
            ),
          ),
        ),
      ),
    );
  }
}

class _InputActivityName extends StatelessWidget {
  const _InputActivityName();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActivityBloc, AddActivityState>(
        buildWhen: (previous, current) => previous.title != current.title,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabel(label: 'Nama Aktivitas'),
              Gap(8),
              InputField(
                onChanged: (title) {
                  context.read<AddActivityBloc>().add(
                        TitleChanged(changedTitle: title),
                      );
                },
                hintText: 'Masukkan nama',
              ),
            ],
          );
        });
  }
}

class _InputActivityDescription extends StatelessWidget {
  const _InputActivityDescription();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActivityBloc, AddActivityState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabel(label: 'Deskripsi'),
            Gap(8),
            InputField(
              onChanged: (description) {
                context.read<AddActivityBloc>().add(
                      DescriptionChanged(changedDescription: description),
                    );
              },
              hintText: 'Tulis deskripsi',
            ),
          ],
        );
      },
    );
  }
}

class _InputActivityTime extends StatelessWidget {
  const _InputActivityTime();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActivityBloc, AddActivityState>(
      buildWhen: (previous, current) => previous.timeRange != current.timeRange,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabel(label: 'Waktu'),
            Gap(8),
            GestureDetector(
              onTap: () async {
                await CustomTimeRangePickerInput.show(
                  context,
                  onTimeChanged: (TimeRange timeRange) {
                    context.read<AddActivityBloc>().add(
                          TimeRangeChanged(
                            timeRange: timeRange,
                          ),
                        );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: neutral20),
                ),
                padding: const EdgeInsets.fromLTRB(16, 2, 4, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.timeRange.startTime.hour.toInt() != 0
                          ? '${state.timeRange.startTime.hour.toString()}:00 - ${state.timeRange.endTime.hour.toString()}:00'
                          : 'Pilih waktu',
                      style: titleOne.copyWith(color: neutral40),
                    ),
                    clock.copyWith(color: neutralBase),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
