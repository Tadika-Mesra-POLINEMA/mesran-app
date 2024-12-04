import 'package:isar/isar.dart';

part 'activity.g.dart';

@Collection()
class Activity {
  Id id = Isar.autoIncrement;

  late String name;
  late String description;

  @Name('activity_start')
  late DateTime activityStart;

  @Name('activity_end')
  late DateTime activityEnd;

  @Name('duration_seconds')
  late int durationSeconds;

  @ignore
  Duration get duration => activityEnd.difference(activityStart);
}
