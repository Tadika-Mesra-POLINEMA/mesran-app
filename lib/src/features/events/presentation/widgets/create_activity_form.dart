import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';

class CreateActivityForm extends StatefulWidget {
  const CreateActivityForm({super.key});

  @override
  State<CreateActivityForm> createState() => CreateActivityFormState();
}

class CreateActivityFormState extends State<CreateActivityForm> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEventActivityBloc, CreateEventActivityState>(
      listener: (_, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _InputActivityName(),
            Gap(16),
            _InputActivityDescription(),
            Gap(16),
            _InputActivityTime(),
          ],
        );
      },
    );
  }
}

class _InputActivityName extends StatelessWidget {
  const _InputActivityName();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventActivityBloc, CreateEventActivityState>(
        buildWhen: (previous, current) =>
            previous.name != current.name ||
            previous.isNameValid != current.isNameValid ||
            previous.nameErrorMessage != current.nameErrorMessage,
        builder: (context, state) {
          final isNameError = !state.isNameValid &&
              (state.nameErrorMessage?.isNotEmpty ?? false);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabel(label: 'Nama Aktivitas'),
              Gap(8),
              InputField(
                onChanged: (name) {
                  context.read<CreateEventActivityBloc>().add(
                        ActivityNameChanged(name: name),
                      );
                },
                hintText: 'Masukkan nama',
                isError: isNameError,
              ),
              if (isNameError)
                Text(
                  state.nameErrorMessage ?? 'Nama tidak boleh kosong',
                  style: titleTwoMedium.copyWith(color: primaryBase),
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
    return BlocBuilder<CreateEventActivityBloc, CreateEventActivityState>(
      buildWhen: (previous, current) =>
          previous.description != current.description ||
          previous.isDescriptionValid != current.isDescriptionValid ||
          previous.descriptionErrorMessage != current.descriptionErrorMessage,
      builder: (context, state) {
        final isDescriptionError = !state.isDescriptionValid &&
            (state.descriptionErrorMessage?.isNotEmpty ?? false);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabel(label: 'Deskripsi'),
            Gap(8),
            InputField(
              onChanged: (description) {
                context.read<CreateEventActivityBloc>().add(
                      ActivityDescriptionChanged(description: description),
                    );
              },
              hintText: 'Tulis deskripsi',
              isError: isDescriptionError,
            ),
            if (isDescriptionError)
              Text(
                state.descriptionErrorMessage ?? 'Deskripsi tidak boleh kosong',
                style: titleTwoMedium.copyWith(color: primaryBase),
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
    return BlocBuilder<CreateEventActivityBloc, CreateEventActivityState>(
      buildWhen: (previous, current) =>
          previous.timeRange != current.timeRange ||
          previous.isTimeRangeValid != current.isTimeRangeValid ||
          previous.timeRangeErrorMessage != current.timeRangeErrorMessage,
      builder: (context, state) {
        final isTimeRangeError = !state.isTimeRangeValid &&
            (state.timeRangeErrorMessage?.isNotEmpty ?? false);

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
                    final startTime = timeRange.startTime;
                    final endTime = timeRange.endTime;

                    context.read<CreateEventActivityBloc>().add(
                          ActivityTimeChanged(
                            activityStart: startTime,
                            activityEnd: endTime,
                          ),
                        );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isTimeRangeError ? primaryBase : neutral20),
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
            if (isTimeRangeError)
              Text(
                state.timeRangeErrorMessage ?? 'Waktu tidak valid',
                style: titleTwoMedium.copyWith(color: primaryBase),
              ),
          ],
        );
      },
    );
  }
}
