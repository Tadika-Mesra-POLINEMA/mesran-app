import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class CustomTimePickerInput {
  static Future<TimeOfDay?> show(
    BuildContext context, {
    TimeOfDay? initialTime,
    Function(TimeOfDay)? onTimeChanged,
  }) async {
    return await showModalBottomSheet<TimeOfDay>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TimePickerModal(
        initialTime: initialTime,
        onTimeChanged: onTimeChanged,
      ),
    );
  }
}

class _TimePickerModal extends StatefulWidget {
  final TimeOfDay? initialTime;
  final Function(TimeOfDay)? onTimeChanged;

  const _TimePickerModal({
    this.initialTime,
    this.onTimeChanged,
  });

  @override
  _TimePickerModalState createState() => _TimePickerModalState();
}

class _TimePickerModalState extends State<_TimePickerModal> {
  late TimeOfDay _selectedTime;
  late final Function(TimeOfDay)? onTimeChanged;

  final FixedExtentScrollController _controller = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime ?? TimeOfDay(hour: 8, minute: 0);
    _controller.jumpToItem(_selectedTime.hour);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                color: neutral20,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            _buildHeader(),
            Expanded(child: _buildTimePicker()),
            Gap(24),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pilih Waktu',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildTimePicker() {
    return CupertinoPicker(
      scrollController: _controller,
      itemExtent: 40,
      looping: true,
      selectionOverlay: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: primaryBase, width: 1),
          ),
        ),
      ),
      onSelectedItemChanged: (int index) {
        setState(() {
          _selectedTime = TimeOfDay(hour: index, minute: 0);
          widget.onTimeChanged?.call(_selectedTime);
        });
      },
      children: List<Widget>.generate(24, (int index) {
        return Center(
          child: Text(
            '${index.toString().padLeft(2, '0')}:00',
            style: TextStyle(
              fontSize: 16,
              color: _selectedTime.hour == index ? primaryBase : neutralBase,
              fontWeight: _selectedTime.hour == index
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBottomButton() {
    return Button(
      onPressed: () {
        Navigator.pop(
            context, _selectedTime); // Kembalikan _selectedTime yang benar
      },
      type: ButtonType.primary,
      child: Text(
        'Pilih',
        style: titleOneSemiBold.copyWith(color: white),
      ),
    );
  }
}
