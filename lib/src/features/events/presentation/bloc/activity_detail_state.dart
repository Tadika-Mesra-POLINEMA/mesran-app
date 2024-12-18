import 'package:equatable/equatable.dart';
import 'package:mesran_app/src/features/events/domain/entities/activity.dart';

class ActivityDetailState extends Equatable {
  final List<Activity> activities;

  const ActivityDetailState({required this.activities});

  ActivityDetailState copyWith({
    List<Activity>? activities,
  }) {
    return ActivityDetailState(
      activities: activities ?? this.activities,
    );
  }

  @override
  List<Object?> get props => [activities];
}

class ActivityDetailInitial extends ActivityDetailState {
  ActivityDetailInitial() : super(activities: []);
}

class ActivityDetailLoading extends ActivityDetailState {
  const ActivityDetailLoading({required super.activities});
}

class ActivityDetailLoaded extends ActivityDetailState {
  const ActivityDetailLoaded({required super.activities});
}

class ActivityDetailError extends ActivityDetailState {
  final String message;

  ActivityDetailError(this.message) : super(activities: []);
}
