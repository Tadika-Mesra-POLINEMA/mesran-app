import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';
import 'package:mesran_app/src/features/authentication/domain/use_case/verification_use_case.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/verification_event.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  late List<String?> otp;

  final VerificationUseCase verificationUseCase;

  OtpVerificationBloc(this.verificationUseCase) : super(OtpInitial()) {
    on<OtpChanged>(_onOtpChanged);
    on<ResendOtpRequested>(_onResendOtpRequested);
    on<OtpSubmitted>(_onOtpSubmitted);
    on<VerifyFace>(_onVerifyFace);

    otp = List.filled(6, null);
  }

  void _onOtpChanged(OtpChanged event, Emitter<OtpVerificationState> emit) {
    otp[event.index] = event.value;
  }

  void _onResendOtpRequested(
      ResendOtpRequested event, Emitter<OtpVerificationState> emit) {}

  void _onOtpSubmitted(
      OtpSubmitted event, Emitter<OtpVerificationState> emit) async {
    emit(OtpLoading());

    final otpCode = otp.map((code) => code ?? '').join();

    final isOtpValid = this.isOtpValid(otpCode);

    if (!isOtpValid) {
      emit(OtpFailure(AuthStatusType.fail, message: 'Kode OTP tidak valid'));
      return;
    }

    final response = await verificationUseCase.verify(otpCode);

    response.fold(
      (error) =>
          emit(OtpFailure(AuthStatusType.fail, message: 'Kode OTP salah')),
      (_) => emit(OtpSuccess()),
    );
  }

  void _onVerifyFace(
      VerifyFace event, Emitter<OtpVerificationState> emit) async {
    final response = await verificationUseCase.validateFace();

    if (response) {
      emit(VerifyFaceSuccess());
    } else {
      emit(VerifyFaceFailure(AuthStatusType.fail,
          message: 'Wajah belum terdaftar'));
    }
  }

  bool isOtpValid(String otp) {
    return otp.length == 6;
  }
}
