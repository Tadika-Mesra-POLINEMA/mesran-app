import 'package:mesran_app/src/shared/presentation/widgets/form/custom_time_range_picker_input.dart';

class AddActivityEvent {
  AddActivityEvent();
}

class TitleChanged extends AddActivityEvent {
  final String changedTitle;

  TitleChanged({required this.changedTitle});
}

class DescriptionChanged extends AddActivityEvent {
  final String changedDescription;

  DescriptionChanged({required this.changedDescription});
}

class TimeRangeChanged extends AddActivityEvent {
  final TimeRange timeRange;

  TimeRangeChanged({required this.timeRange});
}

class AddActivity extends AddActivityEvent {
  final String eventId;

  AddActivity({required this.eventId});
}
