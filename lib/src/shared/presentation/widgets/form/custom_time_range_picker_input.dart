import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class TimeRange {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const TimeRange({
    required this.startTime,
    required this.endTime,
  });
}

class CustomTimeRangePickerInput {
  static Future<TimeRange?> show(
    BuildContext context, {
    TimeOfDay? initialStartTime,
    TimeOfDay? initialEndTime,
    Function(TimeRange)? onTimeChanged,
  }) async {
    return await showModalBottomSheet<TimeRange>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TimeRangePickerModal(
        initialStartTime: initialStartTime,
        initialEndTime: initialEndTime,
        onTimeChanged: onTimeChanged,
      ),
    );
  }
}

class _TimeRangePickerModal extends StatefulWidget {
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;
  final Function(TimeRange)? onTimeChanged;

  const _TimeRangePickerModal({
    this.initialStartTime,
    this.initialEndTime,
    this.onTimeChanged,
  });

  @override
  _TimeRangePickerModalState createState() => _TimeRangePickerModalState();
}

class _TimeRangePickerModalState extends State<_TimeRangePickerModal> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late final Function(TimeRange)? onTimeChanged;

  final FixedExtentScrollController _startController =
      FixedExtentScrollController();
  final FixedExtentScrollController _endController =
      FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    _startTime = widget.initialStartTime ?? TimeOfDay(hour: 8, minute: 0);
    _endTime = widget.initialEndTime ?? TimeOfDay(hour: 17, minute: 0);

    _startController.jumpToItem(_startTime.hour);
    _endController.jumpToItem(_endTime.hour);
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
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
            Expanded(child: _buildTimePickerContent()),
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

  Widget _buildTimePickerContent() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: neutral20)),
      child: Row(
        children: [
          Expanded(
            child: _buildTimePicker(
              isStart: true,
              selectedTime: _startTime,
              controller: _startController,
              onTimeChanged: (TimeOfDay time) {
                setState(() {
                  _startTime = time;
                  if (_endTime.hour < _startTime.hour) {
                    _endTime = TimeOfDay(hour: _startTime.hour + 1, minute: 0);
                    _endController.jumpToItem(_endTime.hour);
                  }
                  widget.onTimeChanged?.call(
                      TimeRange(startTime: _startTime, endTime: _endTime));
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              '-',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
          ),
          Expanded(
            child: _buildTimePicker(
              isStart: false,
              selectedTime: _endTime,
              controller: _endController,
              onTimeChanged: (TimeOfDay time) {
                setState(() {
                  _endTime = time;
                  // Validasi waktu saat memilih end time
                  if (_startTime.hour > _endTime.hour) {
                    _startTime = TimeOfDay(hour: _endTime.hour - 1, minute: 0);
                    _startController.jumpToItem(_startTime.hour);
                  }
                  widget.onTimeChanged?.call(
                      TimeRange(startTime: _startTime, endTime: _endTime));
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker({
    required bool isStart,
    required TimeOfDay selectedTime,
    required FixedExtentScrollController controller,
    required Function(TimeOfDay) onTimeChanged,
  }) {
    return CupertinoPicker(
      scrollController: controller,
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
        onTimeChanged(TimeOfDay(hour: index, minute: 0));
      },
      children: List<Widget>.generate(24, (int index) {
        return Center(
          child: Text(
            '${index.toString().padLeft(2, '0')}:00',
            style: TextStyle(
              fontSize: 16,
              color: selectedTime.hour == index ? primaryBase : neutralBase,
              fontWeight: selectedTime.hour == index
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
        // Validasi sebelum menyelesaikan
        if (_startTime.hour >= _endTime.hour) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('End Time harus lebih besar dari Start Time')),
          );
          _endController.jumpToItem(_startTime.hour + 1); // Scroll otomatis
          setState(() {
            _endTime = TimeOfDay(hour: _startTime.hour + 1, minute: 0);
          });
          return;
        }

        Navigator.pop(
          context,
          TimeRange(startTime: _startTime, endTime: _endTime),
        );
      },
      type: ButtonType.primary,
      child: Text(
        'Pilih',
        style: titleOneSemiBold.copyWith(color: white),
      ),
    );
  }
}
