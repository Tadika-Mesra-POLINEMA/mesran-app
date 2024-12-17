import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class NameChanged extends AccountState {
  final String name;

  NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class PhoneChanged extends AccountState {
  final String phone;

  PhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {}

class AccountFailure extends AccountState {
  final String message;

  AccountFailure(this.message);

  @override
  List<Object> get props => [message];
}
