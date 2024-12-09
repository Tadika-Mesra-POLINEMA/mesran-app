import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_calendar_input.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_input.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';

class EditEventForm extends StatefulWidget {
  const EditEventForm({super.key});

  @override
  State<EditEventForm> createState() => EditEventFormState();
}

class EditEventFormState extends State<EditEventForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _InputName(),
        Gap(16),
        _InputDescription(),
        Gap(16),
        _InputLocation(),
        Gap(16),
        _InputDate(),
        Gap(16),
        _InputStart(),
      ],
    );
  }
}

class _InputName extends StatelessWidget {
  const _InputName();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        InputLabel(label: 'Nama Acara'),
        InputField(
          hintText: 'test',
          initialValue: 'oasidjasoidj',
        ),
      ],
    );
  }
}

class _InputDescription extends StatelessWidget {
  const _InputDescription();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        InputLabel(label: 'Deskripsi Acara'),
        InputField(
          hintText: 'Deskripsi Acara',
          initialValue: 'oasidjasoidj',
        ),
      ],
    );
  }
}

class _InputLocation extends StatelessWidget {
  const _InputLocation();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        InputLabel(label: 'Lokasi Acara'),
        InputField(
          hintText: 'Lokasi Acara',
          initialValue: 'oasidjasoidj',
        ),
      ],
    );
  }
}

class _InputDate extends StatelessWidget {
  const _InputDate();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(label: 'Tanggal'),
        Gap(8),
        GestureDetector(
          onTap: () async {
            final date = await CustomCalendarPicker.show(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: false ? primaryBase : neutral20),
            ),
            padding: const EdgeInsets.fromLTRB(16, 2, 4, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd MMMM yyyy', 'id').format(DateTime.now()),
                  style: titleOne.copyWith(color: neutral40),
                ),
                date.copyWith(color: neutralBase),
              ],
            ),
          ),
        ),
        if (false)
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
  }
}

class _InputStart extends StatelessWidget {
  const _InputStart();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(label: 'Waktu'),
        Gap(8),
        GestureDetector(
          onTap: () async {
            await CustomTimePickerInput.show(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: false ? primaryBase : neutral20),
            ),
            padding: const EdgeInsets.fromLTRB(16, 2, 4, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${state.start.hour.toString().padLeft(2, '0')}:${state.start.minute.toString().padLeft(2, '0')}',
                  '00:00',
                  style: titleOne.copyWith(color: neutral40),
                ),
                clock.copyWith(color: neutralBase),
              ],
            ),
          ),
        )
      ],
    );
  }
}
