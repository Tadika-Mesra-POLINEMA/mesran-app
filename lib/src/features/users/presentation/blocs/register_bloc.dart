import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_request.dart';
import 'package:mesran_app/src/features/authentication/domain/use_case/auth_use_case.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_request.dart';
import 'package:mesran_app/src/features/users/domain/usecases/register_use_case.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_event.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;
  final AuthUseCase authUseCase;

  RegisterBloc(this.registerUseCase, this.authUseCase)
      : super(const RegisterState()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterUsernameChanged>(_onNameChanged);
    on<RegisterPhoneChanged>(_onPhoneChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = event.email;
    final isEmailValid = _isEmailValid(email);
    emit(state.copyWith(
      email: email,
      isEmailValid: isEmailValid,
      errorMessage: null,
    ));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = event.password;
    final isPasswordValid = _isPasswordValid(password);
    emit(state.copyWith(
      password: password,
      isPasswordValid: isPasswordValid,
      errorMessage: null,
    ));
  }

  void _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmPassword = event.confirmPassword;
    final isConfirmPasswordValid = _isConfirmPasswordValid(
      state.password,
      confirmPassword,
    );
    emit(state.copyWith(
      isConfirmPasswordValid: isConfirmPasswordValid,
      errorMessage: null,
    ));
  }

  void _onNameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = event.username;
    final isUsernameValid = _isUsernameValid(username);
    emit(state.copyWith(
      username: username,
      isUsernameValid: isUsernameValid,
      errorMessage: null,
    ));
  }

  void _onPhoneChanged(
    RegisterPhoneChanged event,
    Emitter<RegisterState> emit,
  ) {
    final phone = event.phone;
    final isPhoneValid = _isPhoneValid(phone);
    emit(state.copyWith(
      phone: phone,
      isPhoneValid: isPhoneValid,
      errorMessage: null,
    ));
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.isFormValid) {
      emit(state.copyWith(status: RegisterStatus.loading));
      try {
        await registerUseCase.call(RegisterRequest(
          email: state.email,
          password: state.password,
          username: state.username,
          phone: state.phone,
        ));

        // Jika register berhasil, selanjutnya bisa dilakukan login
        authUseCase.login(AuthRequest(
          email: state.email,
          password: state.password,
        ));

        emit(state.copyWith(status: RegisterStatus.success));
      } catch (e) {
        emit(state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    // Minimal 8 karakter, mengandung huruf besar, huruf kecil, dan angka
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  bool _isConfirmPasswordValid(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  bool _isUsernameValid(String name) {
    return name.length >= 3;
  }

  bool _isPhoneValid(String phone) {
    final phoneRegex = RegExp(r'^\+?[\d-]{10,}$');
    return phoneRegex.hasMatch(phone);
  }
}