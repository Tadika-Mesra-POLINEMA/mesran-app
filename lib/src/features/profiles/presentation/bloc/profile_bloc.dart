import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/profiles/domain/use_case/get_profile_use_case.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/profile_event.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  ProfileBloc(this.getProfileUseCase)
      : super(ProfileState(isLoading: false, user: null)) {
    on<ProfileLoad>(_onLoadProfile);
  }
  void _onLoadProfile(ProfileLoad event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final result = await getProfileUseCase.call();
      result.fold((_) => emit(ProfileLoadError('Gagal mendapat user')),
          (user) => emit(ProfileLoaded(user)));
    } catch (error) {
      emit(ProfileLoadError('Gagal mendapatkan user'));
    }
  }
}
