import 'package:equatable/equatable.dart';

abstract class PrivateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatePrivate extends PrivateEvent {
  final String email;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  UpdatePrivate(
    this.email,
    this.oldPassword,
    this.newPassword,
    this.confirmPassword,
  );

  @override
  List<Object> get props => [email, oldPassword, newPassword, confirmPassword];
}

class EmailChanged extends PrivateEvent {
  final String email;

  EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class OldPasswordChanged extends PrivateEvent {
  final String oldPassword;

  OldPasswordChanged(this.oldPassword);

  @override
  List<Object> get props => [oldPassword];
}

class NewPasswordChanged extends PrivateEvent {
  final String newPassword;

  NewPasswordChanged(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}

class ConfirmPasswordChanged extends PrivateEvent {
  final String confirmPassword;

  ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}
