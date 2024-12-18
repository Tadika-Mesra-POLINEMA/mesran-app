class ActivityDetailEvent {}

class FetchActivityDetail extends ActivityDetailEvent {
  final String eventId;

  FetchActivityDetail({required this.eventId});
}

class RemoveActivity extends ActivityDetailEvent {
  final String eventId;
  final String activityId;

  RemoveActivity({required this.eventId, required this.activityId});
}
