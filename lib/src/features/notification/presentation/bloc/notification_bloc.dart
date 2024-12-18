import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/notification/domain/use_case/accept_invitation_use_case.dart';
import 'package:mesran_app/src/features/notification/domain/use_case/decline_invitation_use_case.dart';
import 'package:mesran_app/src/features/notification/domain/use_case/get_notification_use_case.dart';
import 'package:mesran_app/src/features/notification/presentation/bloc/notification_event.dart';
import 'package:mesran_app/src/features/notification/presentation/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationUseCase _getNotificationUseCase;
  final AcceptInvitationUseCase _acceptInvitationUseCase;
  final DeclineInvitationUseCase _declineInvitationUseCase;

  NotificationBloc(this._getNotificationUseCase, this._acceptInvitationUseCase,
      this._declineInvitationUseCase)
      : super(NotificationInitial(const [])) {
    on<NotificationLoadEvent>(_onLoadNotification);
    on<AcceptGuest>(_onNotificationAccept);
    on<DeclineGuest>(_onNotificationDecline);
  }

  void _onLoadNotification(
    NotificationLoadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading(state.notifications));

    try {
      final response = await _getNotificationUseCase.call();

      response.fold(
        (l) => emit(NotificationEmpty(const [])),
        (r) => emit(NotificationLoaded(r.isNotEmpty, r)),
      );
    } catch (error) {
      emit(NotificationError('Failed to load notifications'));
    }
  }

  void _onNotificationAccept(
    AcceptGuest event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading(state.notifications));

    try {
      final acceptSucceed =
          await _acceptInvitationUseCase.call(event.eventId, event.userId);

      if (acceptSucceed) {
        final response = await _getNotificationUseCase.call();

        response.fold(
          (l) => emit(NotificationEmpty(const [])),
          (r) => emit(NotificationLoaded(r.isNotEmpty, r)),
        );
      } else {
        emit(NotificationError('Failed to accept guest'));
      }
    } catch (error) {
      emit(NotificationError('Failed to accept guest'));
    }
  }

  void _onNotificationDecline(
    DeclineGuest event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading(state.notifications));

    try {
      final declineSucceed =
          await _declineInvitationUseCase.call(event.eventId, event.userId);

      if (declineSucceed) {
        final response = await _getNotificationUseCase.call();

        response.fold(
          (l) => emit(NotificationEmpty(const [])),
          (r) => emit(NotificationLoaded(r.isNotEmpty, r)),
        );
      } else {
        emit(NotificationError('Failed to decline guest'));
      }
    } catch (error) {
      emit(NotificationError('Failed to decline guest'));
    }
  }
}
