import 'package:equatable/equatable.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final AuthStatusType? status;
  final String message;

  AuthFailure(this.status, this.message);

  @override
  List<Object> get props => [message];
}

class AuthFaceSuccess extends AuthState {}

class AuthFaceFailure extends AuthState {
  final String message;

  AuthFaceFailure(this.message);

  @override
  List<Object> get props => [message];
}
