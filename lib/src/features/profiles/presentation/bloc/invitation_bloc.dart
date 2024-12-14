import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/profiles/domain/use_case/get_invitation_use_case.dart';
import 'package:mesran_app/src/features/profiles/domain/use_case/get_invitations_use_case.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/invitation_event.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final GetInvitationUseCase getInvitationUseCase;
  final GetInvitationsUseCase getInvitationsUseCase;

  InvitationBloc(this.getInvitationUseCase, this.getInvitationsUseCase)
      : super(InvitationState(event: null)) {
    on<InvitationLoad>(_onLoadInvitation);
    on<InvitationsLoad>(_onLoadInvitations);
  }
  void _onLoadInvitation(
      InvitationLoad event, Emitter<InvitationState> emit) async {
    emit(InvitationLoading());
    try {
      final result = await getInvitationUseCase.call(event.id);
      result.fold((_) => emit(InvitationError('Gagal mendapat undangan')),
          (event) => emit(InvitationLoaded(event)));
    } catch (error) {
      emit(InvitationError('Gagal mendapatkan undangan'));
    }
  }

  void _onLoadInvitations(
      InvitationsLoad event, Emitter<InvitationState> emit) async {
    emit(InvitationsLoading());

    try {
      final result = await getInvitationsUseCase.call();

      result.fold(
          (error) => emit(InvitationsError('Gagal Mendapatkan undangan')),
          (events) => emit(InvitationsLoaded(events)));
    } catch (error) {
      emit(InvitationsError('Gagal mendapatkan undangan'));
    }
  }
}
