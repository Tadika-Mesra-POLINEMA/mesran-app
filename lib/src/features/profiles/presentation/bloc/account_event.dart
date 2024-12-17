import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateAccount extends AccountEvent {
  final String name;
  final String phone;

  UpdateAccount(this.name, this.phone);

  @override
  List<Object> get props => [name, phone];
}

class OnChangeName extends AccountEvent {
  final String name;

  OnChangeName(this.name);

  @override
  List<Object> get props => [name];
}

class OnPhoneChange extends AccountEvent {
  final String phone;

  OnPhoneChange(this.phone);

  @override
  List<Object> get props => [phone];
}
