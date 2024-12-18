import 'package:mesran_app/src/features/notification/data/data_source/invitation_data_source.dart';
import 'package:mesran_app/src/features/notification/domain/repository/abstract_invitation_repository.dart';

class InvitationRepositoryImpl extends AbstractInvitationRepository {
  final InvitationDataSource _invitationDataSource;

  InvitationRepositoryImpl(this._invitationDataSource);

  @override
  Future<bool> acceptInvitation(String eventId, String userId) async {
    return await _invitationDataSource.acceptInvitation(eventId, userId);
  }

  @override
  Future<bool> declineInvitation(String eventId, String userId) async {
    return await _invitationDataSource.declineInvitation(eventId, userId);
  }
}
