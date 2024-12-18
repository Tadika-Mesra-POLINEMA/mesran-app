abstract class AbstractInvitationRepository {
  Future<bool> acceptInvitation(String eventId, String userId);
  Future<bool> declineInvitation(String eventId, String userId);
}
