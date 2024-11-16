import 'package:equatable/equatable.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';

abstract class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpVerificationState {}

class OtpLoading extends OtpVerificationState {}

class OtpSuccess extends OtpVerificationState {}

class OtpFailure extends OtpVerificationState {
  final AuthStatusType status;
  final String message;

  const OtpFailure(this.status, {required this.message});

  @override
  List<Object?> get props => [message];
}
