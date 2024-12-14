import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/domain/entities/event.dart';
import 'package:mesran_app/src/features/events/domain/repository/abstract_event_repository.dart';
import 'package:mesran_app/src/features/profiles/data/data_source/invitation_data_source.dart';
import 'package:mesran_app/src/features/profiles/domain/repository/abstract_invitation_repository.dart';

class InvitationRepositoryImpl extends AbstractInvitationRepository {
  final InvitationDataSource _invitationDataSource;

  InvitationRepositoryImpl(this._invitationDataSource);
  @override
  Future<Either<Null, Event>> getEvent(String id) async {
    return await _invitationDataSource.fetchEvent(id);
  }
  
  @override
  Future<Either<Null, List<Event>>> getEvents() async {
    return await _invitationDataSource.fetchEvents();
  }
}
