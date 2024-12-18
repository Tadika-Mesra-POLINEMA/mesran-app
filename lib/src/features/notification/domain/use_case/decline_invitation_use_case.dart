import 'package:mesran_app/src/features/notification/data/repository/invitation_repository_impl.dart';

class DeclineInvitationUseCase {
  final InvitationRepositoryImpl _invitationRepositoryImpl;

  DeclineInvitationUseCase(this._invitationRepositoryImpl);

  Future<bool> call(String eventId, String userId) async {
    return await _invitationRepositoryImpl.declineInvitation(eventId, userId);
  }
}
