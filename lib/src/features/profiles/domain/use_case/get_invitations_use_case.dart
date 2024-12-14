import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/domain/entities/event.dart';
import 'package:mesran_app/src/features/profiles/data/repository/invitation_repository_impl.dart';

class GetInvitationsUseCase {
  final InvitationRepositoryImpl _invitationRepositoryImpl;

  GetInvitationsUseCase(this._invitationRepositoryImpl);
  Future<Either<Null, List<Event>>> call() async {
    return await _invitationRepositoryImpl.getEvents();
  }
}
