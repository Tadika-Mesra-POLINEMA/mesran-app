import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_calendar_input.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_input.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';

class CreateEventForm extends StatefulWidget {
  const CreateEventForm({super.key});

  @override
  State<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<CreateEventBloc>().add(LoadEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEventBloc, CreateEventState>(
        listener: (context, state) {
      if (state is CreateEventSuccess) {
        context.go('/home');
      }

      if (state is CreateEventFailed || state is CreateEventFormNotValid) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: primaryBase,
            ),
          );
      }
    }, builder: (context, state) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InputEventName(),
          Gap(16),
          _InputEventDescription(),
          Gap(16),
          _InputEventLocation(),
          Gap(16),
          _InputEventDate(),
          Gap(16),
          _InputEventStart(),
          Gap(16),
          _InputDressActivities(),
        ],
      );
    });
  }
}

class _InputEventName extends StatelessWidget {
  const _InputEventName();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      buildWhen: (previous, current) =>
          previous.name != current.name ||
          previous.isNameValid != current.isNameValid,
      builder: (context, state) {
        final isEventNameError = state.name.isNotEmpty && !state.isNameValid;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabel(label: 'Nama Acara'),
            Gap(8),
            InputField(
              onChanged: (name) {
                context.read<CreateEventBloc>().add(NameChanged(name));
              },
              hintText: 'Masukkan nama',
              isError: isEventNameError,
              initialValue: state.name,
            ),
            if (isEventNameError)
              Column(
                children: [
                  Gap(4),
                  Text(
                    'Nama acara harus diisi',
                    style: titleTwoMedium.copyWith(color: primaryBase),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _InputEventDescription extends StatelessWidget {
  const _InputEventDescription();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      buildWhen: (previous, current) =>
          previous.description != current.description ||
          previous.isDescriptionValid != current.isDescriptionValid,
      builder: (context, state) {
        final isEventDescriptionError =
            (state.description.isNotEmpty && !state.isDescriptionValid);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabel(label: 'Deskripsi'),
            Gap(8),
            InputField(
              onChanged: (description) {
                context
                    .read<CreateEventBloc>()
                    .add(DescriptionChanged(description));
              },
              hintText: 'Tulis deskripsi',
              isError: isEventDescriptionError,
              initialValue: state.description,
              maxLines: 5,
            ),
            if (isEventDescriptionError)
              Column(
                children: [
                  Gap(4),
                  Text(
                    'Deskripsi harus diisi dan minimal 10 karakter',
                    style: titleTwoMedium.copyWith(color: primaryBase),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _InputEventLocation extends StatelessWidget {
  const _InputEventLocation();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      buildWhen: (previous, current) =>
          previous.location != current.location ||
          previous.isLocationValid != current.isLocationValid,
      builder: (context, state) {
        final isLocationError =
            state.location.isNotEmpty && !state.isLocationValid;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputLabel(label: 'Alamat'),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Buka Peta',
                    style: titleTwo.copyWith(
                        color: primaryBase,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryBase),
                  ),
                ),
              ],
            ),
            Gap(8),
            InputField(
              onChanged: (location) {
                context.read<CreateEventBloc>().add(LocationChanged(location));
              },
              isError: isLocationError,
              hintText: 'Tulis alamat',
              initialValue: state.location,
            ),
            if (isLocationError)
              Column(
                children: [
                  Gap(4),
                  Text(
                    'Alamat harus diisi dan minimal 5 karakter',
                    style: titleTwoMedium.copyWith(color: primaryBase),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _InputEventDate extends StatelessWidget {
  const _InputEventDate();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      buildWhen: (previous, current) =>
          previous.date != current.date ||
          previous.isDateValid != current.isDateValid,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabel(label: 'Tanggal'),
            Gap(8),
            GestureDetector(
              onTap: () async {
                final date = await CustomCalendarPicker.show(context,
                    initialDate: state.date);

                if (date != null) {
                  context.read<CreateEventBloc>().add(DateChanged(date));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: !state.isDateValid ? primaryBase : neutral20),
                ),
                padding: const EdgeInsets.fromLTRB(16, 2, 4, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy', 'id').format(state.date),
                      style: titleOne.copyWith(color: neutral40),
                    ),
                    date.copyWith(color: neutralBase),
                  ],
                ),
              ),
            ),
            if (!state.isDateValid)
              Column(
                children: [
                  Gap(4),
                  Text(
                    'Tanggal tidak boleh hari kemarin',
                    style: titleTwoMedium.copyWith(color: primaryBase),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _InputEventStart extends StatelessWidget {
  const _InputEventStart();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      buildWhen: (previous, current) =>
          previous.start != current.start ||
          previous.isStartValid != current.isStartValid,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabel(label: 'Waktu'),
            Gap(8),
            GestureDetector(
              onTap: () async {
                await CustomTimePickerInput.show(context,
                    initialTime: state.start, onTimeChanged: (TimeOfDay time) {
                  context.read<CreateEventBloc>().add(StartTimeChanged(time));
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: !state.isStartValid ? primaryBase : neutral20),
                ),
                padding: const EdgeInsets.fromLTRB(16, 2, 4, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${state.start.hour.toString().padLeft(2, '0')}:${state.start.minute.toString().padLeft(2, '0')}',
                      style: titleOne.copyWith(color: neutral40),
                    ),
                    clock.copyWith(color: neutralBase),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _InputDressActivities extends StatelessWidget {
  const _InputDressActivities();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      buildWhen: (previous, current) =>
          previous.savedNames != current.savedNames ||
          previous.savedDescriptions != current.savedDescriptions ||
          previous.savedTimeRanges != current.savedTimeRanges ||
          previous.theme != current.theme ||
          previous.dresscode != current.dresscode ||
          previous.isThemeValid != current.isThemeValid ||
          previous.isDresscodeValid != current.isDresscodeValid,
      builder: (context, state) {
        final isThemeAndDressValid =
            state.isThemeValid && state.isDresscodeValid;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabel(label: 'Tambahan'),
            Gap(8),
            GestureDetector(
              onTap: () {
                context.push('/events/activities');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: neutral20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 2, 4, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Aktivitas',
                            style: titleOne.copyWith(color: neutral40),
                          ),
                          angleRight.copyWith(color: neutralBase),
                        ],
                      ),
                    ),
                    if (state.savedNames != null &&
                        state.savedNames!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 1,
                            color: neutral20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 2, 4, 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.savedNames![0],
                                    style: titleOneMedium.copyWith(
                                        color: neutralBase)),
                                Gap(4),
                                Text(
                                    '${state.savedTimeRanges![0].startTime.hour.toString().padLeft(2, '0')}:${state.savedTimeRanges![0].startTime.minute.toString().padLeft(2, '0')} - ${state.savedTimeRanges![0].endTime.hour.toString().padLeft(2, '0')}:${state.savedTimeRanges![0].endTime.minute.toString().padLeft(2, '0')}',
                                    style: titleTwo.copyWith(color: neutral40)),
                                Gap(4),
                                Text(state.savedDescriptions![0],
                                    style: titleTwo.copyWith(color: neutral40)),
                              ],
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
            ),
            Gap(8),
            GestureDetector(
              onTap: () async {
                context.go('/events/dresscode/create');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: neutral20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 2, 4, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pakaian dan Tema',
                            style: titleOne.copyWith(color: neutral40),
                          ),
                          angleRight.copyWith(color: neutralBase),
                        ],
                      ),
                    ),
                    if (isThemeAndDressValid)
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 1,
                            color: neutral20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 2, 4, 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tema',
                                        style:
                                            titleTwo.copyWith(color: neutral40),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        state.theme,
                                        style: titleOneMedium.copyWith(
                                            color: neutralBase),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pakaian',
                                        style: titleTwo.copyWith(
                                            color: neutralBase),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        state.dresscode,
                                        style: titleOneMedium.copyWith(
                                            color: neutralBase),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
