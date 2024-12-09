import 'package:equatable/equatable.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_request.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final AuthRequest authRequest;

  LoginEvent(this.authRequest);

  @override
  List<Object> get props => [authRequest];
}

class VerifyFace extends AuthEvent {}
