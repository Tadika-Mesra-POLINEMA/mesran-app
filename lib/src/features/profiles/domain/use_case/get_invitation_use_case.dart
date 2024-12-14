import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/domain/entities/event.dart';
import 'package:mesran_app/src/features/profiles/data/repository/invitation_repository_impl.dart';

class GetInvitationUseCase {
  final InvitationRepositoryImpl _invitationRepositoryImpl;

  GetInvitationUseCase(this._invitationRepositoryImpl);
  Future<Either<Null, Event>> call(String id) async {
    return await _invitationRepositoryImpl.getEvent(id);
  }
}
