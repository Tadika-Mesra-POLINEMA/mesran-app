// register_state.dart
import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String username;
  final String phone;
  final RegisterStatus status;
  final String? errorMessage;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isUsernameValid;
  final bool isPhoneValid;

  const RegisterState({
    this.email = '',
    this.password = '',
    this.username = '',
    this.phone = '',
    this.status = RegisterStatus.initial,
    this.errorMessage,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
    this.isUsernameValid = false,
    this.isPhoneValid = false,
  });

  bool get isFormValid =>
      isEmailValid &&
      isPasswordValid &&
      isConfirmPasswordValid &&
      isUsernameValid &&
      isPhoneValid &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      username.isNotEmpty &&
      phone.isNotEmpty;

  RegisterState copyWith({
    String? email,
    String? password,
    String? username,
    String? phone,
    RegisterStatus? status,
    String? errorMessage,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isUsernameValid,
    bool? isPhoneValid,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        username,
        phone,
        status,
        errorMessage,
        isEmailValid,
        isPasswordValid,
        isConfirmPasswordValid,
        isUsernameValid,
        isPhoneValid,
      ];
}
