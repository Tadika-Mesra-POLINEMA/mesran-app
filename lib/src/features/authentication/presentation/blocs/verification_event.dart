import 'package:equatable/equatable.dart';

abstract class OtpVerificationEvent extends Equatable {
  const OtpVerificationEvent();

  @override
  List<Object?> get props => [];
}

class OtpChanged extends OtpVerificationEvent {
  final int index;
  final String value;

  const OtpChanged({required this.index, required this.value});

  @override
  List<Object?> get props => [index, value];
}

class ResendOtpRequested extends OtpVerificationEvent {}

class OtpSubmitted extends OtpVerificationEvent {
  final String otp;

  const OtpSubmitted({required this.otp});

  @override
  List<Object?> get props => [otp];
}

class VerifyFace extends OtpVerificationEvent {}
