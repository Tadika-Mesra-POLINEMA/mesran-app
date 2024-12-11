import 'package:mesran_app/src/features/profiles/domain/entity/user.dart';

class ProfileState {
  final bool isLoading;
  final User? user;

  ProfileState({required this.isLoading, required this.user});
}

class ProfileLoaded extends ProfileState {
  final User user;

  ProfileLoaded(this.user) : super(isLoading: false, user: user);
}

class ProfileLoading extends ProfileState {
  ProfileLoading() : super(isLoading: true, user: null);
}

class ProfileLoadError extends ProfileState {
  final String message;

  ProfileLoadError(this.message):super(isLoading: false,user: null);
}
