import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/texts/light.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CustomCalendarPicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;

  const CustomCalendarPicker({
    super.key,
    required this.onDateSelected,
    this.initialDate,
  });

  static Future<DateTime?> show(BuildContext context, {DateTime? initialDate}) {
    return showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CustomCalendarPicker(
        initialDate: initialDate,
        onDateSelected: (date) => Navigator.pop(context, date),
      ),
    );
  }

  @override
  State<CustomCalendarPicker> createState() => _CustomCalendarPickerState();
}

class _CustomCalendarPickerState extends State<CustomCalendarPicker> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  final kToday = DateTime.now();
  late final kFirstDay = DateTime(kToday.year - 1, kToday.month, kToday.day);
  late final kLastDay = DateTime(kToday.year + 1, kToday.month, kToday.day);

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate ?? DateTime.now();
    _selectedDay = widget.initialDate ?? DateTime.now();
  }

  String _getMonthYearText(DateTime date) {
    return DateFormat.MMMM('id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              color: neutral20,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pilih Tanggal',
                style: titleOneMedium.copyWith(color: neutralBase),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Gap(12),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: neutral20)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TableCalendar(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    leftChevronIcon: Icon(Icons.chevron_left, color: neutral40),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: neutral40),
                    titleTextFormatter: (date, locale) =>
                        _getMonthYearText(date),
                    headerPadding: EdgeInsets.only(bottom: 16)),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: primaryBase.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: titleTwoSemiBold.copyWith(color: primaryBase),
                  // Selected day decoration
                  selectedDecoration: BoxDecoration(
                    color: primaryBase,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: titleTwoSemiBold.copyWith(color: white),
                  // Default day decoration
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  weekendDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  // Outside days decoration (days from other months)
                  outsideDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  outsideTextStyle: titleTwoLight.copyWith(color: neutral30),
                  // Cell margins
                  cellMargin: const EdgeInsets.all(2),
                  cellPadding: const EdgeInsets.all(0),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: titleTwoSemiBold.copyWith(color: neutral30),
                  weekendStyle: titleTwoSemiBold.copyWith(color: neutral30),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Button(
                onPressed: () => widget.onDateSelected(_selectedDay),
                type: ButtonType.primary,
                child: Text(
                  'Pilih',
                  style: titleOneSemiBold.copyWith(color: white),
                )),
          ),
        ],
      ),
    );
  }
}
