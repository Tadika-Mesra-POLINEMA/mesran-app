import 'package:equatable/equatable.dart';
import 'package:mesran_app/src/features/notification/domain/entity/notification.dart';

class NotificationState extends Equatable {
  final List<Notification> notifications;

  const NotificationState(this.notifications);

  @override
  List<Object> get props => [
        notifications,
      ];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial(super.notifications);
}

class NotificationLoading extends NotificationState {
  const NotificationLoading(super.notifications);
}

class NotificationLoaded extends NotificationState {
  final bool hasNotifications;
  final List<Notification> fetchedNotification;

  const NotificationLoaded(this.hasNotifications, this.fetchedNotification)
      : super(fetchedNotification);

  @override
  List<Object> get props => [hasNotifications];
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message) : super([]);

  @override
  List<Object> get props => [message];
}

class NotificationEmpty extends NotificationState {
  const NotificationEmpty(super.notifications);
}

class NotificationDeclined extends NotificationState {
  const NotificationDeclined(super.notifications);
}

class NotificationAccepted extends NotificationState {
  const NotificationAccepted(super.notifications);
}
