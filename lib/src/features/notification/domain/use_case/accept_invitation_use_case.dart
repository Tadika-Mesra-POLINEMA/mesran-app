import 'package:mesran_app/src/features/notification/data/repository/invitation_repository_impl.dart';

class AcceptInvitationUseCase {
  final InvitationRepositoryImpl _invitationRepositoryImpl;

  AcceptInvitationUseCase(this._invitationRepositoryImpl);

  Future<bool> call(String eventId, String userId) async {
    return await _invitationRepositoryImpl.acceptInvitation(eventId, userId);
  }
}
