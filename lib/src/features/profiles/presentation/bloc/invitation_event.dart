class InvitationEvent {
  const InvitationEvent();
}

class InvitationLoad extends InvitationEvent {
  final String id;
  const InvitationLoad(this.id);
}
class InvitationsLoad extends InvitationEvent{}
