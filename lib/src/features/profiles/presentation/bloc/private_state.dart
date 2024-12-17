import 'package:equatable/equatable.dart';

abstract class PrivateState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmailChangedState extends PrivateState {
  final String email;

  EmailChangedState(this.email);

  @override
  List<Object> get props => [email];
}

class OldPasswordChangedState extends PrivateState {
  final String oldPassword;

  OldPasswordChangedState(this.oldPassword);

  @override
  List<Object> get props => [oldPassword];
}

class NewPasswordChangedState extends PrivateState {
  final String newPassword;

  NewPasswordChangedState(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}

class ConfirmPasswordChangedState extends PrivateState {
  final String confirmPassword;

  ConfirmPasswordChangedState(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class PrivateInitial extends PrivateState {}

class PrivateLoading extends PrivateState {}

class PrivateSuccess extends PrivateState {}

class PrivateFailure extends PrivateState {
  final String message;

  PrivateFailure(this.message);

  @override
  List<Object> get props => [message];
}
