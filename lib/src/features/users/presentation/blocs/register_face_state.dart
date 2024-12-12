import 'package:equatable/equatable.dart';
import 'package:mesran_app/src/features/users/domain/entity/get_user_response.dart';

class RegisterFaceState extends Equatable {
  final List<String> paths;
  final int capturedCount;
  final GetUserResponse? user;

  const RegisterFaceState({
    this.paths = const [],
    this.capturedCount = 0,
    this.user,
  });

  RegisterFaceState copyWith(
      {List<String>? paths, int? capturedCount, GetUserResponse? user}) {
    return RegisterFaceState(
      paths: paths ?? this.paths,
      capturedCount: capturedCount ?? this.capturedCount,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [paths, capturedCount];
}

class RegisterFaceInitial extends RegisterFaceState {}

class RegisterFaceSuccess extends RegisterFaceState {}

class RegisterFaceLoading extends RegisterFaceState {
  const RegisterFaceLoading({
    required super.capturedCount,
    required super.paths,
    super.user,
  });

  @override
  List<Object?> get props => [capturedCount, paths, user];
}

class VerifyingFace extends RegisterFaceState {
  const VerifyingFace({
    required super.capturedCount,
    required super.paths,
    super.user,
  });

  @override
  List<Object?> get props => [capturedCount, paths, user];
}

class VerifyFaceFailed extends RegisterFaceState {
  final String message;

  const VerifyFaceFailed({
    required super.capturedCount,
    required super.paths,
    super.user,
    required this.message,
  });

  @override
  List<Object?> get props => [capturedCount, paths, user, message];
}

class RegisterFaceFailure extends RegisterFaceState {
  final String message;

  const RegisterFaceFailure(this.message);

  @override
  List<Object?> get props => [message];
}
